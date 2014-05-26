class User < ActiveRecord::Base

  ROLES = %w(nplol regular)

  validates_presence_of :name, :avatar, :role

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy


  def authorize
    self.role = 'nplol'
  end

  def nplol?
    self.role == 'nplol'
  end

end
