require 'spec_helper'

describe Houdini::Base do
  it "should raise a Houdini::AuthenticationError" do
    response = mock('Response')
    response.stub!(:code).and_return('403')
    Net::HTTP.stub!(:post_form).and_return([response, ''])

    lambda { Houdini::Base.request('simple', {}) }.should raise_error(Houdini::AuthenticationError)
  end

  it "should raise a Houdini::RequestError" do
    response = mock('Response')
    response.stub!(:code).and_return('422')
    Net::HTTP.stub!(:post_form).and_return([response, ''])

    lambda { Houdini::Base.request('simple', {}) }.should raise_error(Houdini::RequestError)
  end

  it "should not raise a error" do
    response = mock('Response')
    response.stub!(:code).and_return('200')
    Net::HTTP.stub!(:post_form).and_return([response, ''])

    lambda { Houdini::Base.request('simple', {}) }.should_not raise_error()
  end



end