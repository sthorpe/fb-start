require 'geokit'

class News < ActiveRecord::Base
  
  include Geokit::Geocoders
  
  def source
    res = Net::HTTP.post_form(URI.parse('http://ws.geonames.org/rssToGeoRSS'), {'feedUrl'=>'http://rss.cnn.com/rss/cnn_topstories.rss'})
    xml = REXML::Document.new(res.body)
    @xmlroot = xml.root
    a = @xmlroot.elements.to_a('channel')
    cc = a.group_by {|b| b.elements['item/title'].text}
    dd = cc.map {|c,l| [c, l.map {|b| MultiGeocoder.geocode(b.elements['item/geo:lat'].text.to_s+","+b.elements['item/geo:long'].text.to_s)}]}.flatten
    return dd
  end
  
  def geocode(city, state, country)
    return MultiGeocoder.geocode(city+","+state+","+country)
  end  
  
end