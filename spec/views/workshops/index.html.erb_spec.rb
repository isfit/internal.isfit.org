require 'spec_helper'

describe "workshops/index" do
  before(:each) do
    assign(:workshops, [
      stub_model(Workshop,
        :name => "Name",
        :ingress => "MyText",
        :body => "MyText",
        :number => 1,
        :user => nil,
        :published => false,
        :got_comments => false
      ),
      stub_model(Workshop,
        :name => "Name",
        :ingress => "MyText",
        :body => "MyText",
        :number => 1,
        :user => nil,
        :published => false,
        :got_comments => false
      )
    ])
  end

  it "renders a list of workshops" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => nil.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => false.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
