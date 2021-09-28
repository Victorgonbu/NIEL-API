require 'rails_helper'

RSpec.describe 'Track', type: :request do
  before(:each) {
    User.create(name: 'victor', email: 'victor@email.com', password: 'victor',
    password_confirmation: 'victor', country: 'Col', admin: true)
    Genre.create(name: 'Rock', icon: 'rock_icon')
  }
  describe 'POST .create' do
    it  'create track record with all its attachements' do
      track_params = {
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
      authToken = JsonWebToken.encode(sub: User.first.id)
      post '/api/v1/tracks', params: track_params, headers: {Authorization: "Bearer #{authToken}"}

      expect(response_json).to eq('')
      expect(response.status).to be(200)
    end
  end
end
