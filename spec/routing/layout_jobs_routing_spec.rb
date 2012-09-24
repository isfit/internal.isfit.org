require "spec_helper"

describe LayoutJobsController do
  describe "routing" do

    it "routes to #index" do
      get("/layout_jobs").should route_to("layout_jobs#index")
    end

    it "routes to #new" do
      get("/layout_jobs/new").should route_to("layout_jobs#new")
    end

    it "routes to #show" do
      get("/layout_jobs/1").should route_to("layout_jobs#show", :id => "1")
    end

    it "routes to #edit" do
      get("/layout_jobs/1/edit").should route_to("layout_jobs#edit", :id => "1")
    end

    it "routes to #create" do
      post("/layout_jobs").should route_to("layout_jobs#create")
    end

    it "routes to #update" do
      put("/layout_jobs/1").should route_to("layout_jobs#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/layout_jobs/1").should route_to("layout_jobs#destroy", :id => "1")
    end

  end
end
