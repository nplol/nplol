class AddBannerToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :banner, :boolean, unique: true
  end
end
