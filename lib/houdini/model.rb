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
      Houdini::Core.send(houdini_task.name,
        :title => houdini_task.title,
        :form_html => generate_form_html(houdini_task.form_template),
        :postback_url => houdini_postbacks_url(self.class.name, self.id, self.houdini_task.name, :host => Houdini::RAILS_HOST))
    end

    def process_houdini_answer(answer)
      #TODO: add #update_attributes as default if no callback is specfied
      self.send self.class.houdini_task.callback, answer
    end
    
    def generate_form_html(template)
      template = File.read(template)
      haml_engine = Haml::Engine.new(template)
      haml_engine.render(Object.new, self.class.name.underscore => self)
    end
  end
end