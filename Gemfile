source 'https://rubygems.org'

ruby '2.1.2'

gem 'rails', '~> 4.1.1'
gem 'sass-rails', '~> 4.0.2'
gem 'coffee-rails'
gem 'bourbon', '~> 3.2.x'
gem 'font-awesome-rails', '~> 4.1.0'
gem 'haml'
gem 'pg'
gem 'uglifier'
gem 'pundit' # post-policies

# use puma as the webserver
gem 'puma'
gem 'newrelic_rpm'

# paperclip and aws for remote file upload
gem 'paperclip', '~> 4.1'
gem 'aws-sdk', '~> 1.5.7'

# analytics all the things
gem 'google-analytics-rails'

# use ouath for authing with third-parties
gem 'omniauth-google-oauth2'
gem 'omniauth-github'

group :development, :test do
  gem 'spring'
  gem 'byebug'
  gem 'coffee-rails-source-maps'
  gem 'better_errors'
  gem 'priscilla'
end

group :test do
  gem 'rspec-rails'
  gem 'factory_girl_rails', '~> 4.4.1'
  gem 'database_cleaner'
  gem 'guard'
  gem 'guard-rspec'
  gem 'spring-commands-rspec'
  gem 'simplecov'
end
