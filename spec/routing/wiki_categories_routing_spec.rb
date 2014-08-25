require "rails_helper"

describe WikiCategoriesController do
  describe "routing" do

    it "routes to #index" do
      get("/wiki_categories").should route_to("wiki_categories#index")
    end

    it "routes to #new" do
      get("/wiki_categories/new").should route_to("wiki_categories#new")
    end

    it "routes to #show" do
      get("/wiki_categories/1").should route_to("wiki_categories#show", :id => "1")
    end

    it "routes to #edit" do
      get("/wiki_categories/1/edit").should route_to("wiki_categories#edit", :id => "1")
    end

    it "routes to #create" do
      post("/wiki_categories").should route_to("wiki_categories#create")
    end

    it "routes to #update" do
      put("/wiki_categories/1").should route_to("wiki_categories#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/wiki_categories/1").should route_to("wiki_categories#destroy", :id => "1")
    end

  end
end
