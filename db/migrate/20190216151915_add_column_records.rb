class AddColumnRecords < ActiveRecord::Migration[5.2]
  def change
    add_column :records, :genten, :float
    add_column :records, :kaeshiten, :float
    add_column :records, :uma, :string
    add_column :records, :yakitori, :string
  end
end
