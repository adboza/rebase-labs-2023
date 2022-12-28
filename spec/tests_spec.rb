require 'rspec'
require_relative '../server.rb'

describe 'Encontra resultados a partir do banco de dados' do
  it 'get /tests com sucesso' do
    get '/'
    expect(get '/tests').to have_http_status 200
  end
end
