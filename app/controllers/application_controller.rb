class ApplicationController < ActionController::Base
  include Pundit

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :initialize_omniauth_state

  private

  def initialize_omniauth_state
     session['omniauth.state'] ||= SecureRandom.hex(24)
  end

  def current_user
    return nil unless session[:user_id]
    @current_user || User.find(session[:user_id])
  end

  def user_not_authorized
    flash[:error] = 'Sorry brah, that\'s not for you.'
    redirect_to root_path
  end

end
