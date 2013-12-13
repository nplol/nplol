class AddTypeToPosts < ActiveRecord::Migration

  def up
    add_column :posts, :type, :string, nil: false
  end

  def down
    remove_column :posts, :type, :string, nil: false
  end

end
