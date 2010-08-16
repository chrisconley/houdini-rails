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
      end
    end

    def send_to_houdini
      result = Houdini::Base.request(houdini_task.api,
        :api_key => Houdini::KEY,
        :identifier => houdini_task.identifier,
        :price => houdini_task.price,
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
      template = Tilt.new(template)
      template.render(self, self.class.name.downcase => self)
    end
  end
end