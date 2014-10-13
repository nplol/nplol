class User < ActiveRecord::Base
  ROLES = %w(nplol regular)

  validates_presence_of :name, :email, :avatar, :role
  validates_uniqueness_of :email
  
  after_initialize :default_values  

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_posts, through: :likes, source: :post
  has_many :identities, dependent: :destroy
  
  def self.find_by_auth(auth)
    self.find_by(email: auth[:info][:email])
  end  
  
  def create_identity(auth)
    self.identities << Identity.new(uid: auth[:uid], provider: auth[:provider])
    save
  end  
  
  def after_initialize
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

end
