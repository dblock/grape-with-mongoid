$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'api'))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'app'))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'models'))
$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'boot'

Bundler.require :default, ENV['RACK_ENV']

['../../config/initializers/*.rb', '../../models/*.rb', '../../api/*.rb'].each do |path|
  Dir[File.expand_path(path, __FILE__)].each do |f|
    require f
  end
end

require 'api'
require 'acme_app'
