class AddPublicToPosts < ActiveRecord::Migration
  def change
    remove_column :posts, :published, :boolean, default: false
    add_column :posts, :public, :boolean, default: false
  end
end
