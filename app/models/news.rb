require 'simple-rss'
require 'open-uri'

class News
  attr_accessor :articles
  SimpleRSS.item_tags << :"geo:lat"
  SimpleRSS.item_tags << :"geo:long"
  
  def initialize
    rss = SimpleRSS.parse open('http://ws.geonames.org/rssToGeoRSS?feedUrl=http://rss.cnn.com/rss/cnn_topstories.rss')
    self.articles = []
    if rss 
      (10).times do |num|
        article = Article.new(rss.items[num])
        self.articles << article
      end
    end
  end
  
end