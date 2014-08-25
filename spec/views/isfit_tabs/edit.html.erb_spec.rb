require 'spec_helper'

describe "isfit_tabs/edit" do
  before(:each) do
    @isfit_tab = assign(:isfit_tab, stub_model(IsfitTab))
  end

  it "renders the edit isfit_tab form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", isfit_tab_path(@isfit_tab), "post" do
    end
  end
end
