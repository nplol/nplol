class Article < Post
  validates :content, presence: true

  has_many :assets
  accepts_nested_attributes_for :assets, allow_destroy: true

  def asset_attributes=(asset_ids)
    assets.clear
    asset_ids.each do |asset_id|
      assets << Asset.find(asset_id)
    end
  end

  def self.model_name
    Post.model_name
  end

end
