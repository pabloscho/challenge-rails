require 'rails_helper'

RSpec.describe "Profiles", type: :request do
  describe "GET /new" do
    it "returns http success" do
      get "/profiles/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /create" do
    it "returns http success" do
      post "/profiles/create"
      expect(response).to have_http_status(:success)
    end
  end

end
