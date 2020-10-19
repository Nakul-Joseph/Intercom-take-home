require 'great_circle_distance'
require 'haversine'
require 'byebug'

RSpec.describe GreatCircleDistance do
  subject { described_class.new(from: from, to: to) }

  let(:to) {{"latitude": "52.986375", "longitude": "-6.043701"}}
  let(:from) {{"latitude": "53.339428", "longitude": "-6.257664"}}
  let(:radians) { ->(deg) { deg.to_f * Math::PI/180 } }
  let(:haversine_distance) { Haversine.distance(from[:latitude].to_f, from[:longitude].to_f,
                                                to[:latitude].to_f, to[:longitude].to_f)}

  it 'expect EARTH_RADIUS to be constant' do
    expect(described_class::EARTH_RADIUS).to eq(6371)
  end

  it 'converts from degrees to radians' do
    expect(subject.lat1).to eq(radians[from[:latitude]])
  end

  describe '#calculate' do
    it 'returns spherical distance between from and to' do
      # checks if the method returns same value as the haversine gem.
      haversine = haversine_distance.great_circle_distance * 6371
      expect(subject.calculate).to eq(haversine.round(3))
    end
  end
end
