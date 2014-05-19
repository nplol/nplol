class SessionsController < ApplicationController

  def create
    oauth_hash = request.env['omniauth.auth']['info'].symbolize_keys!
    session[:user] = User.new(oauth_hash)
    render 'partials/_header', layout: false
  end

  def destroy
    session[:user] = nil
    render 'partials/_header', layout: false
  end

end
