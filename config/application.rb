require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Ramenlog
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
    config.i18n.default_locale = :ja
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}').to_s]
    require 'i18n'
    I18n.locale # => :en
    I18n.locale = :ja
    I18n.locale # => :ja
    require 'faker'
    Faker::Config.locale # => :ja
    Faker::Config.locale = :ja
    Faker::Config.locale # => :en
    Faker::Internet.email # => "ransom_blanda@auer.name"

    config.generators do |g|
      g.test_framework :rspec,
      view_specs: false,
      helper_specs: false,
      routing_specs: false,
      controller_specs: false
    end
  end
end
