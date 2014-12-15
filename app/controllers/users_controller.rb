class UsersController < ApplicationController
  layout 'simple'
 
  def new
    raise Exceptions::AuthenticationError if params[:auth].nil?
    @identity = Identity.create(identity_params)
    @user = User.new(user_auth_params)
  end

  def create
    user = User.find_or_create_by(email: user_params[:email])
    user.identities << Identity.find_by(uid: user_params[:identity])
    user.save!
    log_in(user.uuid)
    close_window
  end

  private

  def identity_params
    params.require(:auth).permit(:uid, :provider)
  end

  def user_auth_params
    params.require(:auth).require(:info).permit(:avatar, :email)
  end 

  def user_params
    params.require(:user).permit(:email, :identity)
  end

end
