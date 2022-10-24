require 'rails_helper'

RSpec.describe ProfilesController, type: :request do
  describe 'GET /new' do
    it 'returns http success' do
      get '/profiles/new'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST /create' do
    context 'with valid username parameter' do
      let(:valid_username) { 'user-1234' }
      it 'creates a new profile' do
        expect { post '/profiles', params: { username: valid_username } }
          .to change(Profile, :count).by(1)

        expect(response).to have_http_status(:created)
      end
    end
    context 'with invalid username parameter' do
      let(:invalid_username) { 'user-1234/!' }

      it 'returns unprocessable_entity' do
        expect { post '/profiles', params: { username: invalid_username } }
          .to change(Profile, :count).by(0)

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
