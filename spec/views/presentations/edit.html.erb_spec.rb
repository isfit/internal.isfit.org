require 'spec_helper'

describe "presentations/edit.html.erb" do
  before(:each) do
    @presentation = assign(:presentation, stub_model(Presentation,
      :title => "MyString",
      :markdown_text => "MyText",
      :user => nil
    ))
  end

  it "renders the edit presentation form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => presentations_path(@presentation), :method => "post" do
      assert_select "input#presentation_title", :name => "presentation[title]"
      assert_select "textarea#presentation_markdown_text", :name => "presentation[markdown_text]"
      assert_select "input#presentation_user", :name => "presentation[user]"
    end
  end
end
