require 'rspec'
require 'rack/test'
require_relative '../server.rb'


describe 'Encontra resultados a partir do banco de dados' do
  it 'get /tests com sucesso' do
    get 'http://localhost:3000/tests'

    expect(response).to have_http_status 200
  end
end
