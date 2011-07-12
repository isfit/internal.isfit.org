require 'spec_helper'

describe "static_pages/edit.html.erb" do
  before(:each) do
    @static_page = assign(:static_page, stub_model(StaticPage,
      :title => "MyString",
      :body => "MyText",
      :user => nil
    ))
  end

  it "renders the edit static_page form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => static_pages_path(@static_page), :method => "post" do
      assert_select "input#static_page_title", :name => "static_page[title]"
      assert_select "textarea#static_page_body", :name => "static_page[body]"
      assert_select "input#static_page_user", :name => "static_page[user]"
    end
  end
end
