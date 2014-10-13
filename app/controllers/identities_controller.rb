class IdentitiesController < ApplicationController
  layout 'simple'
 
  def new
    raise Exceptions::AuthenticationError if params[:auth].nil?
    @identity = Identity.new(identity_params)
  end

  private

  def identity_params
    params.require(:auth).permit(:uid, :provider)
  end

end
