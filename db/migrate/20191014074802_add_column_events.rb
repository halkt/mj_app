class AddColumnEvents < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :community_id, :integer
    add_column :events, :day, :datetime
  end
end
