require "spec_helper"

describe SppPagesController do
  describe "routing" do

    it "routes to #index" do
      get("/spp_pages").should route_to("spp_pages#index")
    end

    it "routes to #new" do
      get("/spp_pages/new").should route_to("spp_pages#new")
    end

    it "routes to #show" do
      get("/spp_pages/1").should route_to("spp_pages#show", :id => "1")
    end

    it "routes to #edit" do
      get("/spp_pages/1/edit").should route_to("spp_pages#edit", :id => "1")
    end

    it "routes to #create" do
      post("/spp_pages").should route_to("spp_pages#create")
    end

    it "routes to #update" do
      put("/spp_pages/1").should route_to("spp_pages#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/spp_pages/1").should route_to("spp_pages#destroy", :id => "1")
    end

  end
end
