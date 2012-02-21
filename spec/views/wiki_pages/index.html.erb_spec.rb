require 'spec_helper'

describe "wiki_pages/index" do
  before(:each) do
    assign(:wiki_pages, [
      stub_model(WikiPage,
        :title => "Title",
        :body => "Body",
        :user => nil,
        :slug => "Slug",
        :wiki_category => nil,
        :lock => false,
        :deleted => false
      ),
      stub_model(WikiPage,
        :title => "Title",
        :body => "Body",
        :user => nil,
        :slug => "Slug",
        :wiki_category => nil,
        :lock => false,
        :deleted => false
      )
    ])
  end

  it "renders a list of wiki_pages" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Body".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => nil.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Slug".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => nil.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => false.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
