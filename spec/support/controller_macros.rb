module ControllerMacros
  def login_user
    before do
      @controller.stubs(:logged_in?).returns(true)
      User.any_instance.stub(:role?).and_return(true)
    end
  end
end
