require 'spec_helper'

describe UsersController do
  context "Not logged in" do
    it "edit action should redirect when not logged in" do
      get :edit, id: "ignored"
      response.should redirect_to(login_url)
    end
    it "update action should redirect when not logged in" do
      put :update, id: "ignored"
      response.should redirect_to(login_url)
    end
  end

  context "When logged in" do
    login_user

    before do
      @controller.stub(:current_user) { User.new }
    end

    it "edit action should render edit template" do
      get :edit, id: "ignored"
      response.should render_template(:edit)
    end
    
    it "update action should render edit template when user is invalid" do
      User.any_instance.stub(:valid?).and_return(false)
      put :update, id: "ignored"
      response.should render_template(:edit)
    end

    it "update action should redirect when user is valid" do
      User.any_instance.stub(:valid?).and_return(true)
      put :update, id: "ignored"
      response.should redirect_to(root_url)
    end
  end
end
