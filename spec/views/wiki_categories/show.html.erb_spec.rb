require 'spec_helper'

describe "wiki_categories/show" do
  before(:each) do
    @wiki_category = assign(:wiki_category, stub_model(WikiCategory,
      :title => "Title",
      :slug => "Slug",
      :deleted => false
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Title/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Slug/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/false/)
  end
end
