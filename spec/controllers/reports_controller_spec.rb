require 'rails_helper'
require 'external/client'

RSpec.describe ReportsController, type: :request do
  describe 'GET /index' do
    let!(:profile1) { Profile.create(username: 'AAA') }
    let!(:profile2) { Profile.create(username: 'BBB') }

    it 'generates a report by profile' do
      get '/reports.json'

      expect(response).to be_successful

      body = JSON.parse(response.body)

      expect(body[0]['username']).to eq(profile1.username)
      expect(body[1]['username']).to eq(profile2.username)
    end

    it 'filters reports by repository tag' do
      Repository.create(profile_id: profile1.id, name: 'repo1', tags: 'linux,mysql')
      Repository.create(profile_id: profile2.id, name: 'repo2', tags: 'osx,mysql')

      get '/reports.json?tag=linux'

      expect(response).to be_successful

      body = JSON.parse(response.body)
      expect(body.length).to eq(1)
      expect(body[0]['username']).to eq(profile1.username)
    end
  end

  describe 'GET /reports/external' do
    let(:profiles) do
      [
        {
          id: 1,
          username: 'AAA'
        }, {
          id: 2,
          username: 'BBB'
        }
      ]
    end

    let(:repositories) do
      [
        {
          name: 'repo1',
          profile_id: 1
        }, {
          name: 'repo2',
          profile_id: 2
        }
      ]
    end

    before do
      allow_any_instance_of(External::Client).to receive(:fetch_profiles)
        .and_return(profiles)
      allow_any_instance_of(External::Client).to receive(:fetch_repositories)
        .and_return(repositories)
    end

    it 'generates one report by profile' do
      get '/reports/external'

      expect(response).to be_successful

      body = JSON.parse(response.body)

      expect(body[0]['username']).to eq(profiles[0]['username'])
      expect(body[1]['username']).to eq(profiles[1]['username'])
    end

    it 'attaches repositories to the reports' do
      get '/reports/external'

      expect(response).to be_successful

      body = JSON.parse(response.body)

      expect(body[0]['repositories'][0]['name']).to eq(repositories[0]['name'])
      expect(body[1]['repositories'][0]['name']).to eq(repositories[1]['name'])
    end
  end
end
