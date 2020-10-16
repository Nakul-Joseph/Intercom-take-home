require 'byebug'
require_relative 'data_reader.rb'
require_relative 'great_circle.rb'

class CustomerInvitation
  OFFICE_FILEPATH = './data/intercom_office.txt'
  CUSTOMERS_FILEPATH = './data/customers.txt'

  attr_reader :office, :customers

  def initialize
    @office = file_readin(OFFICE_FILEPATH)[0]
    @customers = file_readin(CUSTOMERS_FILEPATH)
  end

  def show_list
    customers_with_dist = customers_distance_info 
  end

  private

  def file_readin(file_path)
    DataReader.new(file_path).content
  end

  def customers_distance_info
    distance_info = GreatCircle.new(from: office, to: customers[0]).distance
  end
end
