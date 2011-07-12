require 'spec_helper'

describe "static_pages/index.html.erb" do
  before(:each) do
    assign(:static_pages, [
      stub_model(StaticPage,
        :title => "Title",
        :body => "MyText",
        :user => nil
      ),
      stub_model(StaticPage,
        :title => "Title",
        :body => "MyText",
        :user => nil
      )
    ])
  end

  it "renders a list of static_pages" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
