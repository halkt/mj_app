class AddColumnToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :login_flg, :boolean
  end
end
