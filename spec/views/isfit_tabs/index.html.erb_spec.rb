require 'rails_helper'

describe "isfit_tabs/index" do
  before(:each) do
    assign(:isfit_tabs, [
      IsfitTab.create!(name_en: 'name_en', name_no: 'name_no'),
      IsfitTab.create!(name_en: 'name_en', name_no: 'name_no')
    ])
  end

  it "renders a list of isfit_tabs" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
