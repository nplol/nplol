class AddCountFieldToPost < ActiveRecord::Migration
  def up
    add_column :posts, :likes_count, :integer, default: 0
  end

  def down
    remove_column :posts, :likes_count, :integer
  end
end
