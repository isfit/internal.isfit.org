require 'spec_helper'

describe "isfit_pages/show.html.erb" do
  before(:each) do
    @isfit_page = assign(:isfit_page, stub_model(IsfitPage,
      :title_en => "Title En",
      :title_no => "Title No",
      :ingress_en => "MyText",
      :ingress_no => "MyText",
      :body_en => "MyText",
      :body_no => "MyText",
      :tag => "Tag",
      :deleted => false
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Title En/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Title No/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/MyText/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/MyText/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/MyText/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/MyText/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Tag/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/false/)
  end
end
