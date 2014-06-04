class AddUniqueIndexToLikes < ActiveRecord::Migration
  def change
    add_index :likes, [:user_id, :post_id], unique: true
  end
end
