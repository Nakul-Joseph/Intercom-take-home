require 'file_read_write'
require 'tempfile'

RSpec.describe FileReadWrite do

  let(:read_file) { described_class.new(customers_data.path, 'r') }
  let(:write_file) { described_class.new(output_data.path, 'w') }
  let(:test_data) {{"latitude": "52.986375", "longitude": "-6.043701"}}

  let(:customers_data) do
    Tempfile.new('customers.txt').tap do |f|
      f << test_data.to_json 
      f.close
    end
  end

  let(:output_data) { Tempfile.new('output.txt') }

  describe '#read' do
    context 'valid json' do
      it 'reads from the file' do
        expect(read_file.read).to eq([test_data])
      end
    end

    context 'invalid json' do
      before do
        customers_data.open
        customers_data.write('invalid data format')
        customers_data.close
      end

      it 'prints custom error message' do
        expect { read_file.read }.to output("Exception: Invalid JSON file.".to_json + "\n")
                                 .to_stdout
      end
    end
  end

  describe '#write' do
    context 'valid json' do
      it 'prints content to console' do
        expect{ write_file.write([test_data]) }.to output(test_data.to_json.to_json + "\n")
                                               .to_stdout
      end 

      it 'writes to the file' do
        expect(write_file.write([test_data])).to eq(test_data.to_json.size)
      end
    end

    context 'invalid json' do
      it 'prints custom error message' do
        expect { write_file.write('hello') }.to output("Exception: NoMethodError".to_json + "\n")
                                            .to_stdout
      end
    end
  end
end
