require 'net/http'
require 'uri'

require 'tilt'

require 'houdini-rails/base'
require 'houdini-rails/model'
require 'houdini-rails/task'

module Houdini
  # Convenience method
  def self.perform!(task_name, object)
    object.send_to_houdini(task_name)
  end
end