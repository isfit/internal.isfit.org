require 'rails_helper'

describe "motds/edit" do
  before(:each) do
    @motd = assign(:motd, Motd.create!(msg: "Msg"))
  end

  it "renders the edit motd form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", motd_path(@motd), "post" do
      assert_select "textarea#motd_msg[name=?]", "motd[msg]"
    end
  end
end
