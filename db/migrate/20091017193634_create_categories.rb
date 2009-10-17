class CreateCategories < ActiveRecord::Migration
  def self.up
    create_table :categories do |t|
      t.string :name
      t.timestamps
    end
    
    # Creates Default Categories
    Categories.create(:name => 'All')
    Categories.create(:name => 'For Sale')
    Categories.create(:name => 'Roommates')
    Categories.create(:name => 'Services')
    Categories.create(:name => 'Personals')
    Categories.create(:name => 'MISC')

  end

  def self.down
    drop_table :categories
  end
end
