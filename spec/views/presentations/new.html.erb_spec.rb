require 'spec_helper'

describe "presentations/new.html.erb" do
  before(:each) do
    assign(:presentation, stub_model(Presentation,
      :title => "MyString",
      :markdown_text => "MyText",
      :user => nil
    ).as_new_record)
  end

  it "renders new presentation form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => presentations_path, :method => "post" do
      assert_select "input#presentation_title", :name => "presentation[title]"
      assert_select "textarea#presentation_markdown_text", :name => "presentation[markdown_text]"
      assert_select "input#presentation_user", :name => "presentation[user]"
    end
  end
end
