require 'rails_helper'

describe "participant_quotes/index" do
  before(:each) do
    controller.stub(:current_user) { User.first }
    assign(:participant_quotes, [
      ParticipantQuote.create(quote: "Quote", user: nil, category: "Category"),
      ParticipantQuote.create(quote: "Quote", user: nil, category: "Category")
    ])
  end

  it "renders a list of participant_quotes" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "blockquote > p", :text => "Quote".to_s, :count => 2
  end
end
