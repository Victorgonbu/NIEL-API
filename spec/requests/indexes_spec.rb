require 'rails_helper'

RSpec.describe "Indexes", type: :request do
  describe 'GET index' do
    it 'returns json with message' do
      get '/api/v1/indexes'
      expect(response.status).to eq(200)
      expect(response_json["data"]["message"]).to eq("NIELBEATS API")
    end
  end
end