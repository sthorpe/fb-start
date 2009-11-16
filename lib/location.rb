require 'geokit'

class location
  
  include Geokit::Geocoders
  
  
  def test
    res = Net::HTTP.post_form(URI.parse('http://ws.geonames.org/rssToGeoRSS'), {'feedUrl'=>'http://rss.cnn.com/rss/cnn_topstories.rss'})
    xml = REXML::Document.new(res.body)
    @xmlroot = xml.root
    a = @xmlroot.elements.to_a('channel')
    cc = a.group_by {|b| b.elements['item/title'].text}
    dd = cc.map {|c,l| [c, l.map {|b| b.elements['item/geo:lat'].text.to_s+","+b.elements['item/geo:long'].text.to_s}]}.flatten
  end
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  def feed_url
    res = Net::HTTP.post_form(URI.parse('http://ws.geonames.org/rssToGeoRSS'), {'feedUrl'=>'http://rss.cnn.com/rss/cnn_topstories.rss'})
    xml = REXML::Document.new(res.body)
    xmlroot = xml.root
    lat = xmlroot.elements["channel"].elements["item"].elements["geo:lat"].text
    long = xmlroot.elements["channel"].elements["item"].elements["geo:long"].text
    loc = MultiGeocoder.geocode(lat,long)
    return loc
  end
  
  def facebook_user(facebook_session)
    @friends = facebook_session.user.friend_lists
    friend_list = Array.new
    @friends.each do |friend|
      friend_list << [friend.current_location ? friend.current_location : friend.hometown_location]
    end
  end
  
  def article_distance_to_facebook_friend(xmlroot)
    distance = loc.distance_from(work, :units => :miles)
  end
  
  
  res = Net::HTTP.post_form(URI.parse('http://ws.geonames.org/rssToGeoRSS'), {'feedUrl'=>'http://rss.cnn.com/rss/cnn_topstories.rss'})
  xml = REXML::Document.new(res.body)
  @xmlroot = xml.root
  @lat = Array.new
  @long = Array.new
  @xmlroot.each_element('//geo:lat') do |element|
    @lat << element.text
  end
  
  @xmlroot.each_element('//geo:long') do |element|
    @long << element.text
  end
  
  # lat = @xmlroot.elements["channel"].elements["item"].elements["geo:lat"].text
  # long = @xmlroot.elements["channel"].elements["item"].elements["geo:long"].text
  # loc = MultiGeocoder.geocode(lat+","+long)
  
  # source = "http://ws.geonames.org/rssToGeoRSS?feedUrl=http://rss.cnn.com/rss/cnn_topstories.rss" # url or local file
  # content = "" # raw content of rss feed will be loaded here
  # open(source) do |s| content = s.read end
  # @rss = RSS::Parser.parse(content, false)
  
  @friends_locations = facebook_session.user.friends_location
  @friend_geo = Array.new
  @friends_locations.each do |friend|
    location = friend['current_location'] or friend['hometown_location']
    friend['geocode'] = nil
    if location
      city = location['city'] if location['city']
      state = location['state'] if location['state']
      country = location['country'] if location['country']
      begin
        @friend_geo << MultiGeocoder.geocode("#{city},#{state},#{country}")
      rescue
      end
    end
  end
  
  @friend_geo.each do |f_geo|
    @distance << loc.distance_from(f_geo, :units => :miles)
  end
  
end