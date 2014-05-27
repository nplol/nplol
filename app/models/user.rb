class User < ActiveRecord::Base
  self.primary_key = 'uuid'

  ROLES = %w(nplol regular)

  validates_presence_of :name, :email, :avatar, :role
  validates_uniqueness_of :email

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy

  def initialize(provider, params={})
    super(params)
    self.uuid = SecureRandom.uuid
    self.role = 'regular'
  end

  def self.find_with_provider(options)
    user = self.find_by(email: options[:email])
    return nil if user.nil?

    user.update_attributes(options)
    user
  end

  def authorize!
    self.role = 'nplol'
    self.save
  end

  def nplol?
    self.role == 'nplol'
  end

  private

end
