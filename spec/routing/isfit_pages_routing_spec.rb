require 'rails_helper'

describe IsfitPagesController do
  describe "routing" do

    it "routes to #index" do
      get("/isfit_pages").should route_to("isfit_pages#index")
    end

    it "routes to #new" do
      get("/isfit_pages/new").should route_to("isfit_pages#new")
    end

    it "routes to #show" do
      get("/isfit_pages/1").should route_to("isfit_pages#show", :id => "1")
    end

    it "routes to #edit" do
      get("/isfit_pages/1/edit").should route_to("isfit_pages#edit", :id => "1")
    end

    it "routes to #create" do
      post("/isfit_pages").should route_to("isfit_pages#create")
    end

    it "routes to #update" do
      put("/isfit_pages/1").should route_to("isfit_pages#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/isfit_pages/1").should route_to("isfit_pages#destroy", :id => "1")
    end

  end
end
