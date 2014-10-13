require 'exceptions'

class ApplicationController < ActionController::Base
  include Pundit
  layout :layout?
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  rescue_from Exceptions::AuthenticationError, with: :user_not_authorized
 
  helper_method :log_in, :close_window, :current_user, :nplol?, :logged_in?

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private
  
  def log_in(id)
    session[:user_id] ||= id
    current_user
  end

  def current_user
    @current_user = User.find_by(uuid: session[:user_id]) || Guest.new
  end

  def user_not_authorized
    flash[:error] = 'Sorry brah, that\'s not for you.'
    redirect_to root_path
  end
  
  def logged_in?
    !!session[:user_id]
  end

  def nplol?
    current_user.nplol?
  end

  def layout?
    request.xhr? ? false : 'application'
  end

  def close_window
    render 'partials/_close_window', layout: false
  end
 
end
