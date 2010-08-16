class Post < ActiveRecord::Base
  include Houdini::Model

  houdini :moderates_image,
    :identifier => 'image_moderation',
    :title => 'Moderate Image',
    :form_template => File.join(RAILS_ROOT, 'app/views/posts/houdini_template.html.erb'),
    :on_submit => :update_houdini_attributes,
    :on_postback => :process_image_moderation_answer,
    :price => '0.01'

  after_create :moderate_image, :if => :image_url

  def moderate_image
    send_to_houdini
  end

  def update_houdini_attributes(response, body)
    update_attribute(:houdini_request_sent_at, Time.now)
  end

  def process_image_moderation_answer(answer)
    update_attribute(:flagged, true) if answer[:flagged] == 'yes'
  end
end
