Houdini Rails Engine
=======

Installation (Rails 2.3.x)
----------------

Add the gem to your config/environment.rb
    config.gem 'houdini-rails'

Example Usage
---------------

Create a template:

    <!--app/views/houdini_templates/post.html.erb -->

    <h2>Review the image for offensiveness</h2>

    <h3>Instructions</h3>
    <p>Please review the image below.</p>

    <img src="<%= post.image_url %>"><br/>

    <input type="radio" name="flagged" value="yes" class="required">
    Yes, this picture is offensive
    </input>

    <input type="radio" name="flagged" value="no" class="required">
    No, this picture is okay
    </input>

Setup Houdini in your ActiveRecord model:

    class Post < ActiveRecord::Base
      include Houdini::Model

      houdini :image_moderation,
        :price => '0.01',
        :title => 'Please moderate image',
        :form_template => 'app/views/houdini_templates/post.html.erb',
        :on_task_completion => :process_image_moderation_answer

      after_create :moderate_image

      def moderate_image
        Houdini.perform!(:image_moderation, self)
      end

      def process_image_moderation_answer(params)
        update_attribute(:flagged => params[:flagged])
      end
    end