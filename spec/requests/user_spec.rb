require 'rails_helper'

RSpec.describe "User", type: :request do
  describe 'POST .create' do
    before(:each) do
      @user_params = {
        user: {
          name: 'victor',
          country: 'Colombia',
          email: 'victor@hotmail.com',
          password: 'password',
          password_confirmation: 'password'
        }
      }
    end
    it 'should create new user and return json with name and authToken' do
      
      post '/api/v1/users', params: @user_params
      expect(response.status).to be(200)
      expect(response_json['data']['attributes']).to have_key('name')
      expect(response_json['data']['attributes']).to have_key('authToken')
    end
    it 'should return array with errors if invalid fields' do
      @user_params[:user][:email] = 'victor'
      @user_params[:user][:name] = 'n'
      post '/api/v1/users', params: @user_params
      expect(response.status).to be(422)
      expect(response_json['errors']).to eq(["Name is too short (minimum is 6 characters)", "Email Invalid"]) 
    end
  end
end