class UsersController < ApplicationController
  layout 'simple'
 
  def new
    raise Exceptions::AuthenticationError if params[:auth].nil?
    @identity = Identity.new(identity_params)
    @user = User.new(user_params)
  end

  def create
  end

  private

  def identity_params
    params.require(:auth).permit(:uid, :provider)
  end

  def user_params
    params.require(:oauth).require(:info).permit(:image, :first_name, :last_name, :email)
  end

end
