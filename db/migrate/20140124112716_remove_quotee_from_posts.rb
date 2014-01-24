class RemoveQuoteeFromPosts < ActiveRecord::Migration
  def change
    remove_column :posts, :quotee
  end
end
