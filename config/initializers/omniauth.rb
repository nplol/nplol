Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, Rails.application.secrets.google_key, Rails.application.secrets.google_secret
  provider :github, Rails.application.secrets.github_key, Rails.application.secrets.github_secret, scope: 'user:email, user:follow'
end
