require 'sidekiq'
require_relative '../../import_from_csv.rb'
require 'csv'
require 'json'

class MyJob
  include Sidekiq::Job

  def perform(json_file)
    # puts '$$$$$$$$$ got inside perform(csv) Its done!! $$$$$$$$$$$$'
    # puts '%%%%%%%%%%%%%%%%%%% Here comes the Json file'
    # puts json_file
    # puts '%%%%%%%%%%%%%%%%%%% Json file ended'

    # csv = CSV.generate do |c|
    #   JSON.parse(json_file).each do |hash|
    #     puts "%%%%%%%%%%%%%%%%%%% Here comes the hash content: ==#{hash}== inside json inside myjob"
    #     hash.each_value do |cell|
    #       puts "%%%%%%%%%%%%%%%%%%% Here comes the hash cell value content: ==#{cell}== inside json inside myjob"
    #       c << cell
    #     end
    #   end
    # end
    # puts "%%%%%%%%%%% From JSON to CSV file #{csv.class} %%%%%%%%%%%%%%%"
    ImportFromCsv.new.insert_data(json_file)
  end
end