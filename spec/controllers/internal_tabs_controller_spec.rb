require 'spec_helper'

describe InternalTabsController do
  #Add this to don't care about login
  before do
    @controller.stubs(:logged_in?).returns(true)
    User.stub!(:role?).and_return(true)
  end

  describe "GET 'index'" do
    it "should be successful" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'new'" do
    it "should be successful" do
      get 'new'
      response.should be_success
    end
  end
end
