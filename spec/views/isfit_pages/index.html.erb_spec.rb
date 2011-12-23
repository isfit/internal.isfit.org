require 'spec_helper'

describe "isfit_pages/index.html.erb" do
  before(:each) do
    assign(:isfit_pages, [
      stub_model(IsfitPage,
        :title_en => "Title En",
        :title_no => "Title No",
        :ingress_en => "MyText",
        :ingress_no => "MyText",
        :body_en => "MyText",
        :body_no => "MyText",
        :tag => "Tag",
        :deleted => false
      ),
      stub_model(IsfitPage,
        :title_en => "Title En",
        :title_no => "Title No",
        :ingress_en => "MyText",
        :ingress_no => "MyText",
        :body_en => "MyText",
        :body_no => "MyText",
        :tag => "Tag",
        :deleted => false
      )
    ])
  end

  it "renders a list of isfit_pages" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Title En".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Title No".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Tag".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
