require 'rails_helper'

RSpec.describe 'User Requests', type: :request do
  let(:name) { { name: 'new_name' } }
  describe 'when user is not logged in' do
    it 'retrieves the signup page' do
      get '/sign_up'
      expect(response).to be_successful
      expect(response.code).to eq '200'
      expect(response).to have_http_status(:ok)
      expect(response).to render_template('users/new')
    end

    it 'retrieves the users/new page' do
      get '/users/new'
      expect(response).to be_successful
      expect(response.code).to eq '200'
      expect(response).to have_http_status(:ok)
      expect(response).to render_template('users/new')
    end

    it 'creates a new user successfully and redirects to the show page' do
      post '/users', params: { user: name }
      expect(response).to redirect_to(user_path(assigns(:user).id))
      expect(response.code).to eq '302'
      expect(response).to have_http_status(:found)
      expect(User.find_by(name: 'new_name')).to_not eq nil
    end

    it 'redirects to the login page if the user is not signed in' do
      get '/users/1'
      expect(response).to redirect_to(sign_in_path)
    end
  end
  describe 'when user is logged in' do
    it 'renders the correct show page' do
      post '/users', params: { user: name }
      post '/sign_in', params: name
      user_id = User.find_by(name).id
      get "/users/#{user_id}"

      expect(response.code).to eq '200'
      expect(response).to have_http_status(:ok)
      expect(response).to render_template(:show)
    end
  end
end
