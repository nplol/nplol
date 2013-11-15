source 'https://rubygems.org'

ruby '2.0.0'

gem 'airbrake'
gem 'bourbon'
gem 'neat'
gem 'jquery-rails'
gem 'coffee-rails'
gem 'flutie'
gem 'jquery-rails'
gem 'pg'
gem 'rails', '>= 4.0.0'
gem 'sass-rails'
gem 'uglifier'
gem 'unicorn'
gem 'truncate_html'
gem 'acts-as-taggable-on'
gem 'redcarpet'
gem 'haml'

# use rspec for testing
gem 'rspec-rails', :group => [:development, :test]

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'foreman'
end

group :test do
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'capybara-webkit', '>= 1.0.0'
  gem 'database_cleaner'
  gem 'simplecov', require: false
  gem 'timecop'
  gem 'webmock'
end

group :staging, :production do
  gem 'newrelic_rpm', '>= 3.6.7'
  gem 'rails_12factor'
end
