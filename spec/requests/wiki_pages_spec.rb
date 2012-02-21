require 'spec_helper'

describe "WikiPages" do
  describe "GET /wiki_pages" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get wiki_pages_path
      response.status.should be(200)
    end
  end
end
