require 'spec/test_helper'

class PostbacksTest < ActionController::IntegrationTest
  def test_should_do_something
    post = Post.create(:flagged => nil)
    visit 'houdini/post/1/review_image/postbacks', :post, :answer => {:flagged => "yes"}
    assert_response :success
    assert_equal true, post.reload.flagged
  end
end