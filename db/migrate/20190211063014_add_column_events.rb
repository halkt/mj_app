class AddColumnEvents < ActiveRecord::Migration[5.2]
  # 変更内容
  def up
    add_column :events, :day, :date
  end

  # 変更前の状態
  def down
    remove_column :events, :day, :date
  end
end
