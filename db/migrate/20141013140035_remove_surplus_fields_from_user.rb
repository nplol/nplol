class RemoveSurplusFieldsFromUser < ActiveRecord::Migration
  def change
    remove_column :users, :google_auth_token
    remove_column :users, :google_refresh_token
    remove_column :users, :github_auth_token
  end
end
