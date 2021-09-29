require 'rails_helper'

RSpec.describe 'Track', type: :request do
  before(:each) {
    @track_params = {
      genres: [1],
      track: {
        name: 'track name',
        bpm: 100,
        pcm: '[1, 0, 3, 4]',
        buyable: true,
        mp3_file: Rack::Test::UploadedFile.new('app/assets/tests/mp3.mp3', 'audio/mp3'),
        wav_file: Rack::Test::UploadedFile.new('app/assets/tests/wav.wav', 'audio/wav'),
        image_file: Rack::Test::UploadedFile.new('app/assets/tests/image.png', 'image/png'),
        zip_file: Rack::Test::UploadedFile.new('app/assets/tests/zip.zip', 'file/zip')
      }
    }
    User.create(name: 'victor', email: 'victor@email.com', password: 'victor',
    password_confirmation: 'victor', country: 'Col', admin: true)
    User.create(name: 'manuel', email: 'manuel@email.com', password: 'victor',
      password_confirmation: 'victor', country: 'Col', admin: false)
    Genre.create(name: 'Rock', icon: 'rock_icon')
  }
  describe 'POST .create' do
    it  'create track record with all its attachements' do
      
      authToken = JsonWebToken.encode(sub: User.first.id)
      post '/api/v1/tracks', params: @track_params, headers: {Authorization: "Bearer #{authToken}"}

      attributes =  response_json["data"]['attributes']
      expect(response).to have_http_status(200)
      expect(attributes.keys).to include('buyable', 'name', 'bpm', 'pcm', 'relatedTracks')
      expect(attributes['imageFile']).not_to be_empty()
      expect(attributes['mp3File']).not_to be_empty()
      expect(attributes['wavFile']).not_to be_empty()
      expect(attributes['zipFile']).not_to be_empty()
      expect(response_json["included"].length).to be(1)
    end
  end

  describe 'GET show' do
    before(:each) {
      Track.create(@track_params[:track])
    }
    it 'return track base attributes if no licence purchase' do
      authToken = JsonWebToken.encode(sub: User.last.id)
      get "/api/v1/tracks/#{Track.first.id}", headers: {Authtorization: "Bearer #{authToken}"}
      attributes = response_json["data"]["attributes"]
      expect(response).to have_http_status(200)
      expect(attributes.keys).to include('buyable', 'name', 'bpm', 'pcm', 'relatedTracks')
      expect(attributes["imageFile"]).not_to be_empty()
      expect(attributes["mp3File"]).not_to be_empty()
      expect(attributes["wavFile"]).to be_falsy()
      expect(attributes["zipFile"]).to be_falsy()
    end

    it "return track base attributes if no user signed in" do
      
    end
  end
end
