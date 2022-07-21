require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module SellYourStuffApp
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1

    #this line helps prevent complete image replacement when adding more images.  It adds to the active storage images.
    config.active_storage.replace_on_assign_to_many = false

    #line below prevents .error_with_fields class from changing the layout if errors are present
    config.action_view.field_error_proc = Proc.new { |html_tag, instance| 
      html_tag
    }

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
  end
end
