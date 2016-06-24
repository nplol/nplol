class ApplicationController < ActionController::Base
  layout :layout?
  helper_method :log_in, :close_window, :current_user, :nplol?, :logged_in?

  protect_from_forgery with: :exception

  private
  
  def log_in(user)
    session[:user_id] ||= user.uuid
    current_user
  end

  def current_user
    @current_user = User.find_by(uuid: session[:user_id]) || Guest.new
  end

  def user_not_authorized
    return render json: { error: t('unauthorized') }, status: 401 if request.xhr?
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
