class Post < ActiveRecord::Base
  include Houdini::Model
  
  houdini :moderates_image,
    :on => :after_create,
    :if => :image_updated?,
    :title => 'Review Image',
    :form_template => File.join(RAILS_ROOT, 'app/views/posts/houdini_template.html.haml')
  
  def image_updated?
    true
  end
  
  # Might not want to move it here if we want to support multiple houdinis in one model
  def process_houdini_answer(answer)
    update_attribute(:flagged, true) if answer[:flagged] == 'yes'
  end
end
