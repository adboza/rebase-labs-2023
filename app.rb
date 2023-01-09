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

get '/tests/:token' do
  conn = PG.connect(host: 'postgres', dbname: 'medical_records', user: 'postgres')
  exams = conn.exec("
                    SELECT token_resultado_exame AS #{'Token'},
                      nome_paciente AS #{'Paciente'},
                      cpf,
                      data_exame,
                      tipo_exame AS #{'Exame'},
                      limites_tipo_exame AS #{'Limites'},
                      resultado_tipo_exame AS #{'Resultado'},
                      crm_médico,
                      crm_médico_estado,
                      nome_médico
                      FROM EXAMS WHERE token_resultado_exame='#{params['token']}'")
  exams.map { |tuple| tuple }.to_json
end


get '/exams/count' do
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
