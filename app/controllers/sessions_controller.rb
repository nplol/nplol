class SessionsController < ApplicationController

  http_basic_authenticate_with name: "2pac", password: "2pac", only: :authorize_nplol

  def create
    oauth_hash = request.env['omniauth.auth']['info'].symbolize_keys!
    options = user_params(oauth_hash)
    user = User.find_by(email: options[:email]) || User.create(options)
    session[:user_id] = user.uuid
    return render 'partials/_header', layout: false if request.xhr?
    render 'partials/_close_window', layout: false
  end

  def destroy
    reset_session
    redirect_to root_path
  end

  def authorize_nplol
    current_user.authorize!
    render 'partials/_header', layout: false if request.xhr?
  end

  def header
    render 'partials/_header', layout: false if request.xhr?
  end

  private

  def user_params(oauth_hash)
    hash = { }
    hash[:name] = oauth_hash[:first_name] || oauth_hash[:name].split(' ').first
    hash[:avatar] = oauth_hash[:image]
    hash[:email] = oauth_hash[:email]
    hash
  end

end
