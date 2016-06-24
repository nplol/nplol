class AddCarrierwaveToPosts < ActiveRecord::Migration[5.0]
  def change
    if column_exists?(:posts, :image_file_name)
      remove_column :posts, :image_file_name
    end
    if column_exists?(:posts, :image_content_type)
    remove_column :posts, :image_content_type
    end
    if column_exists?(:posts, :image_file_size)
    remove_column :posts, :image_file_size
    end
    if column_exists?(:posts, :image_updated_at)
    remove_column :posts, :image_updated_at
    end
    add_column :posts, :image, :string
  end
end
