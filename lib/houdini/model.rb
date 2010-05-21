module Houdini
  module Model
    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      def houdini(name, options)
        #TODO: Validate options
        include ActionController::UrlWriter
        cattr_accessor :houdini_task
        self.houdini_task = Houdini::Task.new(name, options)
        self.send(houdini_task.on, :send_to_houdini, :if => houdini_task.if) 
      end
    end

    def send_to_houdini
      result = Houdini::Base.request(
        :title => houdini_task.title,
        :form_html => generate_form_html(houdini_task.form_template),
        :postback_url => houdini_postbacks_url(self.class.name, self.id, self.houdini_task.name, :host => Houdini::RAILS_HOST))
      call_on_submit(*result)
    end

    def process_postback(answer)
      self.send(houdini_task.on_postback, answer)
    end
    
    def call_on_submit(response, body)
      self.send(houdini_task.on_submit, response, body) if houdini_task.on_submit
    end
    
    def generate_form_html(template)
      #TODO: look into including Rails::Renderer
      template = File.read(template)
      haml_engine = Haml::Engine.new(template)
      haml_engine.render(Object.new, self.class.name.underscore => self)
    end
  end
end