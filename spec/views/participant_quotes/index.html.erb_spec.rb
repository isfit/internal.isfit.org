require 'spec_helper'

describe "participant_quotes/index" do
  before(:each) do
    assign(:participant_quotes, [
      stub_model(ParticipantQuote,
        :quote => "Quote",
        :user => nil,
        :category => "Category"
      ),
      stub_model(ParticipantQuote,
        :quote => "Quote",
        :user => nil,
        :category => "Category"
      )
    ])
  end

  it "renders a list of participant_quotes" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Quote".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Category".to_s, :count => 2
  end
end
