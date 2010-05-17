ENV["RAILS_ENV"] = "test"
require "rails_app/config/environment"
require 'spec'
require 'spec/rails'

ActiveRecord::Base.establish_connection(:adapter => "sqlite3", :database => ":memory:")
ActiveRecord::Migrator.migrate(File.expand_path("../rails_app/db/migrate/", __FILE__))

Spec::Runner.configure do |config|

end