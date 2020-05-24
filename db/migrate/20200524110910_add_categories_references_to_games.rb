class AddCategoriesReferencesToGames < ActiveRecord::Migration[5.2]
  def change
    remove_column :games, :category_id
    add_reference :games, :category, foreign_key: true
    
  end
end
