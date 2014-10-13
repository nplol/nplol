class SessionsController < ApplicationController
  http_basic_authenticate_with name: "2pac", password: "2pac", only: :authorize_nplol

  def create
    auth = request.env['omniauth.auth']
    user = User.find_by_auth(auth)
    
    if user.nil?
      redirect_to new_identity_url, auth: auth
    else
      identity = Identity.find_by(uid: auth[:uid])
      user.create_identity(auth) if identity.nil?
      session[:user_id] ||= user.uuid
      close_window
    end
  end  
 
    #if identity.nil?
      #identity = Identity.create_from_auth(auth)
    #end
    
    
    
    #if logged_in?
      ## link identity with the logged in user.
      #if identity.user != current_user
        #identity.update_attributes(user: current_user)
      #end
      #close_window  
    #else
      #if identity.user.present?
        #session[:user_id] = user.uuid
        #close_window
     #else 
        ## New identity, but might belong to an existing user. The only
        ## way to find out is to ask the user to provide a primary email address
        #redirect_to new_user_url, identity_id: identity.uid, notice: 'Please provide a primary email address'
      #end
    #end
  #end

  #oauth_hash = request.env['omniauth.auth']
    #option = user_params(oauth_hash)
  #user = User.find_with_provider(options) || User.new(options)
    #user.save if user.new_record?
    #session[:user_id] = user.uuid
    #return render 'partials/_header', layout: false if request.xhr?
    #render 'partials/_close_window', layout: false
  #end

  def destroy
    reset_session
    redirect_to root_path
  end

  def authorize_nplol
    current_user.authorize!
    render 'partials/_header', layout: false if request.xhr?
  end

  #def header
    #render 'partials/_header', layout: false if request.xhr?
  #end

  private

  def close_window
    render 'partials/_close_window', layout: false
  end

  #def user_params(oauth_hash)
    ## split due to naming for google_oauth
    #token_prefix = "#{oauth_hash['provider'].split('_').first}_auth_token"

    #options = oauth_hash.select{ |key, value| %w(info credentials).include? key }['info'].merge(oauth_hash['credentials']).select { |key, value| %(name image email token).include? key }.symbolize_keys!

    #options[:avatar] = options[:image]
    #options[token_prefix.to_sym] = options[:token]
    #options.delete(:image)
    #options.delete(:token)

    #options
  #end

  #def provider_params(provider, params)
    #provider_prefix = "#{provider}_auth_token"
    #params[provider_prefix.to_sym] = params[:token]
    #params.delete(:token)
    #params
  #end

end
