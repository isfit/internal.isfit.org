require 'spec_helper'

describe "participant_quotes/show" do
  before(:each) do
    controller.stub(:current_user) { User.first }
    @participant_quote = assign(:participant_quote, stub_model(ParticipantQuote,
      :quote => "Quote",
      :user => nil,
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Quote/)
    rendered.should match(//)
  end
end
