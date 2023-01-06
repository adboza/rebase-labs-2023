require 'sidekiq'

class MyJob
  include Sidekiq::Job

  def perform(csv)
    puts '$$$$$$$$$ got inside perform(csv) $$$$$$$$$$$$'

    ImportFromCsv.insert_data(csv_path)
  end
end