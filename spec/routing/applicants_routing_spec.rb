require "spec_helper"

describe ApplicantsController do
  describe "routing" do

    it "routes to #index" do
      get("/applicants").should route_to("applicants#index")
    end

    it "routes to #new" do
      get("/applicants/new").should route_to("applicants#new")
    end

    it "routes to #show" do
      get("/applicants/1").should route_to("applicants#show", :id => "1")
    end

    it "routes to #edit" do
      get("/applicants/1/edit").should route_to("applicants#edit", :id => "1")
    end

    it "routes to #create" do
      post("/applicants").should route_to("applicants#create")
    end

    it "routes to #update" do
      put("/applicants/1").should route_to("applicants#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/applicants/1").should route_to("applicants#destroy", :id => "1")
    end

  end
end
