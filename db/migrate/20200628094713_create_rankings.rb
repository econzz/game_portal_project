class CreateRankings < ActiveRecord::Migration[5.2]
  def change
    create_table :rankings do |t|
      t.string :game_id, :default => ""
      t.string :name, :default => ""
      t.integer :score, :default => ""
      t.timestamps
      t.references :games, index: true, foreign_key: true
    end
    
  end
end
