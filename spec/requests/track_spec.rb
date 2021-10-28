require 'rails_helper'

RSpec.describe 'Track', type: :request, debbug: true do
  let!(:admin) do
    FactoryBot.create(:admin)
  end
  let!(:user) do
    FactoryBot.create(:user)
  end
  let!(:genre) do
    FactoryBot.create(:genre)
  end
  describe 'POST .create' do
    it  'create track record with all its attachements' do
      authToken = JsonWebToken.encode(sub: admin.id)
      track_attributes = {track: attributes_for(:track).merge({genres: [{id: genre.id}]})}
      post '/api/v1/tracks', params: track_attributes, headers: {Authorization: "Bearer #{authToken}"}
      attributes =  response_json["data"]['attributes']
      expect(response).to have_http_status(200)
      track_have_base_attributes(attributes)
      expect(attributes['wavFile']).not_to be_empty()
      expect(attributes['zipFile']).not_to be_empty()
      expect(response_json["included"].length).to be(1)
    end
  end

  describe 'GET show' do
    let!(:track) { FactoryBot.create(:track) }
      #before(:each) {
      #  Track.create(@track_params[:track])
      #  GenreTrack.create(genre_id: genre.id, track_id: Track.last.id)
      #}

    context "return track base attributes" do
      it 'when none licence purchase' do
        authToken = JsonWebToken.encode(sub: user.id)
        get "/api/v1/tracks/#{track.id}", headers: {Authtorization: "Bearer #{authToken}"}
        attributes = response_json["data"]["attributes"]
        expect(response).to have_http_status(200)
        track_have_base_attributes(attributes)
        expect(attributes["wavFile"]).to be_falsy()
        expect(attributes["zipFile"]).to be_falsy()
      end
  
      it "when user signed in" do
        get "/api/v1/tracks/#{track.id}"
        attributes = response_json["data"]["attributes"]
        expect(response).to have_http_status(200)
        track_have_base_attributes(attributes)
        expect(attributes["wavFile"]).to be_falsy()
        expect(attributes["zipFile"]).to be_falsy()
       
      end
    end
    
    it "return track base attributes with mp3_file if user owns standar license" do
      licen = FactoryBot.create(:standard)
      FactoryBot.create(:order_complete, orderable: track, license: licen, user: user)

      authToken = JsonWebToken.encode(sub: user.id)
      get "/api/v1/tracks/#{track.id}", headers: {Authorization: "Bearer #{authToken}"}
      attributes = response_json["data"]["attributes"]
      expect(response).to have_http_status(200)
      track_have_base_attributes(attributes)
      expect(attributes["own"]).to be_truthy()
      expect(attributes["wavFile"]).to be_falsy()
      expect(attributes["zipFile"]).to be_falsy()
    end
    it "return track base attributes with mp3_file and wavFile if user owns premium license" do
      licen = FactoryBot.create(:premium)
      FactoryBot.create(:order_complete, orderable: track, license: licen, user: user)

      authToken = JsonWebToken.encode(sub: user.id)
      get "/api/v1/tracks/#{track.id}", headers: {Authorization: "Bearer #{authToken}"}
      attributes = response_json["data"]["attributes"]
      expect(response).to have_http_status(200)
      track_have_base_attributes(attributes)
      expect(attributes["own"]).to be_truthy()
      expect(attributes["wavFile"]).not_to be_empty()
      expect(attributes["zipFile"]).to be_falsy()
    end

    context "return track with all base attributes and files" do
      it "when user owns unlimited license" do
        licen = FactoryBot.create(:unlimited)
        FactoryBot.create(:order_complete, orderable: track, license: licen, user: user)
        
        authToken = JsonWebToken.encode(sub: user.id)
        get "/api/v1/tracks/#{track.id}", headers: {Authorization: "Bearer #{authToken}"}
        attributes = response_json["data"]["attributes"]
        expect(response).to have_http_status(200)
        track_have_base_attributes(attributes)
        expect(attributes["own"]).to be_truthy()
        expect(attributes["wavFile"]).not_to be_empty()
        expect(attributes["zipFile"]).not_to be_empty()
      end
  
      it "when admin user" do
        authToken = JsonWebToken.encode(sub: admin.id)
        get "/api/v1/tracks/#{track.id}", headers: {Authorization: "Bearer #{authToken}"}
        attributes = response_json["data"]["attributes"]
        expect(response).to have_http_status(200)
        track_have_base_attributes(attributes)
        expect(attributes["own"]).to be_falsy()
        expect(attributes["wavFile"]).not_to be_empty()
        expect(attributes["zipFile"]).not_to be_empty()
      end
    end
    
    

    it "return track list of related tracks if any" do
        related_track = Track.create(attributes_for(:related_track))
        GenreTrack.create(genre_id: genre.id, track_id: track.id)
        GenreTrack.create(genre_id: genre.id, track_id: related_track.id)
        get "/api/v1/tracks/#{track.id}"
        expect(response).to have_http_status(200)
        expect(response_json["data"]["attributes"]["relatedTracks"]["data"].length).to be(1)
        expect(response_json["data"]["attributes"]["relatedTracks"]["data"].first["attributes"]["name"]).to eq("related track name")
      end
  end

  describe 'GET index' do
    before(:each) {
      FactoryBot.create(:track)
      FactoryBot.create(:related_track)
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
