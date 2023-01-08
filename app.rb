require 'sinatra'
require 'rspec'
require 'rack/handler/puma'
require 'csv'
require 'json'
require_relative './db_methods.rb'
require './app/jobs/my_job.rb'

get '/tests' do
  conn = PG.connect(host: 'postgres', dbname: 'medical_records', user: 'postgres')
  exams = conn.exec("SELECT * FROM EXAMS LIMIT 100")
  exams.map { |tuple| tuple }.to_json
end

get '/tests_list/limit/*/offset/*' do
  conn = PG.connect(host: 'postgres', dbname: 'medical_records', user: 'postgres')
  exams = conn.exec("SELECT * FROM EXAMS LIMIT #{params['splat'].first} OFFSET #{params['splat'].last}")
  exams.map { |tuple| tuple }.to_json
end


get '/tests/count' do
  conn = PG.connect(host: 'postgres', dbname: 'medical_records', user: 'postgres')
  exams = conn.exec("SELECT COUNT(id) FROM EXAMS")
  exams.map { |tuple| tuple }.to_json
end

get '/' do
  File.read('./public/index.html')
end

post '/import' do
  csv = params[:results][:tempfile]
  json_file = DbMethods.new.csv_iteration(csv)
  MyJob.perform_async(json_file)
end
