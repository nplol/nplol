class AddFieldsToComment < ActiveRecord::Migration
  def change
  	add_column :comments, :name, :string
	add_column :comments, :text, :text		
  end
end
