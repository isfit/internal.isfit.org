require "spec_helper"

describe MotdsController do
  describe "routing" do

    it "routes to #index" do
      get("/motds").should route_to("motds#index")
    end

    it "routes to #new" do
      get("/motds/new").should route_to("motds#new")
    end

    it "routes to #show" do
      get("/motds/1").should route_to("motds#show", :id => "1")
    end

    it "routes to #edit" do
      get("/motds/1/edit").should route_to("motds#edit", :id => "1")
    end

    it "routes to #create" do
      post("/motds").should route_to("motds#create")
    end

    it "routes to #update" do
      put("/motds/1").should route_to("motds#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/motds/1").should route_to("motds#destroy", :id => "1")
    end

  end
end
