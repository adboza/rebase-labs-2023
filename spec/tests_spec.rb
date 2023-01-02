require 'spec_helper'
require './app'

RSpec.describe 'Encontra resultados a partir do banco de dados', type: :system do

  def app
    Sinatra::Application    
  end
  
  it 'GET /tests' do

    get('/tests')

    expect(last_response.status).to eq 200
    expect(last_response.body).to have_content 'estado_patiente'
  end

  it 'get /tests com sucesso' do

    get('/')

    expect(last_response.status).to eq 200
    expect(last_response.body).to have_content('Healthy Dragon Laboratórios')
    expect(last_response.body).to have_content('A Healthy Dragon realiza análises laboratoriais com excelência!')
    expect(last_response.body).to have_button('Exibe todo DB')
  end
end
