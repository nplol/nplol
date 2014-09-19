class AddHabtmToTags < ActiveRecord::Migration
  def change
    remove_column :tags, :post_id

    create_table :posts_tags do |t|
      t.references :post
      t.references :tag

      t.timestamps
    end

    add_index 'posts_tags', ['post_id', 'tag_id'], unique: true
    add_index 'posts_tags', 'post_id'
  end
end
