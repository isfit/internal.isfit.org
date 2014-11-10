module ControllerMacros
  def login_user
    before do
      @controller.stub(:logged_in?).and_return(true)
      User.any_instance.stub(:role?).and_return(true)
    end
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    @current_user
  end
end
