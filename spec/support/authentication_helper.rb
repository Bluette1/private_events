module AuthenticationHelper
  def sign_in(user)
    # user = User.create(name: "user")
    login(user)
  end

  def login(user)
    user = User.find(user.id)
    request.session[:current_user_id] = user.id
  end

  def current_user
    User.find(request.session[:current_user_id])
  end
end

# spec/spec_helper.rb
# RSpec.configure do |config|
#   config.include SpecTestHelper, :type => :controller
# end
#   Now in any of our controller examples, we can call login(some_user) to simulate logging in as that us
