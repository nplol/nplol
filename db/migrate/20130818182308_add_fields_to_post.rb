class AddFieldsToPost < ActiveRecord::Migration
  
  def change
  	add_column :posts, :title, :string
  	add_column :posts, :content, :text
  end

end
