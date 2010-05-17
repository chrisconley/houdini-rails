module Houdini
  def self.included(base)
    base.extend ClassMethods
  end
  
  module ClassMethods
    def houdini(name, options)
      include ActionController::UrlWriter
      cattr_accessor :houdini_task
      self.houdini_task = HoudiniTask.new(name, options)
      self.send(houdini_task.on, :send_to_houdini, :if => houdini_task.if) 
    end
  end
  
  def send_to_houdini
    Houdini::Core.send(houdini_task.name,
      :title => houdini_task.title,
      :form_html => self.send(houdini_task.form_html),
      :postback_url => houdini_postbacks_url(self.class.name, self.id, self.houdini_task.name, :host => Houdini::RAILS_HOST))
  end
  
  def process_houdini_answer
    self.send self.class.houdini_task.callback
  end
  
  require 'net/http'
  require 'uri'
  class Core
    def self.moderates_image(params)
      validate_constants
      url = URI.parse("http://#{HOST}/image_review/tasks/")
      puts params.inspect
      response, body = Net::HTTP.post_form(url, params)
      puts body
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

class HoudiniTask
  attr_accessor :name, :on, :if, :title, :form_html, :callback
  
  
  def initialize(name, options)
    @name = name
    @on = options[:on]
    @if = options[:if]
    @title = options[:title]
    @form_html = options[:form_html]
    @callback = options[:callback]
  end
end