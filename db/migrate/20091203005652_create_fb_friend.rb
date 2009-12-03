class CreateFbFriend < ActiveRecord::Migration
  def self.up
    create_table :fb_friends do |t|
      t.integer :user_id
      t.integer :fb_user_id
      t.string :name
      t.binary :location
      t.timestamps
    end
  end

  def self.down
    drop_table :fb_friends
  end
end
