require 'spec_helper'

describe "WikiCategories" do
  describe "GET /wiki_categories" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get wiki_categories_path
      response.status.should be(200)
    end
  end
end
