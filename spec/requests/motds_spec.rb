require 'rails_helper'

describe "Motds" do
	#login_user
  describe "GET /motds" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      user = FactoryGirl.create(:user, password: 'password')
			post '/sessions', {:login => user.username, :password => 'password'}
      get motds_path
      response.status.should be(200)
    end
  end
end
