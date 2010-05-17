require 'spec/test_helper'

class PostbacksTest < ActionController::IntegrationTest
  def test_should_do_something
    puts "hello"
    visit '/'
    assert_response :success
    assert_template 'home/index'
  end
end