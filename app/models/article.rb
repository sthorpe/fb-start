require 'sanitize'
class Article
  @@attr_names = ["title", "description", "link", "geo_lat", "geo_long"]
  attr_accessor *@@attr_names
  attr_accessor :location
  include Geokit::Geocoders
  
  def initialize(object)
    if object
      @@attr_names.each do |attr_name|
        if object.has_key?(attr_name.to_sym)
          self.send "#{attr_name}=", object.fetch(attr_name.to_sym)
        end
      end
    end
  end
  
  def sanitized_description
    return Sanitize.clean(strip_html(self.description))
  end
  
  def strip_html(description) # Automatically strips any tags from any string
    desc = description.gsub(/<\/?[^>]*>/,  "")
    return desc
  end
  
  def location
    return self.geo_lat+","+self.geo_long unless self.geo_lat.blank?
  end
  
  # Finding friends within 200 miles of this location.
  def friends(facebook_session, friends_location)
    #FacebookFriends.asynch_getfriendslocation(self.location, facebook_session, friends_location)
    article_friends = []
    # Find all friends within 200 miles of this article.
    friends_location.each do |friend_location|
       if friend_location[:geo] && self.location
        begin
          if friend_location[:geo].distance_from(self.location, :units=>:miles).round <= 200
            article_friends << {:name => friend_location[:name], :uid => friend_location[:uid], :geo => friend_location[:geo]}
            puts "This user is good! #{friend_location[:name]}"
          end
        rescue Exception => e 
          puts "Error with Geocoding: #{e} with city: #{location['city']}, state: #{location['state']}, country: #{location['country']}"
        end
       end
    end
    return article_friends
  end  
  
  # This process takes a real long time. Need to build a cache for this.
  def self.friend_geocode(location)
    if location['city'] && location['state'] && location['country']
      return GoogleGeocoder.geocode(location['city']+","+location['state']+","+location['country'])
    end
  end
end
