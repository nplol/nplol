class RemoveTwatterAddGithub < ActiveRecord::Migration
  def change
    remove_column :users, :twitter_auth_token, :string
    add_column :users, :github_auth_token, :string
  end
end
