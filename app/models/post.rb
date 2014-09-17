class Post < ActiveRecord::Base
  belongs_to :author, class_name: 'User', foreign_key: 'user_id'
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liking_users, through: :likes, source: :user

  has_attached_file :image, styles: { large: '640x480', medium: '300x300>', thumb: '100x100>' }
  validates_attachment_content_type :image, :content_type => /^image\/(png|gif|jpeg|jpg)/
  validates_attachment_presence :image

  validates :title, presence: true,
            uniqueness: true

  scope :_public, -> { where(public: true) }

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
    likes.create!(user: user) unless likes.include? user
  end

end
