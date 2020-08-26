require 'rails_helper'

date = '2020-08-25'
description = 'My Event'
other_description = 'My Other Event'
other_date = '2020-08-26'
other_other_description = 'My Other Other Event'
other_other_date = '2020-08-27'
name = { name: 'name' }
params = { user: name }
created_event = { description: description, date: date }
other_created_event = { description: other_description, date: other_date }
other_other_created_event = { description: other_other_description, date: other_other_date }

RSpec.describe 'Event Requests', type: :request do
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
    before :each do
      post '/users', params: params
      post '/sign_in', params: signin_params
    end

    describe 'it properly creates a new event' do
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
    end

    describe 'displays the correct home page with events as the root path' do
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

      it 'renders the events template' do
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
    end
    describe 'expected results are obtained when user attends events(s)' do
      before :all do
        post '/users', params: params
        post '/sign_in', params: name

        post '/events', params: { event: created_event }
        post '/events', params: { event: other_created_event }
        post '/events', params: { event: other_other_created_event }
      end

      describe ' ' do
        it 'renders page to attend events' do
          get '/attend_events'
          expect(response).to render_template('events/show_existing_events')
          expect(response).to be_successful
          expect(response.code).to eq '200'
          expect(response).to have_http_status(:ok)
          expect(response.body).to include(description)
          expect(response.body).to include(other_description)
          expect(response.body).to include(other_other_description)
        end

        it 'adds the correct events that will be attended by the user' do
          user = User.find_by(name)
          user_id = user.id
          events = []
          existing_events = Event.all
          events << existing_events.first << existing_events.last
          post '/attend_events', params: { event_ids: events.map(&:id) }
          expect(response.code).to eq '302'
          expect(response).to have_http_status(:found)
          expect(response).to redirect_to(user_path(user_id))
          expect(user.attended_events).to eq events

          # renders page to attend events with existing events that ther user has not yet registered to attend
          get '/attend_events'
          expect(response).to render_template('events/show_existing_events')
          expect(response).to be_successful
          expect(response.code).to eq '200'
          expect(response).to have_http_status(:ok)
          expect(response.body).not_to include(description)
          expect(response.body).to include(other_description)
          expect(response.body).not_to include(other_other_description)
        end
      end
    end
  end
end
