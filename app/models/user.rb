class User < ActiveRecord::Base
  ROLES = %w(nplol regular)

  validates_presence_of :name, :email, :role
  validates_uniqueness_of :email
  
  after_initialize :default_values  

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_posts, through: :likes, source: :post
  has_many :identities, dependent: :destroy
  
  def add_identity(provider)
    self.identities << Identity.new(provider: provider)
  end
  
  def default_values
    self.uuid ||= SecureRandom.uuid
    self.role ||= 'regular'
  end

  def authorize!
    self.role = 'nplol'
    save
  end

  def nplol?
    self.role == 'nplol'
  end

  def like(post)
    likes.create(post: post) unless liked_posts.include? post 
  end

end
