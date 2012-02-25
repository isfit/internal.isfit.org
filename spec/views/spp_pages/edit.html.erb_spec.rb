require 'spec_helper'

describe "spp_pages/edit" do
  before(:each) do
    @spp_page = assign(:spp_page, stub_model(SppPage,
      :title_en => "MyString",
      :ingress_en => "MyString",
      :body_en => "MyText",
      :image_text => "MyString",
      :byline_func_id => 1,
      :byline => "MyString"
    ))
  end

  it "renders the edit spp_page form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => spp_pages_path(@spp_page), :method => "post" do
      assert_select "input#spp_page_title_en", :name => "spp_page[title_en]"
      assert_select "input#spp_page_ingress_en", :name => "spp_page[ingress_en]"
      assert_select "textarea#spp_page_body_en", :name => "spp_page[body_en]"
      assert_select "input#spp_page_image_text", :name => "spp_page[image_text]"
      assert_select "input#spp_page_byline_func_id", :name => "spp_page[byline_func_id]"
      assert_select "input#spp_page_byline", :name => "spp_page[byline]"
    end
  end
end
