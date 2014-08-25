require 'rails_helper'

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
    @user = create(:user)
    @user.stub(:role?).and_return(false)
    @user.stub(:role?).with(:internal).and_return(true)
  end


  it "should be valid" do
    new_user.should be_valid
  end

  it "should validate password is longer than 3 characters" do
    user = new_user(:password => 'bad')
    expect(user.valid?).to be_falsey
    expect(user.errors[:password].size).to eq(1)
  end

  it "should require matching password confirmation" do
    user = new_user(:password_confirmation => 'nonmatching')
    expect(user.valid?).to be_falsey
    expect(user.errors[:password_confirmation].size).to eq(1)
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
    user.authenticate('badpassword').should be false
  end

  it "should return full name on full_name method" do
    user = new_user(given_name: "Iver", family_name: "Dihle Skjervum")
    user.full_name.should == "Iver Dihle Skjervum"
  end

  describe "abilities" do 
    subject { ability }
    let(:ability) {Ability.new(@user)}
    context "When is an ordinary func" do
      it "should only be able to delete his own room bookings" do
       should be_able_to(:destroy, RoomBooking.new(:user => @user)) 
       should_not be_able_to(:destroy, RoomBooking.new)
      end
    end
  end
end
