source 'https://rubygems.org'

ruby '2.1.2'

gem 'rails', '~> 4.1.0'

gem 'sass-rails', '~> 4.0.2'
gem 'coffee-rails'
gem 'bourbon', '~> 3.2.x'
gem 'font-awesome-rails', '~> 4.1.0'
gem 'haml'
gem 'pg'
gem 'uglifier'
gem 'acts-as-taggable-on', '~> 3.2.3'
gem 'pundit'

# use puma as the webserver
gem 'puma'
gem 'newrelic_rpm'

# markdown
gem 'truncate_html'
gem 'redcarpet'

# paperclip and aws for remote file upload
gem 'paperclip', '~> 4.1'
gem 'aws-sdk', '~> 1.5.7'

# analytics all the things
gem 'google-analytics-rails'

# use ouath for authing with third-parties
gem 'omniauth-google-oauth2'
gem 'omniauth-twitter'
gem 'omniauth-github'

group :development do
  gem 'better_errors', '~> 1.1.0'
  # lets get those line numbers, pl0x
  gem 'coffee-rails-source-maps'
  gem 'spring'
  gem 'priscilla'
end

group :test do
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'database_cleaner'
  gem 'simplecov', require: false
  gem 'poltergeist'
end

group :development, :test do
  gem 'byebug'
  gem 'dotenv-rails'
end
