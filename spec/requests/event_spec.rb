require 'rails_helper'

RSpec.describe 'Event Requests', type: :request do
  let(:name) { { name: 'name' } }
  let(:params) { { user: name } }
  describe 'when user is not logged in ' do
    it 'redirects to the login page if the user is not signed in' do
      get '/events/new'
      expect(response).to redirect_to(sign_in_path)
    end

    it 'retrieves the signup page' do
      get '/sign_up'
      expect(response).to be_successful
      expect(response.code).to eq '200'
      expect(response).to have_http_status(:ok)
      expect(response).to render_template('users/new')
    end

    it 'creates a new user successfully and redirects to the sigin page' do
      post '/users', params: params
      expect(response).to redirect_to(user_path(assigns(:user).id))
      expect(response.code).to eq '302'
      expect(response).to have_http_status(:found)
    end
  end

  describe 'when user is logged in ' do
    let(:signin_params) { name }
    let(:description) { 'My Event' }
    let(:date) { '2020-08-25' }
    let(:created_event) { { description: description, date: date } }

    before :each do
      post '/users', params: params
      post '/sign_in', params: signin_params
    end

    it "creates an event and redirects to the event's page" do
      post '/events', params: { event: created_event }

      expect(response).to redirect_to(assigns(:event))
      follow_redirect!

      expect(response).to render_template(:show)
      expect(response.body).to include('Event was successfully created.')
      expect(response.body).to include('Description:')
      expect(response.body).to include(description)
      expect(response.body).to include('Date:')
      expect(response.body).to include(date)
      expect(response.body).to include('Attendees:')
      expect(response.body).to include(name[:name])
    end

    it 'does not render a different template' do
      get '/events/new'
      expect(response).to_not render_template(:show)
    end

    it 'renders the home page template' do
      get '/'
      expect(response).to render_template(:index)
      expect(response).to be_successful
      expect(response.code).to eq '200'
      expect(response).to have_http_status(:ok)
      expect(response.body).to include('Events')
      expect(response.body).to include('Upcoming Events')
      expect(response.body).to include('Past Events')
      expect(response.body).to include('Description')
      expect(response.body).to include('Date')
    end

    it 'renders the home page template' do
      post '/events', params: { event: created_event }
      get '/events'
      expect(response).to render_template(:index)
      expect(response.body).to include('Events')
      expect(response.body).to include('Upcoming Events')
      expect(response.body).to include('Past Events')
      expect(response.body).to include('Description')
      expect(response.body).to include(description)
      expect(response.body).to include('Date')
      expect(response.body).to include(date)
    end
    it 'renders page to attend events' do
      get '/attend_events'
      expect(response).to render_template('events/show_existing_events')
      expect(response).to be_successful
      expect(response.code).to eq '200'
      expect(response).to have_http_status(:ok)
    end

    it 'renders page to attend events' do
      post '/events', params: { event: created_event }
      event = Event.find_by(description: description)
      id = event.id
      user = User.find_by(name)
      user_id = user.id
      post '/attend_events', params: { event_ids: [id] }
      expect(response.code).to eq '302'
      expect(response).to have_http_status(:found)
      expect(response).to redirect_to(user_path(user_id))
      expect(user.attended_events).to eq [event]
    end
  end
end
