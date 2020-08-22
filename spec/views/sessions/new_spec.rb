require 'rails_helper'

RSpec.describe 'sessions/new', type: :view do
  it 'render the sessions/new view template' do
    render
    expect(response).to render_template('sessions/new')
  end
end
