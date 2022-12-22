require 'rails_helper'

RSpec.describe 'Encontra resultados a partir do banco de dados' do
  it 'com sucesso' do
    get '/tests'

    expect(response.status).to eq 200
  end
end
