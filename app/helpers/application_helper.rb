module ApplicationHelper
  def logged_in_user
    'Logged_in user: '
  end

  def current_user_name
    @current_user.name
  end

  def current_user_id
    @current_user.id
  end

  def current_user
    @current_user
  end
end
