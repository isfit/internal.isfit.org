require 'spec_helper'

describe "motds/new" do
  before(:each) do
    assign(:motd, stub_model(Motd,
      :msg => "MyString"
    ).as_new_record)
  end

  it "renders new motd form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", motds_path, "post" do
      assert_select "input#motd_msg[name=?]", "motd[msg]"
    end
  end
end
