class Post < ActiveRecord::Base
  include Houdini::Model
  
  houdini :moderates_image,
    :on => :after_create,
    :if => :image_updated?,
    :title => 'Review Image',
    :form_html => :generate_houdini_html,
    :callback => :houdini_callback
  
  def image_updated?
    true
  end
  
  def generate_houdini_html
    template = File.read(File.join(RAILS_ROOT, 'app/views/posts/houdini_template.html.haml'))
    haml_engine = Haml::Engine.new(template)
    haml_engine.render(Object.new, :image_url => image_url)
  end
  
  def houdini_callback(answer)
    update_attribute(:flagged, true) if answer[:flagged] == 'yes'
  end
end
