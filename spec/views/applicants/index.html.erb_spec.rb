require 'spec_helper'

describe "applicants/index.html.erb" do
  before(:each) do
    assign(:applicants, [
      stub_model(Applicant),
      stub_model(Applicant)
    ])
  end

  it "renders a list of applicants" do
    render
  end
end
