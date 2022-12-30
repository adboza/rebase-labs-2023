require 'spec_helper'
require_relative '../server.rb'

describe 'Encontra resultados a partir do banco de dados', {:type => :feature}  do

  # def app
  #     Sinatra::Application    
  # end
  it 'GET /tests' do
    def app
      Sinatra::Application
    end
    conn =  PG.connect(host: 'postgres', dbname: 'medical_records', user: 'postgres')
    
    result_json = conn.exec('SELECT * FROM TESTS').to_a.to_json

    get('/tests')

    expect(last_response.status).to eq 200
    expect(last_response.body).to eq result_json
  end

  it 'get /tests com sucesso' do
    get('/')
    expect(last_response.body).to eq("")
    expect(last_response.status).to eq 200
  end
end
