require 'sidekiq'
require_relative '../../import_from_csv'

class MyJob
  include Sidekiq::Job

  def perform(csv)
    puts '$$$$$$$$$ got inside perform(csv) $$$$$$$$$$$$'

    ImportFromCsv.insert_data(csv_path)
  end
end