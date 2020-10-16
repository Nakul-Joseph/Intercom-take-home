require 'byebug'

class GreatCircleDistance
  EARTH_RADIUS = 6378.137

  attr_reader :from, :to

  def initialize(from:, to:)
    @from = from
    @to = to
  end

  def calculate
    lat1, lon1, lat2, lon2 = [ from[:latitude].to_f, from[:longitude].to_f,
                               to[:latitude].to_f, to[:longitude].to_f ].map{ |degrees| to_radians(degrees) }
    central_angle = central_angle(lat1,lon1,lat2,lon2)
    (central_angle * EARTH_RADIUS).round(3)
  end

  private

  def to_radians(degrees)
    degrees * (Math::PI/180)
  end

  def central_angle(lat1,lon1,lat2,lon2)
    # 2*arcsin(sqrt( Sin2(deltalat/2) + Coslat1 * Coslat2 * Sin2(deltalon/2))
    delta_lon = (lon2 - lon1).abs
    delte_lat = (lat2 - lat1).abs
    #Math.acos((Math.sin(lat1) * Math.sin(lat2)) + (Math.cos(lat1) * Math.cos(lat2) * Math.cos(delta_lon)))
    eqn = (Math.sin(delte_lat/2)**2) + (Math.cos(lat1) * Math.cos(lat2) * (Math.sin(delta_lon/2)**2))
    2 * Math.asin(Math.sqrt(eqn))
  end
end
