require 'spec_helper'

def coupled_quests user
  quest = Quest.create! quest_text: "Lorem ipsum", accepted: 1
  user_quest = UserQuest.create!(hero_id: user.id,
                                 status: 1,
                                 quest_id: quest.id,
                                 npc_id: user.id,
                                 deadline: Time.now + 1.day)
  UserQuest.stub(:generate_quest).with(any_args) { user_quest }
end

describe "Users" do
  before :each do
    @user = create(:user)
    coupled_quests @user
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
