require_relative 'boot'

require 'rails/all'

require 'action_cable'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Songs
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    config.after_initialize do

      file_name = 'songs'
      path = "app/assets/#{file_name}.pdf"
      print "Searching for songs in #{path}... "
      
      file = File.read('songs_index.json')
      $songs_index = JSON.parse file

      $songs_index.each do |song| 
        song['queue'] = nil
      end

      puts "Found #{$songs_index.length} songs."

      Requests.instance.populate_pool($songs_index)

      # $requests = []
      # $requests << 80
      # $requests_index = 0;
    end

    config.action_controller.default_protect_from_forgery = false
    
  end
end
