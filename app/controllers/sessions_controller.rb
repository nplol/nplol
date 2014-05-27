class SessionsController < ApplicationController

  http_basic_authenticate_with name: "2pac", password: "2pac", only: :authorize_nplol

  def create
    oauth_hash = request.env['omniauth.auth']
    options = user_params(oauth_hash)
    user = User.find_with_provider(options) || User.new(options)
    user.save if user.new_record?
    session[:user_id] = user.uuid
    return render 'partials/_header', layout: false if request.xhr?
    render 'partials/_close_window', layout: false
  end

  def destroy
    reset_session
    redirect_to root_path
  end

  def authorize_nplol
    current_user.authorize!
    render 'partials/_header', layout: false if request.xhr?
  end

  def header
    render 'partials/_header', layout: false if request.xhr?
  end

  private

  def user_params(oauth_hash)
    # split due to naming for google_oauth
    token_prefix = "#{oauth_hash['provider'].split('_').first}_auth_token"

    options = oauth_hash.select{ |key, value| %w(info credentials).include? key }['info'].merge(oauth_hash['credentials']).select { |key, value| %(name image email token).include? key }.symbolize_keys!

    options[:avatar] = options[:image]
    options[token_prefix.to_sym] = options[:token]
    options.delete(:image)
    options.delete(:token)

    options
  end

  def provider_params(provider, params)
    provider_prefix = "#{provider}_auth_token"
    params[provider_prefix.to_sym] = params[:token]
    params.delete(:token)
    params
  end

end
