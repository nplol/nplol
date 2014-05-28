class ChangeUserRefToUseString < ActiveRecord::Migration

  def change
    change_column :posts, :user_id, :string
    change_column :comments, :user_id, :string
  end

end
