class IdentitiesController < ApplicationController
   
  def new
    raise Exceptions::AuthenticationError if params[:auth].nil?
    @identity = Identity.find_or_create_by_auth(params[:auth])
  end

end
