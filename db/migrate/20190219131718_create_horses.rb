class CreateHorses < ActiveRecord::Migration[5.2]
  def change
    create_table :horses do |t|
      t.string :name
      t.integer :point1
      t.integer :point2

      t.timestamps
    end
  end
end
