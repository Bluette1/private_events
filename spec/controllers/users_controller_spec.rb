require 'rails_helper'
require 'support/authentication_helper'

RSpec.describe UsersController, type: :controller do
  describe 'POST create ' do
    subject { post :create, params: { user: { name: 'name' } } }

    it 'returns a successful response' do
      expect(subject).to redirect_to(assigns(:user))
      expect(subject).to redirect_to(user_url(assigns(:user).id))
      expect(subject).to redirect_to action: :show, id: assigns(:user).id
      expect(subject).to redirect_to("/users/#{assigns(:user).id}")
      expect(response.code).to eq '302'
      expect(response).to have_http_status(:found)
    end
    it 'renders the show template' do
      # get :show, params: @params
      # expect(response).to render_template("show")
    end
  end

  describe 'GET show ' do
    before :each do
      @user = create(:user)
      sign_in(@user)
      @params = { id: @user.id }
    end

    it 'returns a successful response' do
      get :show, params: @params
      expect(response).to be_successful
      expect(response.code).to eq '200'
      expect(response).to have_http_status(:ok)
    end

    it 'assigns @user' do
      get :show, params: @params
      expect(assigns(:user)).to eq(@user)
    end

    it 'renders the show template' do
      get :show, params: @params
      expect(response).to render_template('show')
    end
  end
end
