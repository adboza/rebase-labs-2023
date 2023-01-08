require 'sinatra'
require 'rspec'
require 'rack/handler/puma'
require 'csv'
require './app.rb'

Rack::Handler::Puma.run(
  Sinatra::Application,
  Port: 3000,
  Host: '0.0.0.0'
)
