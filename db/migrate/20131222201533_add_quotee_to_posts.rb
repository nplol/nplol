class AddQuoteeToPosts < ActiveRecord::Migration

  def up
    add_column :posts, :quotee, :string, nil: true
  end

  def down
    remove_column :posts, :quotee, :string, nil: true
  end


end
