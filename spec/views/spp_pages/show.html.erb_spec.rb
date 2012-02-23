require 'spec_helper'

describe "spp_pages/show" do
  before(:each) do
    @spp_page = assign(:spp_page, stub_model(SppPage,
      :title_en => "Title En",
      :ingress_en => "Ingress En",
      :body_en => "MyText",
      :image_text => "Image Text",
      :byline_func_id => 1,
      :byline => "Byline"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Title En/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Ingress En/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/MyText/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Image Text/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Byline/)
  end
end
