require File.dirname(__FILE__) + '/../spec_helper'

describe SessionsController do
  before :each do
    user = create(:user)
  end

  it "new action should render new template" do
    get :new
    response.should render_template(:new)
  end

  it "create action should render new template when authentication is invalid" do
    User.stub(:authenticate) { nil }
    post :create
    response.should render_template(:new)
    session['user_id'].should be_nil
  end
end
