require "spec_helper"

describe IsfitTabsController do
  describe "routing" do

    it "routes to #index" do
      get("/isfit_tabs").should route_to("isfit_tabs#index")
    end

    it "routes to #new" do
      get("/isfit_tabs/new").should route_to("isfit_tabs#new")
    end

    it "routes to #show" do
      get("/isfit_tabs/1").should route_to("isfit_tabs#show", :id => "1")
    end

    it "routes to #edit" do
      get("/isfit_tabs/1/edit").should route_to("isfit_tabs#edit", :id => "1")
    end

    it "routes to #create" do
      post("/isfit_tabs").should route_to("isfit_tabs#create")
    end

    it "routes to #update" do
      put("/isfit_tabs/1").should route_to("isfit_tabs#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/isfit_tabs/1").should route_to("isfit_tabs#destroy", :id => "1")
    end

  end
end
