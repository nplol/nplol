Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, Settings.google.client_id, Settings.google.client_secret
  provider :twitter, Settings.twitter.api_key, Settings.twitter.secret
  provider :github, Settings.github.api_key, Settings.github.secret, scope: 'user:email, user:follow'
end
