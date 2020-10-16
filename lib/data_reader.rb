require 'json'

class DataReader
  attr_reader :read_lines

  def initialize(file_path)
    @read_lines = File.read(file_path).split(/\n/)
  end

  def content
    read_lines.map{|read_line| JSON.parse(read_line)}
  end
end
