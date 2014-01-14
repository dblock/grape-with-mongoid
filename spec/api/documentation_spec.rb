require 'spec_helper'

describe Acme::API do
  include Rack::Test::Methods

  def app
    Acme::API
  end

  context "swagger documentation" do
    it "renders" do
      get "/api/swagger_doc"
      last_response.status.should == 200
      json_response = JSON.parse(last_response.body)
      json_response["apiVersion"].should == "v1"
      json_response["apis"].size.should == 1
    end

    it "includes model fields" do
      get "/api/swagger_doc/api"
      last_response.status.should == 200
      json_response = JSON.parse(last_response.body)
      Hash[json_response["apis"].detect { |desc|
        desc["path"] == "/api/widget/{_id}.{format}" && desc["operations"].first["httpMethod"] == "GET"
      }["operations"].first["parameters"].map { |p| [p["name"], p["required"]] }].should == { "_id" => true }
      Hash[json_response["apis"].detect { |desc|
        desc["path"] == "/api/widget.{format}" && desc["operations"].first["httpMethod"] == "POST"
      }["operations"].first["parameters"].map { |p| [p["name"], p["required"]] }].should == { "name" => false, "number" => false }
      Hash[json_response["apis"].detect { |desc|
        desc["path"] == "/api/widget/{_id}.{format}" && desc["operations"].first["httpMethod"] == "PUT"
      }["operations"].first["parameters"].map { |p| [p["name"], p["required"]] }].should == { "_id" => true, "name" => false, "number" => false }
      Hash[json_response["apis"].detect { |desc|
        desc["path"] == "/api/widget/{_id}.{format}" && desc["operations"].first["httpMethod"] == "DELETE"
      }["operations"].first["parameters"].map { |p| [p["name"], p["required"]] }].should == { "_id" => true }
    end
  end
end
