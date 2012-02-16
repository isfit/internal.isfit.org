require 'spec_helper'
require 'integration_js_helper'


describe "Accounts", js: true do
  before :each do
    user = create(:admin_user)
    create(:account)
    visit login_path
    fill_in 'login', with: user.username
    fill_in 'password', with: "secret123"
    click_button 'Log in'
  end
  # Pending because it is annoying... can be tagged with something, or ignored?
  it "should render the printable when clicking on create form" do
    visit voucher_accounts_path
    fill_in "voucher_amount1", with: "100"
    fill_in "voucher_description1", with: "Test"
    click_button "Add row"
    fill_in "voucher_amount2", with: "200"
    fill_in "voucher_description2", with: "Test2"
    click_button "Create voucher"
    find("#sum").should have_content("300")
  end
end
