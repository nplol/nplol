class SessionsController < ApplicationController

  def create
    oauth_hash = request.env['omniauth.auth']['info'].symbolize_keys!
    sessions[:user] = User.new(oauth_hash)
  end

  def destroy
    session.delete(:user)
  end

end
