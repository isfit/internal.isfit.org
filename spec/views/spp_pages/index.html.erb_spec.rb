require 'spec_helper'

describe "spp_pages/index" do
  before(:each) do
    assign(:spp_pages, [
      stub_model(SppPage,
        :title_en => "Title En",
        :ingress_en => "Ingress En",
        :body_en => "MyText",
        :image_text => "Image Text",
        :byline_func_id => 1,
        :byline => "Byline"
      ),
      stub_model(SppPage,
        :title_en => "Title En",
        :ingress_en => "Ingress En",
        :body_en => "MyText",
        :image_text => "Image Text",
        :byline_func_id => 1,
        :byline => "Byline"
      )
    ])
  end

  it "renders a list of spp_pages" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Title En".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Ingress En".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Image Text".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Byline".to_s, :count => 2
  end
end
