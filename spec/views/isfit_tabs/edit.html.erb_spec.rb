require 'rails_helper'

describe "isfit_tabs/edit" do
  before(:each) do
    @isfit_tab = assign(:isfit_tab, IsfitTab.create!(name_en: 'name_en', name_no: 'name_no'))
  end

  it "renders the edit isfit_tab form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", isfit_tab_path(@isfit_tab), "post" do
    end
  end
end
