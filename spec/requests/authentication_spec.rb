require 'rails_helper'

RSpec.describe 'Authentication' do
  describe 'POST .create' do
    before(:all) {
      User.create(name: 'victor', email: 'victor@hotmail.com', password: 'password', password_confirmation: 'password')
    }
    it 'return authToken and user name if valid credentials' do
      login_params = {
        user: {
          email: 'victor@hotmail.com',
          password: 'password'
        }
      }
      post '/api/v1/authentication', params: login_params
      attributes = response_json["data"]["attributes"]
      expect(response).to have_http_status(200)
      expect(attributes["authToken"]).not_to be_empty()
      expect(attributes["name"]).not_to be_empty()

    end

    it 'return array with errors if invalid credentials or no existent user' do
      post '/api/v1/authentication', params: {user: {email: '', password: ''}}
      expect(response).to have_http_status(422)
      expect(response_json["errors"]).to eq(['Invalid email or password'])
    end
  end
end