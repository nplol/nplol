class AddOauthTokensToUsers < ActiveRecord::Migration
  def change
    add_column :users, :google_auth_token, :string
    add_column :users, :google_refresh_token, :string
    add_column :users, :github_auth_token, :string
  end
end
