class SessionsController < ApplicationController
  http_basic_authenticate_with name: "2pac", password: "2pac", only: :authorize_user

  def create
    auth = request.env['omniauth.auth']
    identity = Identity.find_by_auth(auth)
    if identity.nil?
      user = User.find_by_auth(auth)
      if user.nil?
        auth[:info][:avatar] = auth[:info].delete :image
        return redirect_to new_user_url(auth: auth), notice: t('primary_email')
      else
        user.create_identity(auth)
      end
    else
      user = identity.user
    end
    log_in(user.uuid)
    close_window
  end 
  
  def authorize_user
    current_user.authorize!
    render nothing: true, status: 200
  end

  def destroy
    reset_session
    redirect_to root_url
  end

end
