ENV["RAILS_ENV"] ||= 'test'

require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'helpers/controller_helper'
require 'spec_helper'
require 'simplecov'

Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }
ActiveRecord::Migration.check_pending! if defined?(ActiveRecord::Migration)

# test coverage
SimpleCov.start 'rails'

RSpec.configure do |config|

  # prettify FactoryGirl syntax ( create rather than FactoryGirl.create )
  config.include FactoryGirl::Syntax::Methods
  config.extend ControllerHelper, type: :controller

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
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

  config.around(:each) do |test|
    DatabaseCleaner.cleaning do
      test.run # Run test once cleaning yields
    end
  end

  # Include authHelper module for controller specs to make
  # basic http auth pass.
  # config.include AuthHelper, :type => :controller

  # less verbose specs, goodie!
  config.infer_spec_type_from_file_location!
end
