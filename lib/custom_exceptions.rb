# prints custom exception message.
class CustomExceptions
  attr_accessor :error

  def initialize(error)
    @error = error
  end

  def print_exception
    case error.class.name
    when JSON::ParserError.name
      p 'Exception: Invalid JSON file.'
    else StandardError.name
      p "Exception: #{error.class}"
    end
  end
end
