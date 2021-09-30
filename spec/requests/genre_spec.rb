require 'rails_helper'

RSpec.describe 'Genre' do
  describe 'GET .index' do
    it 'should return array with all current genres' do
      Genre.create(name: 'Rock', icon: 'rock_icon', slug: 'rock')
      get '/api/v1/genres'
      expect(response_json['data'].length).to be(1)
      expect(response.status).to be(200)
      Genre.create(name: 'Reggaeton', icon: 'reggaeton_icon', slug: 'reggaeton')
      get '/api/v1/genres'
      expect(response_json['data'].length).to be(2)
    end
  end

  describe 'GET .show' do
    it 'should return json with genre details and tracks' do 
      Genre.create(name: 'Rock', icon: 'rock_icon', slug: 'rock')
      Track.create(track_params[:track])
      GenreTrack.create(track_id: Track.first.id, genre_id: Genre.first.id)
      get "/api/v1/genres/#{Genre.first.id}"
      response_ = response_json['data']
      expect(response_['attributes']).to have_key('name')
      expect(response_['attributes']).to have_key('slug')
      expect(response_['attributes']).to have_key('icon')
      expect(response_json['included'].length).to be(1)
      expect(response.status).to be(200)
    end
  end
end