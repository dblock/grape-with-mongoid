require 'spec_helper'

describe Acme::API do
  include Rack::Test::Methods

  def app
    Acme::API
  end

  it "returns an empty collection of widgets" do
    get "/api/widgets/"
    last_response.status.should == 200
    last_response.body.should == "[]"
  end

  it "returns 404 if widget does not exist" do
    get "/api/widget/invalid"
    last_response.status.should == 404
    last_response.body.should == '{"error":"Not Found"}'
  end

  it "creates a widget" do
    expect {
      post "/api/widget?name=name&number=1"
      last_response.status.should == 201
    }.to change(Acme::Models::Widget, :count).by(1)
    widget = Acme::Models::Widget.last
    widget.name.should == "name"
    widget.number.should == 1
  end

  context "with widgets" do
    before do
      @widget1 = Acme::Models::Widget.create!(name: 'one', number: 1)
      @widget2 = Acme::Models::Widget.create!(name: 'two', number: 2)
    end
    it "returns a collection of widgets" do
      get "/api/widgets"
      last_response.status.should == 200
      last_response.body.should == [
        @widget2,
        @widget1
      ].to_json
    end
    it "updates a widget" do
      expect {
        put "/api/widget/#{@widget1.id}?name=updated&number=2"
        last_response.status.should == 200
      }.to_not change(Acme::Models::Widget, :count)
      @widget1.reload
      @widget1.name.should == "updated"
      @widget1.number.should == 2
    end
    it "destroys a widget" do
      expect {
        delete "/api/widget/#{@widget1.id}"
        last_response.status.should == 200
      }.to change(Acme::Models::Widget, :count).by(-1)
    end
  end
end
