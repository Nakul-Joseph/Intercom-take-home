require 'byebug'

class GreatCircleDistance
  EARTH_RADIUS = 6378.137

  attr_reader :lat1, :lon1, :lat2, :lon2

  def initialize(from:, to:)
    @lat1, @lon1 = extract_lat_lon(from)
    @lat2, @lon2 = extract_lat_lon(to)
  end

  def calculate
    (central_angle * EARTH_RADIUS).round(3)
  end

  private

  def extract_lat_lon(resource)
    [ resource[:latitude].to_f, 
      resource[:longitude].to_f ].map { |deg| to_radians(deg) }
  end

  def to_radians(degrees)
    degrees * (Math::PI/180)
  end

  # implemented haversine formula under 1.1 from https://en.wikipedia.org/wiki/Great-circle_distance
  def central_angle
    delta_lon = (lon2 - lon1).abs
    delta_lat = (lat2 - lat1).abs

    eqn = (Math.sin(delta_lat/2)**2) + (Math.cos(lat1) * Math.cos(lat2) * (Math.sin(delta_lon/2)**2))
    2 * Math.asin(Math.sqrt(eqn))
   end
end
