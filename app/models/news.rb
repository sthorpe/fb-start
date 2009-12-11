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
  
  def self.all_news
    @feeds = Feed.all
    @all_news = []
    @feeds.each do |feed|
      @all_news << News.new(feed)
    end
    return @all_news
  end
  
  def article_titles
    articles.collect {|x| x.title}
  end
    
  def uniq_articles
    @uq_art = {}
    # Grab all article titles
    # Iterate through each title starting from the first to get a score.
    article_titles.size.times do |i|
      article_titles[i].source(article_titles[i+1])
    end
    
    return @uq_art
  end
    
end