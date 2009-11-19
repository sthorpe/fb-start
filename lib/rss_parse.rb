require 'rss/1.0'
require 'rss/2.0'
require 'open-uri'

source = "http://ws.geonames.org/rssToGeoRSS?feedUrl=http://rss.cnn.com/rss/cnn_topstories.rss" # url or local file
content = "" # raw content of rss feed will be loaded here
open(source) do |s| content = s.read end
rss = RSS::Parser.parse(content, true, false)

#res = Net::HTTP.post_form(URI.parse('http://ws.geonames.org/rssToGeoRSS'), {'feedUrl'=>'http://rss.cnn.com/rss/cnn_topstories.rss'})
# xml = REXML::Document.new(res.body)
#     @xmlroot = xml.root
#     a = @xmlroot.elements.to_a('channel')
#     cc = a.group_by {|b| b.elements['item/title'].text}
#     dd = cc.map {|c,l| [c, l.map {|b| MultiGeocoder.geocode(b.elements['item/geo:lat'].text.to_s+","+b.elements['item/geo:long'].text.to_s)}]}.flatten