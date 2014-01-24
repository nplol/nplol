class Post < ActiveRecord::Base
	validates :title, 	presence: true, 
						length: {minimum: 5},
						uniqueness: true

	validates :content, presence: true, unless: :meme?

	has_many :comments, dependent: :destroy

  has_many :assets
  accepts_nested_attributes_for :assets, :allow_destroy => true

  acts_as_taggable

  def asset_attributes=(asset_ids)
    assets.clear
    asset_ids.each do |asset_id|
      assets << Asset.find(asset_id)
    end
  end

  def meme?
    self.is_a? Meme
  end

  def self.all
    super.order('created_at DESC')
  end

end
