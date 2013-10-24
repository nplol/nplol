class Post < ActiveRecord::Base
	validates :title, 	presence: true, 
						length: {minimum: 5},
						uniqueness: true

	validates :content, presence: true

	has_many :comments, dependent: :destroy
	has_many :tags, dependent: :destroy
end
