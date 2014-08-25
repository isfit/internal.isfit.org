require 'rails_helper'

describe Account do
  it "should be valid" do
    create(:account).should be_valid
  end
end
