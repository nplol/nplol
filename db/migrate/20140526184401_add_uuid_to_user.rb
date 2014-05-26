class AddUuidToUser < ActiveRecord::Migration
  def change
    add_column :users, :uuid, :string, index: true
  end
end
