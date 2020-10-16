require 'json'
require 'byebug'

class FileReadWrite
  attr_reader :file

  def initialize(file_path, mode)
    @file = File.open(file_path, mode)
  end

  def read
    lines = file.read.split(/\n/)
    file.close

    lines.map{ |line| JSON.parse(line, symbolize_names: true) }
  end

  def write(content)
    serialized_content = content.map{ |item| p item.to_json }.join("\n")
    file.write(serialized_content)
    file.close
  end
end
