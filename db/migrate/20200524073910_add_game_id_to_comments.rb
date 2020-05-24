class AddGameIdToComments < ActiveRecord::Migration[5.2]
  def change
    add_column :comments, :game_id, :int
  end
end
