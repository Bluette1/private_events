require 'rails_helper'
require 'view_helpers/show_user_html_helper'

RSpec.describe 'users/show', type: :view do
    before :each do
        creator = User.create(name: 'creator')
        event_one = Event.create!(description: 'description_one', date: Date.today, creator_id: creator.id)
        event_two = Event.create!(description: 'description_two', date: Date.today, creator_id: creator.id)
        assign(:user, creator)
        assign(:errors, [])
     
        assign(:attended_events, [
            event_one,
            event_two
        ])

        assign(:upcoming_events, [
            event_two
        ])

        assign(:previous_events, [
            event_one
        ])
    
    
      end
  it 'render the users/show view template' do
    render
    expect(rendered).to eq user_html
    expect(response).to render_template('users/show')
  end

  it 'displays the expected content correctly' do
    render template: 'users/show.html.erb'
    expect(rendered).to match Regexp.new('description_one')
    expect(rendered).to match Regexp.new('description_two')
  end
end