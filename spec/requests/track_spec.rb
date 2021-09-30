require 'rails_helper'

RSpec.describe 'Track', type: :request do
  before(:all) {
  
    User.create(name: 'victor', email: 'victor@email.com', password: 'victor',
    password_confirmation: 'victor', admin: true)
    User.create(name: 'manuel', email: 'manuel@email.com', password: 'victor',
      password_confirmation: 'victor', admin: false)
    Genre.create(name: 'Rock', icon: 'rock_icon')
    @track_params = track_params
  }
  describe 'POST .create' do
    it  'create track record with all its attachements' do
      
      authToken = JsonWebToken.encode(sub: User.first.id)
      post '/api/v1/tracks', params: @track_params, headers: {Authorization: "Bearer #{authToken}"}

      attributes =  response_json["data"]['attributes']
      expect(response).to have_http_status(200)
      track_have_base_attributes(attributes)
      expect(attributes['wavFile']).not_to be_empty()
      expect(attributes['zipFile']).not_to be_empty()
      expect(response_json["included"].length).to be(1)
    end
  end

  describe 'GET show' do
    before(:each) {
      Track.create(@track_params[:track])
      Genre.create(name: "Rock", icon: 'rock_icon')
      GenreTrack.create(genre_id: Genre.last.id, track_id: Track.last.id)
    }
    it 'return track base attributes if no licence purchase' do
      authToken = JsonWebToken.encode(sub: User.last.id)
      get "/api/v1/tracks/#{Track.first.id}", headers: {Authtorization: "Bearer #{authToken}"}
      attributes = response_json["data"]["attributes"]
      expect(response).to have_http_status(200)
      track_have_base_attributes(attributes)
      expect(attributes["wavFile"]).to be_falsy()
      expect(attributes["zipFile"]).to be_falsy()
    end

    it "return track base attributes if no user signed in" do
      get "/api/v1/tracks/#{Track.first.id}"
      attributes = response_json["data"]["attributes"]
      expect(response).to have_http_status(200)
      track_have_base_attributes(attributes)
      expect(attributes["wavFile"]).to be_falsy()
      expect(attributes["zipFile"]).to be_falsy()
     
    end

    it "return track base attributes with mp3_file if user owns standar license" do
      licen = License.create(name: 'standard', description: 'description', price_cents: 30, number: 1) 
      Track.first.orders.create(license_id: License.last.id, complete: true, token: 'token', user_id: User.last.id)
      authToken = JsonWebToken.encode(sub: User.last.id)
      get "/api/v1/tracks/#{Track.first.id}", headers: {Authorization: "Bearer #{authToken}"}
      attributes = response_json["data"]["attributes"]
      expect(response).to have_http_status(200)
      track_have_base_attributes(attributes)
      expect(attributes["own"]).to be_truthy()
      expect(attributes["wavFile"]).to be_falsy()
      expect(attributes["zipFile"]).to be_falsy()
    end
    it "return track base attributes with mp3_file and wavFile if user owns premium license" do
      License.create(name: 'premium', description: 'description', price_cents: 50, number: 2)
      Track.first.orders.create(license_id: License.last.id, complete: true, token: 'token', user_id: User.last.id)
      authToken = JsonWebToken.encode(sub: User.last.id)
      get "/api/v1/tracks/#{Track.first.id}", headers: {Authorization: "Bearer #{authToken}"}
      attributes = response_json["data"]["attributes"]
      expect(response).to have_http_status(200)
      track_have_base_attributes(attributes)
      expect(attributes["own"]).to be_truthy()
      expect(attributes["wavFile"]).not_to be_empty()
      expect(attributes["zipFile"]).to be_falsy()
    end
    it "return track base attributes with mp3_file, wavFile and zipFile if user owns unlimited license" do
      License.create(name: 'unlimited', description: 'description', price_cents: 50, number: 3)
      Track.first.orders.create(license_id: License.last.id, complete: true, token: 'token', user_id: User.last.id)
      authToken = JsonWebToken.encode(sub: User.last.id)
      get "/api/v1/tracks/#{Track.first.id}", headers: {Authorization: "Bearer #{authToken}"}
      attributes = response_json["data"]["attributes"]
      expect(response).to have_http_status(200)
      track_have_base_attributes(attributes)
      expect(attributes["own"]).to be_truthy()
      expect(attributes["wavFile"]).not_to be_empty()
      expect(attributes["zipFile"]).not_to be_empty()
    end

    it "return track base attributes with mp3_file, wavFile and zipFile if admin user" do
      authToken = JsonWebToken.encode(sub: User.first.id)
      get "/api/v1/tracks/#{Track.first.id}", headers: {Authorization: "Bearer #{authToken}"}
      attributes = response_json["data"]["attributes"]
      expect(response).to have_http_status(200)
      track_have_base_attributes(attributes)
      expect(attributes["own"]).to be_falsy()
      expect(attributes["wavFile"]).not_to be_empty()
      expect(attributes["zipFile"]).not_to be_empty()
    end

    it "return track list of related tracks if any" do
        Track.create(@track_params[:track])
        GenreTrack.create(genre_id: Genre.last.id, track_id: Track.last.id)
        get "/api/v1/tracks/#{Track.last.id}"
        expect(response).to have_http_status(200)
        expect(response_json["data"]["attributes"]["relatedTracks"].length).to be(1)
    end
  end

  describe 'GET index' do
    before(:each) {
      Track.create(@track_params[:track])
      Track.create(@track_params[:track])
    }
    describe 'return array with all tracks' do
      context "return data depending on page given as parameter" do
        it 'return data of page passed is url params' do
          get  '/api/v1/tracks/?page=1'
          expect(response).to have_http_status(200)
          expect(response_json["data"].length).to be(2)
        end

        it 'return error message if no data for page passed in url params' do
          get  '/api/v1/tracks/?page=2'
          expect(response).to have_http_status(404)
          expect(response_json["errors"]).to eq(["Not found"])
        end
      end
      
    end
  end
end
