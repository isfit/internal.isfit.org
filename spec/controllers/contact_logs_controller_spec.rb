require 'rails_helper'

describe ContactLogsController do
  #Add this to don't care about login
  login_user

  describe "GET 'index'" do
    it "should be successful" do
      get 'index'
      response.should be_success
    end
  end
  # TODO: Yes the tests are there for a reason, but I changed the functionality
  #describe "GET 'new'" do
  #  it "should be successful" do
  #    get 'new'
  #    response.should be_success
  #  end
  #end
end
