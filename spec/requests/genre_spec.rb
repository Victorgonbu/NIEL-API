require 'rails_helper'

RSpec.describe 'Genre' do
  describe 'GET .index' do
    it 'should return array with all current genres' do
      FactoryBot.create(:genre)
      get '/api/v1/genres'
      expect(response_json['data'].length).to be(1)
      expect(response.status).to be(200)
      
      FactoryBot.create(:genre)
      get '/api/v1/genres'
      expect(response_json['data'].length).to be(2)
    end
  end

  describe 'GET .show' do
    it 'should return json with genre details and tracks' do
      genre = FactoryBot.create(:genre)
      track = FactoryBot.create(:track)
      GenreTrack.create(track_id: track.id, genre_id: genre.id)
      
      get "/api/v1/genres/#{genre.id}"
      response_ = response_json['data']
      expect(response_['attributes']).to have_key('name')
      expect(response_['attributes']).to have_key('slug')
      expect(response_['attributes']).to have_key('icon')
      expect(response_json['included'].length).to be(1)
      expect(response.status).to be(200)
    end
  end
end