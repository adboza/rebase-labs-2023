require 'sinatra'
require 'rspec'
require 'rack/handler/puma'
require 'csv'
require 'json'
require_relative './import_from_csv'
require './app/jobs/my_job.rb'


get '/json_test' do
  rows = CSV.read("./data.csv", col_sep: ';')

  columns = rows.shift

  rows.map do |row|
    row.each_with_object({}).with_index do |(cell, acc), idx|
      column = columns[idx]
      acc[column] = cell
    end
  end.to_json
end

get '/tests' do
  ImportFromCsv.new
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

get '/hello' do
  'Hello world! updated'
end

get '/' do
  File.read('./public/index.html')
end

post '/import' do
  rows = request.body.read.to_json
  puts rows
  puts "$$$$$$$$$$$$ Is it a file type ?A: =#{rows.class}= this is the answer"
  puts '$$$$$$$$$ got inside post(import) $$$$$$$$$$$$'
  
  MyJob.perform_async(rows)
end
