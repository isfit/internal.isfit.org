require 'rails_helper'
require 'integration_js_helper'

def coupled_quests user
  quest = Quest.create! quest_text: "Lorem ipsum", accepted: 1
  user_quest = UserQuest.create!(hero_id: user.id,
                                 status: 1,
                                 quest_id: quest.id,
                                 npc_id: user.id,
                                 deadline: Time.now + 1.day)
  UserQuest.stub(:generate_quest).with(any_args) { user_quest }
end

describe "Accounts", js: true do
  self.use_transactional_fixtures = false
  before :each do
    user = create(:admin_user)
    #coupled_quests user
    Festival.stub(:find_by_year).with(any_args) { Festival.new }
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
