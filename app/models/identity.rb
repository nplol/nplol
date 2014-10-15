class Identity < ActiveRecord::Base
  belongs_to :user
  
  def self.find_by_auth(auth)
    find_by(uid: auth[:uid], provider: auth[:provider])
  end
   
end
