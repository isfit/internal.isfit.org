module ControllerMacros
  def login_user
    before do
      @controller.stub(:logged_in?).and_return(true)
      User.any_instance.stub(:role?).and_return(true)
    end
  end
end
