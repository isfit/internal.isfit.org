require 'spec_helper'

describe "isfit_pages/new.html.erb" do
  before(:each) do
    assign(:isfit_page, stub_model(IsfitPage,
      :title_en => "MyString",
      :title_no => "MyString",
      :ingress_en => "MyText",
      :ingress_no => "MyText",
      :body_en => "MyText",
      :body_no => "MyText",
      :tag => "MyString",
      :deleted => false
    ).as_new_record)
  end

  it "renders new isfit_page form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => isfit_pages_path, :method => "post" do
      assert_select "input#isfit_page_title_en", :name => "isfit_page[title_en]"
      assert_select "input#isfit_page_title_no", :name => "isfit_page[title_no]"
      assert_select "textarea#isfit_page_ingress_en", :name => "isfit_page[ingress_en]"
      assert_select "textarea#isfit_page_ingress_no", :name => "isfit_page[ingress_no]"
      assert_select "textarea#isfit_page_body_en", :name => "isfit_page[body_en]"
      assert_select "textarea#isfit_page_body_no", :name => "isfit_page[body_no]"
      assert_select "input#isfit_page_tag", :name => "isfit_page[tag]"
      assert_select "input#isfit_page_deleted", :name => "isfit_page[deleted]"
    end
  end
end
