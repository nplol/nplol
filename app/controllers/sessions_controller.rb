class SessionsController < ApplicationController
  http_basic_authenticate_with name: "2pac", password: "2pac", only: :authorize_user

  def create
    auth = request.env['omniauth.auth']['info']
    opts = user_params(auth)
    user = User.find_by(opts['email'])
    user = User.new(opts) if user.nil?
    if user.identities.where(provider: auth['provider']).empty?
      user.add_identity(auth['provider']) 
    end
    user.save! && log_in(user)    
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

  private

  def user_params(auth)
    auth[:name] = "#{auth['first_name']} #{auth['last_name']}" if auth[:name].nil?
    auth[:avatar]   = auth[:image]
    auth[:username] = auth['nickname']
    auth.select { |key, value| %w(name email avatar username).include? key }
  end

end
