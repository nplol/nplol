class Post < ActiveRecord::Base
	validates :title, 	presence: true, 
						length: {minimum: 5},
						uniqueness: true

	validates :content, presence: true

	has_many :comments, dependent: :destroy

  has_many :assets, dependent: :destroy
  accepts_nested_attributes_for :assets, :allow_destroy => true

  acts_as_taggable

end
