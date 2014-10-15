class Post < ActiveRecord::Base
  attr_accessor :popular, :next, :previous

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

  scope :_public, ->  { where(public: true)  }
  scope :_private, -> { where(public: false) }
  
  def set_siblings
    self.next, self.previous = find_siblings
  end  

  def score
    Float(comments.length + likes.length)/2.ceil
  end
 
  # setter and getter for nested tag attributes
  def tag_list=(tags)
    # remove previous tags
    self.tags.clear
    tags.split(',').map(&:strip).each do |tag|
      self.tags << Tag.find_or_create_by(name: tag) 
    end
  end

  def tag_list
    tags.map(&:name).join(', ')
  end

  private
  
  def find_siblings
    [next_post_id, previous_post_id]
  end

  def next_post_id
    next_post = Post.select('id, created_at').where('created_at >= ? AND id > ?', created_at, id).order('created_at ASC').first
    next_post.nil? ? nil: next_post.id
  end

  def previous_post_id
    previous = Post.select('id, created_at').where('created_at <= ? AND id < ?', created_at, id).order('created_at DESC').first 
    previous.nil? ? nil : previous.id
  end

end
