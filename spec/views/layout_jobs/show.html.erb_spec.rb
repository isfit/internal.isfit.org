require 'spec_helper'

describe "layout_jobs/show" do
  before(:each) do
    @layout_job = assign(:layout_job, stub_model(LayoutJob,
      :user_id => 1,
      :user_info => "MyText",
      :work_title => "Work Title",
      :web_or_print => 2,
      :format => "Format",
      :description => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/MyText/)
    rendered.should match(/Work Title/)
    rendered.should match(/2/)
    rendered.should match(/Format/)
    rendered.should match(/MyText/)
  end
end
