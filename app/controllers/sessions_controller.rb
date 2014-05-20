class SessionsController < ApplicationController

  def create
    oauth_hash = request.env['omniauth.auth']['info'].symbolize_keys!
    massage_hash(oauth_hash)
    session[:user] = User.new(oauth_hash)
    return render 'partials/_header', layout: false if request.xhr?
    render 'partials/_close_window', layout: false
  end

  def destroy
    session[:user] = nil
    render 'partials/_header', layout: false
  end

  def header
    render 'partials/_header', layout: false if request.xhr?
  end

  private

  def massage_hash(hash)
    hash[:name] = hash[:first_name] ||hash[:name].split(' ').first
  end

end
