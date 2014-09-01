class Post < ActiveRecord::Base
  self.inheritance_column = :type

  validates :title, presence: true,
            uniqueness: true

  validates :type, presence: true

  scope :memes,     -> { where(type: 'Meme')}
  scope :articles,  -> { where(type: 'Article')}
  scope :_public,    -> { where(public: true) }

  belongs_to :author, class_name: 'User', foreign_key: 'user_id'

  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liking_users, through: :likes, source: :user


  acts_as_taggable

  def self.policy_class
    PostPolicy
  end

  def public?
    self.public
  end

  def next
    Post.where('created_at >= ? AND id > ?', created_at, id).order('created_at ASC').first
  end

  def previous
    Post.where('created_at <= ? AND id < ?', created_at, id).order('created_at DESC').first
  end

  def like(user)
    likes.create!(user: user)
  end

  def score
    self.likes.length + self.comments.length
  end

  def self.average_score
    score = 0
    Post.all.each do |post|
      score += post.likes.length + post.comments.length
    end
    return 0 if score == 0
    score/Post.all.length
  end

end
