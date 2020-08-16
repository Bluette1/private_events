module SessionsHelper
  def welcome
    'Nice to see you again, ' << @current_user.name << '!'
  end
end
