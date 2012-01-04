require 'spec_helper'

describe "Users" do
  before :each do
    @user = create(:user)
  end
  it "should display unsucessfull text when not logged in" do
    visit login_path
    click_button "Log in"
    page.has_content?('Invalid login or password.')
  end
  it "should display sucessfull text when logged in" do
    visit login_path
    fill_in 'login', with: @user.username
    fill_in 'password', with: "secret123"
    click_button "Log in"
    page.has_content?("Logged in successfully.")
  end
end
