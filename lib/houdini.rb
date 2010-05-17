require 'net/http'
require 'uri'

module Houdini
  class Core
    def self.moderates_image(params)
      validate_constants
      url = URI.parse("http://#{HOST}/image_review/tasks/")
      response, body = Net::HTTP.post_form(url, params)
    end
    
    private
    
    def self.validate_constants
      raise Undefined, "Houdini::KEY is not defined"  if Houdini::KEY.blank?
      raise Undefined, "Houdini::HOST is not defined" if Houdini::HOST.blank?
      raise Undefined, "Houdini::RAILS_HOST is not defined" if Houdini::RAILS_HOST.blank?
    end
  end
  
  Undefined = Class.new(NameError)
end