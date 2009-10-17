class AddColumnCategoryIdToStream < ActiveRecord::Migration
  def self.up
    add_column :streams, :categories_id, :integer
  end

  def self.down
    remove_column :streams, :categories_id
  end
end
