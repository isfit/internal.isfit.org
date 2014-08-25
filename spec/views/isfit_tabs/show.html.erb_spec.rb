require 'spec_helper'

describe "isfit_tabs/show" do
  before(:each) do
    @isfit_tab = assign(:isfit_tab, stub_model(IsfitTab))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
