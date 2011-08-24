require 'spec_helper'

describe "applicants/show.html.erb" do
  before(:each) do
    @applicant = assign(:applicant, stub_model(Applicant))
  end

  it "renders attributes in <p>" do
    render
  end
end
