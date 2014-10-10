class Post < ActiveRecord::Base
  default_scope { order('created_at DESC') }
  attr_accessor :popular

  belongs_to :author, class_name: 'User', foreign_key: 'user_id'
  has_many :comments, dependent: :destroy

  has_and_belongs_to_many :tags
  accepts_nested_attributes_for :tags
  has_many :likes, dependent: :destroy
  has_many :liking_users, through: :likes, source: :user

  has_attached_file :image, styles: { large: '640x480', medium: '300x300>', thumb: '100x100>' }
  validates_attachment_content_type :image, :content_type => /^image\/(png|gif|jpeg|jpg)/
  validates_attachment_presence :image

  validates :title, presence: true,
            uniqueness: true

  scope :_public, -> { where(public: true) }

  def public?
    self.public
  end
  
  # setter and getter for nested tag attributes
  def tag_list=(tags)
    tags.split(',').map(&:strip).each do |tag|
      self.tags << Tag.find_or_create_by(name: tag)
    end
  end

  def tag_list
    tags.map(&:name).join(', ')
  end

  def score
    Float(comments.length + likes.length)/2.ceil
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
