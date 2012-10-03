require 'spec_helper'

describe "layout_jobs/index" do
  before(:each) do
    assign(:layout_jobs, [
      stub_model(LayoutJob,
        :user_id => 1,
        :user_info => "MyText",
        :work_title => "Work Title",
        :web_or_print => 2,
        :format => "Format",
        :description => "MyText"
      ),
      stub_model(LayoutJob,
        :user_id => 1,
        :user_info => "MyText",
        :work_title => "Work Title",
        :web_or_print => 2,
        :format => "Format",
        :description => "MyText"
      )
    ])
  end

  it "renders a list of layout_jobs" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Work Title".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Format".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
