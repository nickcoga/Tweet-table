class AddDefaultValueOnCountsToUsers < ActiveRecord::Migration[6.0]
  def up
    change_column :tweets, :replies_count, :integer, null: false, default: 0 
  end

  def down
    change_column :tweets, :replies_count, :integer
  end
end
