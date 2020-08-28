require 'rails_helper'

RSpec.describe 'events/new', type: :view do
  it 'render the events/new view template' do
    event = Event.new
    assign(:event, event)
    assign(:errors, [])

    render
    expect(response).to render_template('events/new')
  end
end
