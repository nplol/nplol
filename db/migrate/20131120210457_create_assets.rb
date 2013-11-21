class CreateAssets < ActiveRecord::Migration
  def change
    create_table :assets do |t|
      t.references :post

      t.timestamps
    end
    add_attachment :assets, :image
  end
end
