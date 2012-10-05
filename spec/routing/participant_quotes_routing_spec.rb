require "spec_helper"

describe ParticipantQuotesController do
  describe "routing" do

    it "routes to #index" do
      get("/participant_quotes").should route_to("participant_quotes#index")
    end

    it "routes to #new" do
      get("/participant_quotes/new").should route_to("participant_quotes#new")
    end

    it "routes to #show" do
      get("/participant_quotes/1").should route_to("participant_quotes#show", :id => "1")
    end

    it "routes to #edit" do
      get("/participant_quotes/1/edit").should route_to("participant_quotes#edit", :id => "1")
    end

    it "routes to #create" do
      post("/participant_quotes").should route_to("participant_quotes#create")
    end

    it "routes to #update" do
      put("/participant_quotes/1").should route_to("participant_quotes#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/participant_quotes/1").should route_to("participant_quotes#destroy", :id => "1")
    end

  end
end
