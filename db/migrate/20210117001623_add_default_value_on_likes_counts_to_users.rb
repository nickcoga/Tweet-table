class AddDefaultValueOnLikesCountsToUsers < ActiveRecord::Migration[6.0]
  def up
    change_column :tweets, :likes_count, :integer, null: false, default: 0 
  end

  def down
    change_column :tweets, :likes_count, :integer
  end
end
