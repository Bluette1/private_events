require 'rails_helper'

RSpec.describe 'users/new', type: :view do
  it 'render the users/new view template' do
    user = User.new
    assign(:user, user)
    assign(:errors, [])

    render
    expect(response).to render_template('users/new')
  end
end
