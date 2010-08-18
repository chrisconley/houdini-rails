# Overview

This ruby gem is a Rails Engine for using the Houdini Mechanical Turk API. It provides easy integration into your models and sets up the necessary controllers to receive answers posted back to your app from Houdini.

Houdini Documentation: http://houdinihq.com/documentation

# Installation (Rails 2.3.x)

Add the gem to your config/environment.rb

    config.gem 'houdini-rails'

# Example Usage

Create a template for the form to be sent to Mechanical Turk:

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

Post.houdini class method options:

* :price - Amount in cents you want to pay for the task to be completed
* :title - Title that Mechanical Turk workers will see when browsing/searching available tasks
* :form_template - ERB or HAML template used to render the form html.
* :on_task_completion - Method that Houdini should call when the answer is posted back to your app. The results of your form will be passed into the method as the only parameter. `{:flagged => 'yes'}` in the example above.