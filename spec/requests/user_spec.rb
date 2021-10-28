require 'rails_helper'

RSpec.describe "User", type: :request, debug: true do
  describe 'POST .create' do
    let!(:user_params) { { user: attributes_for(:user) } }
    let!(:invalid_user_params) { { user: attributes_for(:invalid_user) } }

    it 'should create new user and return json with name and authToken' do
      post '/api/v1/users', params: user_params
      expect(response.status).to be(200)
      expect(response_json['data']['attributes']["name"]).to eq('test user')
      expect(response_json['data']['attributes']["authToken"]).to be_truthy
    end
    it 'should return array with errors if invalid fields' do
      post '/api/v1/users', params: invalid_user_params
      expect(response.status).to be(422)
      expect(response_json['errors']).to eq(["Name is too short (minimum is 6 characters)", "Email Invalid"]) 
    end
  end
end