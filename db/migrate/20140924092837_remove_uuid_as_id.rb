class RemoveUuidAsId < ActiveRecord::Migration
  def change
    change_column :posts, :user_id, 'integer USING CAST(user_id AS integer)'
    change_column :comments, :user_id, 'integer USING CAST(user_id AS integer)'
    change_column :likes, :user_id, 'integer USING CAST(user_id AS integer)'
  end
end
