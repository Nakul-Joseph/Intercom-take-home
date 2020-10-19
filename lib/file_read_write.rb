require 'json'
require_relative 'custom_exceptions'

class FileReadWrite
  attr_reader :file

  def initialize(file_path, mode)
    @file = File.open(file_path, mode)
  rescue StandardError => e
    CustomExceptions.new(e).print_exception
  end

  def read
    lines = file.read.split(/\n/)
    lines.map{ |line| JSON.parse(line, symbolize_names: true) }
  rescue StandardError => e
    CustomExceptions.new(e).print_exception
  ensure
    file.close
  end

  def write(content)
    serialized_content = content.map{ |item| p item.to_json }.join("\n")
    file.write(serialized_content)
  rescue StandardError => e
    CustomExceptions.new(e).print_exception
  ensure
    file.close
  end
end
