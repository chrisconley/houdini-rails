module Houdini
  class Task
    attr_accessor :name, :on, :if, :title, :form_template, :on_submit, :on_postback
  
    def initialize(name, options)
      @name = name
      @on = options[:on] || :after_create
      @if = options[:if] || true
      @title = options[:title]
      @form_template = options[:form_template]
      @on_submit = options[:on_submit]
      @on_postback = options[:on_postback] || :update_attributes
    end
  end
end