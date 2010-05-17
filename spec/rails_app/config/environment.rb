# Be sure to restart your server when you modify this file

# Specifies gem version of Rails to use when vendor/rails is not present
RAILS_GEM_VERSION = '2.3.5' unless defined? RAILS_GEM_VERSION

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')

class TestGemLocator < Rails::Plugin::Locator
  def plugins
    Rails::Plugin.new(File.join(File.dirname(__FILE__), *%w(.. .. ..)))
  end
end
 
Rails::Initializer.run do |config|
  config.gem 'haml'
  config.time_zone = 'UTC'
  config.plugin_locators << TestGemLocator
end

Houdini::KEY = 'abcde'
Houdini::HOST = 'staging.gohoudini.com'
Houdini::RAILS_HOST = 'localhost:3000'