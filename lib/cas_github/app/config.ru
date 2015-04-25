$:.unshift File.expand_path "..", __FILE__

require 'bundler'
Bundler.require
require "./app"
require 'grape/rabl'

use Rack::Config do |env|
  env['api.tilt.root'] = 'views'
end

use ActiveRecord::ConnectionAdapters::ConnectionManagement

ActiveRecord::Base.establish_connection(
  adapter: "sqlite3",
  database: File.expand_path("../../../../db/development.sqlite3", __FILE__)
)

run CasGithub::API::APP
