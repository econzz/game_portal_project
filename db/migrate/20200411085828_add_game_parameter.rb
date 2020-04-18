class AddGameParameter < ActiveRecord::Migration[5.2]
  def change
    add_column :games, :numberOfPlay, :integer, :default => 0
    add_column :games, :cover_big, :string
    add_column :games, :preview_big, :string
    add_column :games, :category, :integer, :default => 0
  end
end
