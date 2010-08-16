require 'spec/test_helper'

class PostbacksTest < ActionController::IntegrationTest
  def test_should_send_to_houdini_and_receive_postback
    post = Post.create(:image_url => 'http://google.com', :flagged => nil)
    visit 'houdini/post/1/review_image/postbacks', :post, :flagged => "yes"
    assert_response :success
    assert_equal true, post.reload.flagged
    assert_equal Time.now.to_date, post.houdini_request_sent_at.to_date
  end
end