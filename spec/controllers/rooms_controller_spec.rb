require 'rails_helper'

describe RoomsController do
  login_user

  describe "GET 'show'" do
    it "returns http success" do
      room = create(:room)
      get :show, id: room.id.to_s
      expect(response).to be_success
    end
  end

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      expect(response).to be_success
      expect(response).to render_template("index")
    end
  end

  describe "GET 'new'" do
    it "returns http success" do
      get 'new'
      expect(response).to be_success
      expect(response).to render_template("new")
    end
  end

end
