class RenamePostIdToArticleId < ActiveRecord::Migration
  def change
    rename_column :assets, :post_id, :article_id
  end
end
