require 'spec_helper'

describe "layout_jobs/edit" do
  before(:each) do
    @layout_job = assign(:layout_job, stub_model(LayoutJob,
      :user_id => 1,
      :user_info => "MyText",
      :work_title => "MyString",
      :web_or_print => 1,
      :format => "MyString",
      :description => "MyText"
    ))
  end

  it "renders the edit layout_job form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => layout_jobs_path(@layout_job), :method => "post" do
      assert_select "input#layout_job_user_id", :name => "layout_job[user_id]"
      assert_select "textarea#layout_job_user_info", :name => "layout_job[user_info]"
      assert_select "input#layout_job_work_title", :name => "layout_job[work_title]"
      assert_select "input#layout_job_web_or_print", :name => "layout_job[web_or_print]"
      assert_select "input#layout_job_format", :name => "layout_job[format]"
      assert_select "textarea#layout_job_description", :name => "layout_job[description]"
    end
  end
end
