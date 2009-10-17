class Stream < ActiveRecord::Base
  belongs_to :categories
  belongs_to :users
  
  attr_accessor :search_keys
  
  validates_presence_of :categories_id, :message => "^ Please select a category"
  
  def user
    user = User.find_by_id(self.user_id)
    return user
  end
  
  def self.search(params)
    conditions = ""
    streams = []

    search_keys = params[:search_keys]
    search_keys = search_keys.split(/,| /)
    search_keys.map! {|k| k.strip }
    search_keys = search_keys.delete_if { |k|  k.nil? or k.empty? }

    conditions << " AND " if ! search_keys.empty? and ! conditions.empty?

    conditions << "(" if !search_keys.empty? 

    search_keys.each_index do |index|
      conditions <<  "name LIKE '%#{ search_keys[index] }%'"
      conditions << " AND " if (index + 1) < search_keys.size
    end


    conditions << ")" if !search_keys.empty?

    listings = self.find(:all, :conditions => conditions) if ! conditions.empty?
  end
  
  def self.find_friends_streams(facebook_session)
    streams = self.all
    fb_streams = streams.select {|x| x if x.user.fb_user_id}
    friends_fb_streams = fb_streams.select {|x| x if User.is_a_facebook_friend?(facebook_session, x.user)}
    return friends_fb_streams
  end
  
end
