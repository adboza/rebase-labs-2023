require 'spec_helper'
require './app'

RSpec.describe 'Encontra resultados a partir do banco de dados', type: :feature do

  def app
    Sinatra::Application    
  end
  
  it 'GET /tests' do

    get('/tests')

    expect(last_response.status).to eq 200
    expect(last_response.body).to have_content 'estado_patiente'
  end

  it 'get / com sucesso' do

    get('/')

    expect(last_response.status).to eq 200
    expect(last_response.body).to have_content('Healthy Dragon Laboratórios')
    expect(last_response.body).to have_content('A Healthy Dragon realiza análises laboratoriais com excelência!')
    expect(last_response.body).to have_button('Exibe todo DB')
  end


  it 'get /exams/count' do

    get('/exams/count')
    json_response = JSON.parse(last_response.body)

    expect(last_response.status).to eq 200
    expect(last_response.body).to have_content('count')
    expect(json_response.length).to eq 1
  end


  it 'get /tests_list/limit/*/offset/*' do

    get('/tests_list/limit/100/offset/30')
    json_response = JSON.parse(last_response.body)

    expect(last_response.status).to eq 200
    expect(last_response.body).to have_content 'estado_patiente'
    expect(json_response.length).to eq 100
  end

  it 'get /tests/:token' do

    get('/tests/TJUXC2')
    json_response = JSON.parse(last_response.body)

    expect(last_response.body).to have_content('TJUXC2')
    expect(last_response.status).to eq 200
    expect(json_response.length).to eq 13
  end
end
