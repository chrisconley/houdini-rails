module Houdini
  class Task
    attr_accessor :name, :on, :if, :title, :form_template, :callback
  
  
    def initialize(name, options)
      @name = name
      @on = options[:on]
      @if = options[:if]
      @title = options[:title]
      @form_template = options[:form_template]
      @callback = options[:callback]
    end
  end
end