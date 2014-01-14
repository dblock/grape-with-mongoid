module Acme
  class Crud < Grape::API
    format :json
    namespace :widget do
      desc "Returns a widget by id.",
           params: { "_id" => { description: "widget id", required: true } }
      get ":_id" do
        widget = Acme::Models::Widget.find(params[:_id])
        error! "Not Found", 404 unless widget
        widget.as_json
      end
      desc "Updates a widget by id.",
           params: Acme::Models::Widget.fields.merge(
            "_id" => { description: "widget id", required: true }
           )
      put ":_id" do
        widget = Acme::Models::Widget.find(params[:_id])
        error! "Not Found", 404 unless widget
        values = {}
        values[:name] = params[:name] if params.key?(:name)
        values[:number] = params[:number] if params.key?(:number)
        widget.update_attributes!(values)
        widget.as_json
      end
      desc "Deletes a widget by id.",
           params: { "_id" => { description: "widget id", required: true } }
      delete ":_id" do
        widget = Acme::Models::Widget.find(params[:_id])
        error! "Not Found", 404 unless widget
        widget.destroy
        widget.as_json
      end
      desc "Creates a widget.",
           params: Acme::Models::Widget.fields.dup.tap { |fields| fields.delete("_id") }
      post do
        widget = Acme::Models::Widget.create!(
          name: params[:name],
          number: params[:number]
        )
        widget.as_json
      end
    end
    namespace :widgets do
      get do
        Acme::Models::Widget.all.desc(:number).as_json
      end
    end
  end
end
