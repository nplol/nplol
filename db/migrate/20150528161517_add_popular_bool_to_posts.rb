class AddPopularBoolToPosts < ActiveRecord::Migration

  def up
    add_column :posts, :popular, :boolean, default: false
  end

  def down
    remove_column :posts, :popular, :boolean
  end

end
