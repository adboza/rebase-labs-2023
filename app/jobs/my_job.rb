require 'sidekiq'
require_relative '../../import_from_csv.rb'
require 'csv'
require 'json'

class MyJob
  include Sidekiq::Job

  def perform(json_file)
    puts '$$$$$$$$$ got inside perform(csv) Its done!! $$$$$$$$$$$$'
    csv = CSV.generate do |c|
      JSON.parse(json_file).each do |hash|
        c << hash.values
      end
    end
    puts csv
    ImportFromCsv.new.insert_data(csv)
  end
end