require 'sinatra'
require 'rack/handler/puma'
require 'csv'
require_relative './import_from_csv'

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
  e_text = []
  puts '$$$$$$$$$$$$$$$$$$ inside server.rb get /tests line 21, '
  ImportFromCsv.new
  puts "$$$$$$$$$$$$$$$$$$ inside server.rb get /tests line 23"


  conn = PG.connect(host: 'postgres', dbname: 'postgres', user: 'postgres')
  exams = conn.exec("SELECT * FROM EXAMS")
  puts "$$$$$$$$$$$$$$$$$$$ #{conn.exec("SELECT * FROM EXAMS")} at line server.rb 28"
  exams.each do |e|
    e_text.unshift({ cpf: e['cpf'], nome_paciente: e['nome_paciente'], email_paciente: e['email_paciente'],
      data_nascimento_paciente: e['data_nascimento_paciente'], endereço_rua_paciente: e['endereço_rua_paciente'],
      cidade_paciente: e['cidade_paciente'], estado_patiente: e['estado_patiente'], crm_médico: e['crm_médico'],
      crm_médico_estado: e['crm_médico_estado'], nome_médico: e['nome_médico'], email_médico: e['email_médico'],
      token_resultado_exame: e['token_resultado_exame'], data_exame: e['data_exame'], tipo_exame: e['tipo_exame'],
      limites_tipo_exame: e['limites_tipo_exame'], resultado_tipo_exame: e['resultado_tipo_exame']},
    )
  end
end

get '/hello' do
  'Hello world! updated'
end

Rack::Handler::Puma.run(
  Sinatra::Application,
  Port: 3000,
  Host: '0.0.0.0'
)