class Post < ActiveRecord::Base
  self.inheritance_column = :type

  validates :title, presence: true,
            uniqueness: true

  validates :type, presence: true

  scope :memes, -> { where(type: 'Meme')}
  scope :articles, -> { where(type: 'Article')}

  belongs_to :author, class_name: 'User', foreign_key: 'user_id'

  has_many :comments, dependent: :destroy

  acts_as_taggable

  def self.policy_class
    PostPolicy
  end

end
