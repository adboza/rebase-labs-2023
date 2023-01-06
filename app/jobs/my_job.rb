require 'sidekiq'
require_relative '../../import_from_csv'


class MyJob
  include Sidekiq::Job

  def perform(csv)
    puts '$$$$$$$$$ got inside perform(csv) Its done!! $$$$$$$$$$$$'

    ImportFromCsv.insert_data(csv)
  end
end