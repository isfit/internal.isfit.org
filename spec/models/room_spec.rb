require 'rails_helper'

describe Room do
  it "should be valid" do
    create(:room).should be_valid
  end
end
