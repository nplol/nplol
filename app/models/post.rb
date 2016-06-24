class Post < ActiveRecord::Base
  belongs_to :author, class_name: 'User', foreign_key: 'user_id'
  has_and_belongs_to_many :tags
  accepts_nested_attributes_for :tags
  has_many :likes, dependent: :destroy
  has_many :liking_users, through: :likes, source: :user
  mount_uploader :image, ImageUploader

  validates :title, presence: true,
            uniqueness: true

  def self.list(flag) 
    if flag
      self.all.order(created_at: :desc)
    else
      self.where(public: true).order(created_at: :desc)
    end
  end

  def score 
    likes.count
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

end
