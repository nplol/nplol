class Comment < ActiveRecord::Base
	belongs_to :post

	validates :name, 	presence: true,
						length: {minimum: 3}

	validates :text,	presence: true,
						length: {minimum: 5}
end
