require 'customer_invitation'
require 'tempfile'

RSpec.describe CustomerInvitation do
  subject { described_class.new }

  let(:office_data) do
    Tempfile.new('office.txt').tap do |f|
      f << { "latitude": "52.986375", "longitude": "-6.043701" }.to_json 
      f.close
    end
  end

  let(:customer_data) do
    Tempfile.new('customer.txt').tap do |f|
      f << {"latitude": "53.339428", "user_id": 21, "name": "test-user1-inside100", "longitude": "-6.257664"}.to_json + "\n"
      f << {"latitude": "53.2451022", "user_id": 2, "name": "test-user2-inside100", "longitude": "-6.238335"}.to_json + "\n"
      f << {"latitude": "51.92893", "user_id": 12, "name": "test-user1-outside100", "longitude": "-10.27699"}.to_json
      f.close
    end
  end

  let(:invalid_data) do
    Tempfile.new('invalid.txt').tap do |f|
      f << {"latitude": "53.339428", "longitude": "-6.257664"}.to_json + "\n"
      f << {"latitude": nil, "longitude": nil}.to_json + "\n"
      f << {"latitude": nil, "user_id": 21, "name": "test-user", "longitude": nil}.to_json
      f.close
    end
  end

  let(:output_data) { Tempfile.new('output.text') }

  describe '#list' do
    before do
      stub_const("#{described_class}::OFFICE_FILEPATH", office_data.path)
      stub_const("#{described_class}::CUSTOMERS_FILEPATH", customer_data.path)
      stub_const("#{described_class}::OUTPUT_FILEPATH", output_data.path)
    end

    context 'customer within 100 km from office' do
      it 'displays sorted list to console' do
        expect { subject.list }.to output("{\"name\":\"test-user2-inside100\",\"user_id\":2}".to_json + "\n"+
                                          "{\"name\":\"test-user1-inside100\",\"user_id\":21}".to_json + "\n") 
                               .to_stdout
      end

      it 'writes sorted list to file' do
        output_file_size = "{\"name\":\"test-user2-inside100\",\"user_id\":2}\n".size +
                           "{\"name\":\"test-user1-inside100\",\"user_id\":21}".size

        expect(subject.list).to eq(output_file_size)
      end

      it 'skips if customer info is empty/invalid' do
        stub_const("#{described_class}::CUSTOMERS_FILEPATH", invalid_data.path)
        expect(subject.list).to eq(0)
      end
    end
  end
end
