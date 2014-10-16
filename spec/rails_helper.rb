ENV["RAILS_ENV"] ||= 'test'

require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'spec_helper'
require 'simplecov'
require 'capybara-webkit'

Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }
ActiveRecord::Migration.check_pending! if defined?(ActiveRecord::Migration)

# test coverage
SimpleCov.start 'rails'

RSpec.configure do |config|

  # prettify FactoryGirl syntax ( create rather than FactoryGirl.create )
  config.include FactoryGirl::Syntax::Methods
  config.include ControllerHelper, type: :controller
  
  # explicitly do NOT use transactional fixtures 
  config.use_transactional_fixtures = false  
  
  config.before(:suite) do
    DatabaseCleaner.strategy = :truncation
    begin
      FactoryGirl.lint
      # FB bug, TODO
      # factories_to_lint = FactoryGirl.factories.reject do |factory|
      #   # no need to lint factories intentionally left invalid
      #   factory.name =~ /^invalid_/
      # end
      # FactoryGirl.lint(factories_to_lint)
    ensure
      # Delete all tables before suite is run as lint populates some tables
      # to ensure factories are correct.
      DatabaseCleaner.clean_with :truncation
    end
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end
  
  config.before(:each, :js => true) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:each) do 
    DatabaseCleaner.start
  end
  
  config.after(:each) do
    DatabaseCleaner.clean
  end

  # less verbose specs, goodie!
  config.infer_spec_type_from_file_location!
  Capybara.javascript_driver = :webkit
  Capybara.raise_server_errors = false # no need to let 404 errors fail the suite
end
