require 'rails_helper'

describe "isfit_tabs/new" do
  before(:each) do
    assign(:isfit_tab, IsfitTab.new(name_en: 'name_en', name_no: 'name_no'))
  end

  it "renders new isfit_tab form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", isfit_tabs_path, "post" do
    end
  end
end
