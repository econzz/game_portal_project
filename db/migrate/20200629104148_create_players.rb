class CreatePlayers < ActiveRecord::Migration[5.2]
  def change
    create_table :players do |t|
      t.string :hash_id
      t.string :name
      t.timestamps
    end
    add_reference :rankings, :players, foreign_key: true
    remove_column :rankings, :name
    add_index :players, :hash_id, unique:true
  end
end
