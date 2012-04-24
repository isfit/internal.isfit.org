require "spec_helper"

describe WorkshopsController do
  describe "routing" do

    it "routes to #index" do
      get("/workshops").should route_to("workshops#index")
    end

    it "routes to #new" do
      get("/workshops/new").should route_to("workshops#new")
    end

    it "routes to #show" do
      get("/workshops/1").should route_to("workshops#show", :id => "1")
    end

    it "routes to #edit" do
      get("/workshops/1/edit").should route_to("workshops#edit", :id => "1")
    end

    it "routes to #create" do
      post("/workshops").should route_to("workshops#create")
    end

    it "routes to #update" do
      put("/workshops/1").should route_to("workshops#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/workshops/1").should route_to("workshops#destroy", :id => "1")
    end

  end
end
