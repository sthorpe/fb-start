require 'active_record/fixtures'
class CreateFeeds < ActiveRecord::Migration
  def self.up
    create_table :feeds do |t|
      t.string :url
      t.integer :news_id
      t.timestamps
    end
    directory = File.join(File.dirname(__FILE__), "data" )
    Fixtures.create_fixtures(directory, "feeds" )
  end

  def self.down
    drop_table :feeds
  end
end
