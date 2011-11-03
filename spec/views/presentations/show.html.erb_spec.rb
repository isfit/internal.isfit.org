require 'spec_helper'

describe "presentations/show.html.erb" do
  before(:each) do
    @presentation = assign(:presentation, stub_model(Presentation,
      :title => "Title",
      :markdown_text => "MyText",
      :user => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Title/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/MyText/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
  end
end
