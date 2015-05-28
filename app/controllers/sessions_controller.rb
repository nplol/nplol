class SessionsController < ApplicationController
  http_basic_authenticate_with name: "2pac", password: "2pac", only: :authorize_user
  before_action :set_auth_hash, only: :create

  def create
    user.save && log_in(user)    
    opts = user_params(@hash[:info])
    user = User.where("email='#{opts['email']}' OR username='#{opts['username']}'").first
    user = User.new(opts) if user.nil? || !user.valid?
    if user.identities.where(provider: @hash[:provider]).empty?
      user.add_identity(@hash[:provider]) 
    end
    if user.save
      log_in(user)
    else
      puts user
    end 
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
  
  def set_auth_hash
    @hash = request.env['omniauth.auth'].with_indifferent_access
  end

  def user_params(auth)
    auth[:name] = "#{auth['first_name']} #{auth['last_name']}" if auth[:name].nil?
    auth[:avatar]   = auth[:image]
    auth[:username] = auth['nickname']
    auth.select { |key, value| %w(name email avatar username).include? key }
  end

end
