class AddTwitterTokenToUsers < ActiveRecord::Migration
  def change
    add_column :users, :twitter_auth_token, :string
  end
end
