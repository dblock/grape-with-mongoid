module Acme
  class App
    def self.instance
      @instance ||= Rack::Builder.new do
        use Rack::Cors do
          allow do
            origins '*'
            resource '*', headers: :any, methods: :get
          end
        end

        run Acme::App.new
      end.to_app
    end

    def call(env)
      Acme::API.call(env)
    end
  end
end
