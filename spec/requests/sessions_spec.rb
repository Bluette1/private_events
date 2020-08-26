require 'rails_helper'

RSpec.describe 'Sessions Requests', type: :request do
  let(:name) { { name: 'new_name' } }

  describe 'when user logs in' do
    it 'retrieves the signin page' do
      get '/sign_in'

      expect(response).to render_template(:new)
      expect(response.code).to eq '200'
      expect(response).to have_http_status(:ok)
    end

    it 'logs in the user successfully' do
      post '/users', params: { user: name }
      post '/sign_in', params: name

      expect(response).to redirect_to(user_url(assigns(:user).id))
      expect(response).to redirect_to("/users/#{assigns(:user).id}")
      expect(flash[:notice]).to eq 'You have successfully logged in'
      expect(response.code).to eq '302'
      expect(response).to have_http_status(:found)
    end
  end

  describe 'failed login attempt' do
    it 'user fails to login with incorrect credentials' do
      post '/sign_in', params: { name: 'unknown' }
      expect(flash[:notice]).to eq 'Wrong name. Sign up or enter the correct name'
      expect(response).to render_template('new')
    end
  end

  describe 'successful log out' do
    it 'user logs out successfully' do
      post '/users', params: { user: name }
      post '/sign_in', params: name
      delete '/sign_out'

      expect(flash[:notice]).to eq 'You have successfully logged out.'
      expect(response).to redirect_to(sign_in_path)
      expect(response.code).to eq '302'
      expect(response).to have_http_status(:found)
    end
  end
end
