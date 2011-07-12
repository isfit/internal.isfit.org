require 'spec_helper'

describe "static_pages/show.html.erb" do
  before(:each) do
    @static_page = assign(:static_page, stub_model(StaticPage,
      :title => "Title",
      :body => "MyText",
      :user => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Title/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/MyText/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
  end
end
