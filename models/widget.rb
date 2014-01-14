module Acme
  module Models
    class Widget
      include Mongoid::Document

      field :name, type: String, description: "Name of widget."
      field :number, type: Integer, description: "Widget number."
    end
  end
end
