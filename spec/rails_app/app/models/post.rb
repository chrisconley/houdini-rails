class Post < ActiveRecord::Base
  include Houdini::Model
  
  houdini :moderates_image,
    :on => :after_create,
    :if => :image_updated?,
    :title => 'Moderate Image',
    :form_template => File.join(RAILS_ROOT, 'app/views/posts/houdini_template.html.haml'),
    :callback => :houdini_callback
  
  def image_updated?
    true
  end
  
  def houdini_callback(answer)
    update_attribute(:flagged, true) if answer[:flagged] == 'yes'
  end
end
