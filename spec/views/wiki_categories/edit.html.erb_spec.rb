require 'spec_helper'

describe "wiki_categories/edit" do
  before(:each) do
    @wiki_category = assign(:wiki_category, stub_model(WikiCategory,
      :title => "MyString",
      :slug => "MyString",
      :deleted => false
    ))
  end

  it "renders the edit wiki_category form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => wiki_categories_path(@wiki_category), :method => "post" do
      assert_select "input#wiki_category_title", :name => "wiki_category[title]"
      assert_select "input#wiki_category_slug", :name => "wiki_category[slug]"
      assert_select "input#wiki_category_deleted", :name => "wiki_category[deleted]"
    end
  end
end
