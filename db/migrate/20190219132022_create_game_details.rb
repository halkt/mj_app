class CreateGameDetails < ActiveRecord::Migration[5.2]
  def change
    create_table :game_details do |t|
      t.integer :game_id
      t.integer :user_id
      t.integer :point
      t.float :score
      t.integer :rank
      t.integer :tobi_flg
      t.integer :yakitori_flg

      t.timestamps
    end
  end
end
