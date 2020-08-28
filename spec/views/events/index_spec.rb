require 'rails_helper'

RSpec.describe 'events/index', type: :view do
  before :each do
    @creator_id = User.create(name: 'creator').id
    event_one = Event.create!(description: 'description_one', date: Date.today, creator_id: @creator_id)
    event_two = Event.create!(description: 'description_two', date: Date.today, creator_id: @creator_id)
    assign(:events, [
             event_one,
             event_two
           ])

    assign(:upcoming, [
             event_one,
             event_two
           ])

    assign(:past, [])
  end

  it 'render the index view template' do
    render
    expect(response).to render_template('index')
  end

  it 'displays both events correctly' do
    render template: 'events/index.html.erb'
    expect(rendered).to match Regexp.new('description_one')
    expect(rendered).to match Regexp.new('description_two')
    expect(rendered).to match Regexp.new(Date.today.to_s)
  end
end
