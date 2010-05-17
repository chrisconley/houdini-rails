require 'rubygems'

ENV["RAILS_ENV"] = "test"

require File.dirname(__FILE__) + "/rails_app/config/environment"
require 'test_help'
require 'webrat'

ActiveRecord::Base.establish_connection(:adapter => "sqlite3", :database => ":memory:")
ActiveRecord::Migrator.migrate(File.expand_path("../rails_app/db/migrate/", __FILE__))

ActionMailer::Base.delivery_method = :test
ActionMailer::Base.perform_deliveries = true
ActionMailer::Base.default_url_options[:host] = 'test.com'

Webrat.configure do |config|
  config.mode = :rails
  config.open_error_files = false
end

class ActiveSupport::TestCase
  self.use_transactional_fixtures = true
  self.use_instantiated_fixtures  = false
end