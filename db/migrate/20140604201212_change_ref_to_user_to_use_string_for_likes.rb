class ChangeRefToUserToUseStringForLikes < ActiveRecord::Migration
  def change
    change_column :likes, :user_id, :string
  end
end
