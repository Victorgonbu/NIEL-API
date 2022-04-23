require 'rails_helper'

RSpec.describe 'Genre', type: :request do
  describe 'GET .index' do
    before { create_list(:genre, 2) }
    it 'should return array with all current genres' do
      get '/api/v1/genres'
      expect(index_result_json.length).to be(2)
      expect(response.status).to be(200)
    end
  end

  describe 'GET .show' do
    before do
      genre = create(:genre)
      track = create(:track)
      GenreTrack.create(genre: genre, track: track)
    end

    it 'should return json with genre details and tracks' do
      get "/api/v1/genres/#{Genre.last.slug}"
      data = response_json[:data]
      expect(data[:attributes]).to have_key('name')
      expect(data[:attributes]).to have_key('slug')
      expect(data[:attributes]).to have_key('icon')
      expect(response_json[:included].length).to be(1)
      expect(response.status).to be(200)
    end
    it 'should return json not found message if genre does not exist' do
      get "/api/v1/genres/#{Faker::Lorem.word}"
      error_message = response_json[:errors]
      expect(error_message).to eq('Genre not found')
      expect(response.status).to be(404)
    end
  end
end