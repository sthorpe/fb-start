class FacebookFriends < Workling::Base 
  def getfriendslocation(article_location, facebook_session, friends_location)
    article_friends = []
    friends_location.each do |friend_location|
      location = friend_location['current_location']
      begin
        if friend_geocode(location).distance_from(article_location, :units=>:miles).round <= 200
          article_friends << friend_location['name']
        end
      rescue Exception => e 
        logger.info("Error with Geocoding: #{e} with #{location}")
      end
    end
    return article_friends
  end
end
