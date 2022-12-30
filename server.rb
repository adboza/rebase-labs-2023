require 'sinatra'
require 'rspec'
require 'rack/handler/puma'
require 'csv'
require './app.rb'
require_relative './import_from_csv'

Rack::Handler::Puma.run(
  Sinatra::Application,
  Port: 3000,
  Host: '0.0.0.0'
)