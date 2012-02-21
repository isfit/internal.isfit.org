require 'spec_helper'

describe "wiki_categories/index" do
  before(:each) do
    assign(:wiki_categories, [
      stub_model(WikiCategory,
        :title => "Title",
        :slug => "Slug",
        :deleted => false
      ),
      stub_model(WikiCategory,
        :title => "Title",
        :slug => "Slug",
        :deleted => false
      )
    ])
  end

  it "renders a list of wiki_categories" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Slug".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
