require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module FriendAlarm
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    config.api_only = true

    puts '\nHERE YOU GO'
    puts ENV['aws-access']
    puts ENV['RAILS_ENV']
    puts ENV.fetch('RAILS_ENV')
    puts ENV.fetch('aws-access')
    puts 'HERE YOU GO\n'
    #AWS.config(
    #  access_key_id: ENV['aws-access'],
    #  secret_access_key: ENV['aws-secret']
    #)
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end
