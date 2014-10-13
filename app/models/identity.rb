class Identity < ActiveRecord::Base
  belongs_to :user
  
  def self.find_or_create_by_auth(auth)
    identity = find_by(uid: auth[:uid], provider: auth['provider'])
    identity.nil? ? create(auth.select { |key, value| %w(uid provider).include? key }) : identity
  end

end
