module UsersHelper
  def user_is_authorized_for_topics?
        current_user && current_user.admin?
  end
end
