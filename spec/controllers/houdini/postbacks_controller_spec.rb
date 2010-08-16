require 'spec_helper'

class Foo < ActiveRecord::Base
  
end

describe Houdini::PostbacksController do
  before do
    @object = mock_model(Foo)
    Foo.stub!(:find).and_return(@object)
    @object.stub!(:process_postback)
  end
  
  def do_post
    post :create, :object_class => 'foo', :object_id => '1', :task_name => 'review_image'
  end
  
  it "should find the object" do
    Foo.should_receive(:find).with("1").and_return(@object)
    do_post
  end
  
  it "should process the answer" do
    @object.should_receive(:process_postback)
    do_post
  end
end