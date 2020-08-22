require 'rails_helper'
require 'view_helpers/show_event_html_helper'

RSpec.describe 'events/show', type: :view do
  before :each do
    @creator = User.create(name: 'creator')
    @user = User.create(name: 'user')
    @event_one = Event.create!(description: 'description_one', date: Date.today, creator_id: @creator.id)
    @event_two = Event.create!(description: 'description_two', date: Date.today, creator_id: @creator.id)
    assign(:creator, @creator)
    assign(:attendees, [@creator, @user])
  end
  it 'render the events/show view template' do
    assign(:event, @event_one)
    render
    expect(rendered).to eq event_html
    expect(response).to render_template('events/show')
  end

  it 'displays the expected content for event one correctly' do
    assign(:event, @event_one)
    render template: 'events/show.html.erb'

    expect(rendered).to match Regexp.new('description_one')
    expect(rendered).to match Regexp.new('creator')
    expect(rendered).to match Regexp.new('user')
  end

  it 'displays the expected content for event two correctly' do
    assign(:event, @event_two)
    render template: 'events/show.html.erb'

    expect(rendered).to match Regexp.new('description_two')
    expect(rendered).to match Regexp.new('creator')
    expect(rendered).to match Regexp.new('user')
  end
end
