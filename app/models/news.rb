require 'simple-rss'
require 'open-uri'

class News
  attr_accessor :articles
  SimpleRSS.item_tags << :"geo:lat"
  SimpleRSS.item_tags << :"geo:long"
  
  def initialize(feed)
    rss = SimpleRSS.parse open("http://ws.geonames.org/rssToGeoRSS?feedUrl=#{feed.url}")
    self.articles = []
    if rss 
      rss.items.size.times do |num|
        article = Article.new(rss.items[num])
        self.articles << article
      end
    end
  end
  
end