module ApplicationHelper
  def logged_in_user
    "Logged_in user: " << @current_user.name
  end
end
