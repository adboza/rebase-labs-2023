require 'sidekiq'
require_relative '../../db_methods.rb'
require 'csv'
require 'json'

class MyJob
  include Sidekiq::Job

  def perform(json_file)
    DbMethods.new.insert_data(json_file)
  end
end
