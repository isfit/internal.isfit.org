require 'spec_helper'

describe WhoAmIController do

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'game'" do
    it "returns http success" do
      get 'game'
      response.should be_success
    end
  end

  describe "GET 'highscore'" do
    it "returns http success" do
      get 'highscore'
      response.should be_success
    end
  end

end
