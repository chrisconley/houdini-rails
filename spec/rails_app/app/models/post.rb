class Post < ActiveRecord::Base
  include Houdini::Model
  
  houdini :moderates_image, :on => :after_create, :if => :image_updated?,
    :title => 'Moderate Image',
    :form_template => File.join(RAILS_ROOT, 'app/views/posts/houdini_template.html.haml'),
    :callback => :process_image_moderation_answer
  
  def image_updated?
    true
  end
  
  def process_image_moderation_answer(answer)
    update_attribute(:flagged, true) if answer[:flagged] == 'yes'
  end
end
