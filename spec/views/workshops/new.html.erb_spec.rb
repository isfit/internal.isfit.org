require 'spec_helper'

describe "workshops/new" do
  before(:each) do
    assign(:workshop, stub_model(Workshop,
      :name => "MyString",
      :ingress => "MyText",
      :body => "MyText",
      :number => 1,
      :user => nil,
      :published => false,
      :got_comments => false
    ).as_new_record)
  end

  it "renders new workshop form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => workshops_path, :method => "post" do
      assert_select "input#workshop_name", :name => "workshop[name]"
      assert_select "textarea#workshop_ingress", :name => "workshop[ingress]"
      assert_select "textarea#workshop_body", :name => "workshop[body]"
      assert_select "input#workshop_number", :name => "workshop[number]"
      assert_select "input#workshop_user", :name => "workshop[user]"
      assert_select "input#workshop_published", :name => "workshop[published]"
      assert_select "input#workshop_got_comments", :name => "workshop[got_comments]"
    end
  end
end
