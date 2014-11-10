require 'rails_helper'

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

    let(:current_user)do
      FactoryGirl.create(:user)
    end
    before do
      #controller.should_receive(:authenticate_user!)
      controller.stub(:current_user).and_return current_user
    end


    it "edit action should render edit template" do
      get :edit, {:id => current_user.id }
      response.should render_template(:edit)
    end

    it "update action should render edit template when user is invalid" do
      User.any_instance.stub(:valid?).and_return(false)
      patch :update, id: current_user.id, user: {}
      response.should render_template(:edit)
    end

    it "update action should redirect when user is valid" do
      User.any_instance.stub(:valid?).and_return(true)
      patch :update, id: current_user.id, user: {}
      response.should redirect_to(root_url)
    end
  end
end
