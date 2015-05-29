class AddTopToPosts < ActiveRecord::Migration
  def up 
    add_column :posts, :top, :boolean, default: false
  end

  def down
    remove_column :posts, :top, :boolean 
  end
end
