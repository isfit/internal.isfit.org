require 'spec_helper'

describe "motds/index" do
  before(:each) do
    assign(:motds, [
      stub_model(Motd,
        :msg => "Msg"
      ),
      stub_model(Motd,
        :msg => "Msg"
      )
    ])
  end

  it "renders a list of motds" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Msg".to_s, :count => 2
  end
end
