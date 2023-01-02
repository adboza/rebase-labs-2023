require 'spec_helper'

RSpec.describe 'Loading the app under test', type: :feature do
  it 'displays the home page' do
    puts 'Capybara test started'

    visit '/'
    expect(page).to have_content 'Dragon'

    puts 'Capybara test finished'
    puts '¸¸♬·¯·♩¸¸♪·¯·♫¸¸Happy Dance¸¸♬·¯·♩¸¸♪·¯·♫¸¸'
  end
end