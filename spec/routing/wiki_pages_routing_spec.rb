require "rails_helper"

describe WikiPagesController do
  describe "routing" do

    it "routes to #index" do
      get("/wiki_pages").should route_to("wiki_pages#index")
    end

    it "routes to #new" do
      get("/wiki_pages/new").should route_to("wiki_pages#new")
    end

    it "routes to #show" do
      get("/wiki_pages/1").should route_to("wiki_pages#show", :id => "1")
    end

    it "routes to #edit" do
      get("/wiki_pages/1/edit").should route_to("wiki_pages#edit", :id => "1")
    end

    it "routes to #create" do
      post("/wiki_pages").should route_to("wiki_pages#create")
    end

    it "routes to #update" do
      put("/wiki_pages/1").should route_to("wiki_pages#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/wiki_pages/1").should route_to("wiki_pages#destroy", :id => "1")
    end

  end
end
