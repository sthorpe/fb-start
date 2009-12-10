class CreateNews < ActiveRecord::Migration
  def self.up
    create_table :news do |t|
      t.string :source
      t.string :description
      t.string :location
      t.timestamps
    end
  end

  def self.down
    drop_table :news
  end
end
