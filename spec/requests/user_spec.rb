require 'rails_helper'

RSpec.describe "User", type: :request do
  describe 'POST .create' do
    context 'when valid' do
      let(:user_params) { { user: attributes_for(:user, name: name) } }
      let(:name) { Faker::Name.name }

      it 'should create new user and return json with name and authToken' do
        post '/api/v1/users', params: user_params
        expect(response.status).to be(200)
        expect(response_json['data']['attributes']["name"]).to eq(name)
        expect(response_json['data']['attributes']["authToken"]).to be_truthy
      end
    end

    context 'when invalid' do
      let(:invalid_user_params) { { user: attributes_for(:invalid_user) } }

      it 'should return array with errors if invalid fields' do
        post '/api/v1/users', params: invalid_user_params
        expect(response.status).to be(422)
        expect(response_json['errors']).to eq(["Name is too short (minimum is 6 characters)", "Email Invalid"]) 
      end
    end
  end
end