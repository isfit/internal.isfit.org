require File.dirname(__FILE__) + '/../spec_helper'

describe User do
  def new_user(attributes = {})
    attributes[:username] ||= 'foo'
    attributes[:email] ||= 'foo@example.com'
    attributes[:password] ||= 'abc12345'
    attributes[:password_confirmation] ||= attributes[:password]
    User.new(attributes)
  end

  before(:each) do
    User.delete_all
  end

  it "should be valid" do
    new_user.should be_valid
  end

  it "should validate password is longer than 3 characters" do
    new_user(:password => 'bad').should have(1).error_on(:password)
  end

  it "should require matching password confirmation" do
    new_user(:password_confirmation => 'nonmatching').should have(1).error_on(:password)
  end

  it "should authenticate by username" do
    user = new_user(:username => 'foobar', :password => 'secret12')
    user.save!
    user.authenticate('secret12').should == user
  end

  it "should authenticate by email" do
    user = new_user(:email => 'foo@bar.com', :password => 'secret12')
    user.save!
    user.authenticate('secret12').should == user
  end

  it "should not authenticate bad password" do
    user = new_user(:username => 'foobar', :password => 'secret12')
    user.save!
    user.authenticate('badpassword').should be_false
  end
end
