class ApplicationController < ActionController::Base
  include Pundit

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :initialize_omniauth_state

  private

  def initialize_omniauth_state
     session['omniauth.state'] ||= SecureRandom.hex(24)
  end

  def current_user
    session[:user]
  end

end
