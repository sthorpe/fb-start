class FbFriend < ActiveRecord::Base
  include GeoKit::Mappable
  belongs_to :user
  
  def self.distance_between(a,b)
    r = 3963.0
    dToR = 57.2957795
    Math.acos(Math.sin(a.lat/dToR)*Math.sin(b.lat/dToR)+Math.cos(a.lat/dToR)*Math.cos(b.lat/dToR)*Math.cos(b.lng/dToR-a.lng/dToR))*r
  end
end
