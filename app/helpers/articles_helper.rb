module ArticlesHelper
  def current_user_can_see_applications?
    if current_user.role?(:admin) || current_user.role?(:recruiting) || current_user.role?(:board) || current_user.role?(:wingman) || current_user.role?(:interviewer) || current_user.role?(:leader)
      true
    else
      false
    end
  end
end
