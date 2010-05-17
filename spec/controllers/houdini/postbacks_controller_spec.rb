require 'spec_helper'

class Foo < ActiveRecord::Base
  
end

describe Houdini::PostbacksController do
  before do
    @subject = mock_model(Foo)
    Foo.stub!(:find).and_return(@subject)
    @subject.stub!(:process_houdini_answer)
  end
  
  def do_post
    post :create, :subject_class => 'foo', :subject_id => '1', :task_name => 'review_image'
  end
  
  it "should find the subject" do
    Foo.should_receive(:find).with("1").and_return(@subject)
    do_post
  end
  
  it "should process the answer" do
    @subject.should_receive(:process_houdini_answer)
    do_post
  end
end