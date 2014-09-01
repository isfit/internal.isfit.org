require 'spec_helper'

describe "motds/show" do
  before(:each) do
    @motd = assign(:motd, stub_model(Motd,
      :msg => "Msg"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Msg/)
  end
end
