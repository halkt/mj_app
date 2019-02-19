class CreateGames < ActiveRecord::Migration[5.2]
  def change
    create_table :games do |t|
      t.integer :event_id
      t.text :description
      t.integer :genten
      t.integer :kaeshiten
      t.integer :tobi_rule
      t.integer :yakitori_rule
      t.integer :horse_id

      t.timestamps
    end
  end
end
