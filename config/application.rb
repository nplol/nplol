require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module Nplol
  class Application < Rails::Application

    config.generators do |g|
      g.orm             :active_record
      g.template_engine :haml
      g.test_framework  :rspec
      g.stylesheets     true
      g.javascripts     false
      g.helper          false
    end

  end
end
