class AddCategoryIdToGames < ActiveRecord::Migration[5.2]
  def change
    add_column :games, :category_id, :int
    add_index :games, :category_id
    remove_column :games, :category
  end
end
