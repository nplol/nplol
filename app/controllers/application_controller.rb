require 'exceptions'

class ApplicationController < ActionController::Base
  include Pundit
  layout :layout?
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  rescue_from Exceptions::AuthenticationError, with: :user_not_authorized
 
  helper_method :current_user, :nplol?, :logged_in?

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # before_filter :initialize_omniauth_state

  private

  #def initialize_omniauth_state
     #session['omniauth.state'] ||= SecureRandom.hex(24)
  #end

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
 
end
