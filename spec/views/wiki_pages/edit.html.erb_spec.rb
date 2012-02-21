require 'spec_helper'

describe "wiki_pages/edit" do
  before(:each) do
    @wiki_page = assign(:wiki_page, stub_model(WikiPage,
      :title => "MyString",
      :body => "MyString",
      :user => nil,
      :slug => "MyString",
      :wiki_category => nil,
      :lock => false,
      :deleted => false
    ))
  end

  it "renders the edit wiki_page form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => wiki_pages_path(@wiki_page), :method => "post" do
      assert_select "input#wiki_page_title", :name => "wiki_page[title]"
      assert_select "input#wiki_page_body", :name => "wiki_page[body]"
      assert_select "input#wiki_page_user", :name => "wiki_page[user]"
      assert_select "input#wiki_page_slug", :name => "wiki_page[slug]"
      assert_select "input#wiki_page_wiki_category", :name => "wiki_page[wiki_category]"
      assert_select "input#wiki_page_lock", :name => "wiki_page[lock]"
      assert_select "input#wiki_page_deleted", :name => "wiki_page[deleted]"
    end
  end
end
