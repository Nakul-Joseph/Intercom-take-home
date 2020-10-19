require_relative 'file_read_write'
require_relative 'great_circle_distance'

module InvitationOperations
  OFFICE_FILEPATH = './data/intercom_office.txt'
  CUSTOMERS_FILEPATH = './data/customers.txt'
  OUTPUT_FILEPATH = './data/output.txt'

  private

  def prepare_invitations(office, customers)
    customers.map do |customer|
      distance = calculate_distance(office, customer)
      new_customer_hash(customer, distance)
    end
  end

  def calculate_distance(from, to)
    GreatCircleDistance.new(from: from, to: to).calculate
  end

  def new_customer_hash(customer, distance)
    return unless customer[:name] && customer[:user_id]
    { name: customer[:name], user_id: customer[:user_id], distance: distance }
  end

  def process_invitations(invitations)
    selected_customers = select_customers(invitations)
    sort_customers(selected_customers)
  end

  def select_customers(invitations, range = 100)
    invitations.select do |customer|
      customer.delete(:distance) if customer && customer[:distance] <= range
    end
  end

  def sort_customers(customers)
    customers.sort_by{ |customer| customer[:user_id] }
  end
end
