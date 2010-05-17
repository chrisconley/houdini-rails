module Houdini
  class Task
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
end