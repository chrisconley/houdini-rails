class Post < ActiveRecord::Base
  include Houdini::Model
  
  houdini :moderates_image, :on => :after_create, :if => :image_url,
    :title => 'Moderate Image',
    :form_template => File.join(RAILS_ROOT, 'app/views/posts/houdini_template.html.haml'),
    :on_submit => :update_houdini_attributes,
    :on_postback => :process_image_moderation_answer
    
  def update_houdini_attributes(response, body)
    update_attribute(:houdini_request_sent_at, Time.now)
  end
  
  def process_image_moderation_answer(answer)
    update_attribute(:flagged, true) if answer[:flagged] == 'yes'
  end
  
  # houdini :moderates_image,
  #   :title => 'Moderate Image',
  #   :form_template => File.join(RAILS_ROOT, 'app/views/posts/houdini_template.html.haml')
end
