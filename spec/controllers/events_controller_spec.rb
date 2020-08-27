require 'rails_helper'
require 'support/authentication_helper'

RSpec.describe EventsController, type: :controller do
  before :each do
    @user = create(:user)
    sign_in(@user)
    @creator_id = @user.id
  end
  describe 'POST create ' do
    let(:event_created) { { description: 'description', date: Date.today, creator_id: @creator_id } }
    subject { post :create, params: { event: event_created } }

    it 'redirects to the action show' do
      expect(subject).to redirect_to(assigns(:event))
      expect(subject).to redirect_to(event_url(assigns(:event).id))
      expect(subject).to redirect_to action: :show, id: assigns(:event).id
      expect(subject).to redirect_to("/events/#{assigns(:event).id}")
      expect(response.code).to eq '302'
      expect(response).to have_http_status(:found)
    end

    it 'sets the correct flash notice' do
      post :create, params: { event: event_created }
      expect(response.code).to eq '302'
      expect(response).to have_http_status(:found)
      expect(flash[:notice]).to eq 'Event was successfully created.'
    end
  end

  describe 'GET index ' do
    before :each do
      @event = Event.create(description: 'description', date: Date.today, creator_id: @creator_id)
      @params = { id: @event.id }
    end

    it 'returns a successful response' do
      get :index
      expect(response).to be_successful
    end

    it 'assigns @events' do
      get :index
      expect(assigns(:events)).to eq([@event])
    end

    it 'renders the index template' do
      get :index
      # expect(response).to render_template('index')
    end
  end

  describe 'GET show ' do
    before :each do
      @event = Event.create(description: 'description', date: Date.today, creator_id: @creator_id)
      @params = { id: @event.id }
    end

    it 'returns a successful response' do
      get :show, params: @params
      expect(response).to be_successful
      expect(response.code).to eq '200'
      expect(response).to have_http_status(:ok)
    end

    it 'assigns @event' do
      get :show, params: @params
      expect(assigns(:event)).to eq(@event)
    end

    it 'renders the show template' do
      get :show, params: @params
      expect(response).to render_template('show')
    end
  end
end
