require 'spec_helper'

describe RoomsController do
  login_user

  describe "GET 'show'" do
    it "returns http success" do
      room = create(:room)
      get :show, id: room.id.to_s
      response.should be_success
    end
  end

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'new'" do
    it "returns http success" do
      get 'new'
      response.should be_success
    end
  end

end
