class SessionsController < ApplicationController

  def create
    oauth_hash = request.env['omniauth.auth']['info'].symbolize_keys!
    session[:user] = User.new(oauth_hash)
    render 'users/oauth/_confirm', layout: false
  end

  def destroy
    session[:user] = nil
    render nothing: true
  end

  def header
    render 'partials/_header', layout: false
  end

end
