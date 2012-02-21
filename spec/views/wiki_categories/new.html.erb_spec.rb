require 'spec_helper'

describe "wiki_categories/new" do
  before(:each) do
    assign(:wiki_category, stub_model(WikiCategory,
      :title => "MyString",
      :slug => "MyString",
      :deleted => false
    ).as_new_record)
  end

  it "renders new wiki_category form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => wiki_categories_path, :method => "post" do
      assert_select "input#wiki_category_title", :name => "wiki_category[title]"
      assert_select "input#wiki_category_slug", :name => "wiki_category[slug]"
      assert_select "input#wiki_category_deleted", :name => "wiki_category[deleted]"
    end
  end
end
