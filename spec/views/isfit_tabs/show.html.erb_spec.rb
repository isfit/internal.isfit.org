require 'rails_helper'

describe "isfit_tabs/show" do
  before(:each) do
    @isfit_tab = assign(:isfit_tab, IsfitTab.create!(name_en: 'name_en', name_no: 'name_no'))
  end

  #it "renders attributes in <p>" do
  #  render
  #  # Run the generator again with the --webrat flag if you want to use webrat matchers
  #end
end
