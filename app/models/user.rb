class User < ActiveRecord::Base
  self.primary_key = 'uuid'

  ROLES = %w(nplol regular)

  validates_presence_of :name, :email, :avatar, :role
  validates_uniqueness_of :email

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy

  def initialize(params = {})
    super(params)
    self.role = 'regular'
    self.uuid = SecureRandom.uuid
  end

  def authorize!
    self.role = 'nplol'
    self.save
  end

  def nplol?
    self.role == 'nplol'
  end

end
