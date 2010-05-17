module Houdini
  module Model
    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      def houdini(name, options)
        include ActionController::UrlWriter
        cattr_accessor :houdini_task
        self.houdini_task = Houdini::Task.new(name, options)
        self.send(houdini_task.on, :send_to_houdini, :if => houdini_task.if) 
      end
    end

    def send_to_houdini
      Houdini::Core.send(houdini_task.name,
        :title => houdini_task.title,
        :form_html => self.send(houdini_task.form_html),
        :postback_url => houdini_postbacks_url(self.class.name, self.id, self.houdini_task.name, :host => Houdini::RAILS_HOST))
    end

    def process_houdini_answer(answer)
      self.send self.class.houdini_task.callback, answer
    end
  end
end