require 'byebug'

class GreatCircle
  attr_reader :from, :to, :range

  def initialize(from:, to:, range: 100)
    @from = from
    @to = to
    @range = range
  end

  def distance
    byebug
  end

  private

  
end
