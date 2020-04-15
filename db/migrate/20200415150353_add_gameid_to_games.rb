class AddGameidToGames < ActiveRecord::Migration[5.2]
  def change
    add_column :games, :game_id, :string
  end
end
