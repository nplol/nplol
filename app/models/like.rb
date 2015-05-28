class Like < ActiveRecord::Base
  belongs_to :user
  belongs_to :post, counter_cache: true

  validates_presence_of :user, :post
end
