module Acme
  class API < Grape::API
    prefix 'api'
    format :json
    mount ::Acme::Crud
    add_swagger_documentation api_version: 'v1'
  end
end
