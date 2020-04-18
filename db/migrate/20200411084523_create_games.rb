class CreateGames < ActiveRecord::Migration[5.2]
  def change
    create_table :games do |t|
      t.string :name, :default => ""
      t.text :description, :default => ""
      t.string :path, :default => ""
      t.timestamps
    end
  end
end
