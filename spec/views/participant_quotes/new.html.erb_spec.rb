require 'spec_helper'

describe "participant_quotes/new" do
  before(:each) do
    assign(:participant_quote, stub_model(ParticipantQuote,
      :quote => "MyString",
      :user => nil,
      :category => "MyString"
    ).as_new_record)
  end

  it "renders new participant_quote form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => participant_quotes_path, :method => "post" do
      assert_select "input#participant_quote_quote", :name => "participant_quote[quote]"
      assert_select "input#participant_quote_user", :name => "participant_quote[user]"
      assert_select "input#participant_quote_category", :name => "participant_quote[category]"
    end
  end
end
