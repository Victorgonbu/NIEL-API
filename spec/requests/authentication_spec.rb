require 'rails_helper'

RSpec.describe 'Authentication' do
  describe 'POST .create' do
    context 'when valid credentials' do
      before { create(:user, email: email) }
      let(:email) { Faker::Internet.email }
      let(:password) { 'password' }

      it 'return authToken and user name' do
        login_params = {
          user: {
            email: email,
            password: password
          }
        }
        post '/api/v1/authentication', params: login_params
        attributes = response_json["data"]["attributes"]
        expect(response).to have_http_status(200)
        expect(attributes["authToken"]).not_to be_empty()
        expect(attributes["name"]).not_to be_empty()
  
      end
    end

    context 'when invalid credentials' do
      let(:invalid_user) { build(:invalid_user) }
      it 'return array with errors if invalid credentials or no existent user' do
        post '/api/v1/authentication', params: { user: { email: invalid_user.email, password: invalid_user.password } }
        expect(response).to have_http_status(401)
        expect(response_json["errors"]).to eq(['Invalid email or password'])
      end
    end
  end
end