class SessionsController < ApplicationController

  http_basic_authenticate_with name: "2pac", password: "2pac", only: :authorize_nplol

  def create
    oauth_hash = request.env['omniauth.auth']['info'].symbolize_keys!
    options = massage_hash(oauth_hash)
    session[:user] = User.find_by(name: options[:name]) || User.new(options)
    return render 'partials/_header', layout: false if request.xhr?
    render 'partials/_close_window', layout: false
  end

  def destroy
    session[:user] = nil
    redirect_to root_path
  end

  def authorize_nplol
    session[:user].authorize
    render 'partials/_header', layout: false if request.xhr?
  end

  def header
    render 'partials/_header', layout: false if request.xhr?
  end

  private

  def massage_hash(oauth_hash)
    hash = { }
    hash[:name] = oauth_hash[:first_name] || oauth_hash[:name].split(' ').first
    hash[:avatar] = oauth_hash[:image]
    hash[:role] = 'regular'
    hash
  end

end
