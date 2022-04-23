require 'rails_helper'

RSpec.describe 'Track', type: :request, focus: true do
  let!(:admin) { create(:admin) }
  let!(:user) { create(:user) }
  let!(:genres)  { create_list(:genre, 2) }

  describe 'POST create'do
    context 'when valid' do
      it  'create track record with all its attachements' do
        track_attributes = { track: attributes_for(:track).merge(genre_tracks_attributes: genres.map { |genre| {genre_id: genre.id} }) }
        post '/api/v1/tracks', params: track_attributes, headers: build_auth_header(admin)
        attributes =  response_json["data"]['attributes']

        expect(response).to have_http_status(201)
        track_have_base_attributes(attributes)
        expect(attributes['wavFile']).not_to be_empty()
        expect(attributes['zipFile']).not_to be_empty()
        expect(response_json["data"]["relationships"]["genres"]["meta"].count).to be(2)
      end
    end
  end

  describe 'GET show' do
    let!(:track) { FactoryBot.create(:track_with_genres) }
    

    context "return track base attributes" do

      it 'when none licence purchase' do
        get "/api/v1/tracks/#{track.id}", headers: build_auth_header(user)
        attributes = response_json["data"]["attributes"]
    
        expect(response).to have_http_status(200)
        track_have_base_attributes(attributes)
        expect(attributes["wavFile"]).to be_falsy()
        expect(attributes["zipFile"]).to be_falsy()
        expect(response_json["data"]["relationships"]["genres"]["meta"].length).to be(2)
      end
  
      it "when user not signed in" do
        get "/api/v1/tracks/#{track.id}"
        attributes = response_json["data"]["attributes"]
        expect(response).to have_http_status(200)
        track_have_base_attributes(attributes)
        expect(attributes["wavFile"]).to be_falsy()
        expect(attributes["zipFile"]).to be_falsy()
        expect(response_json["data"]["relationships"]["genres"]["meta"].length).to be(2)
      end
    end

    context "return track base attributes with mp3_file if user owns standard license" do
      before do
        create(:order_complete, orderable: track, license: create(:standard), user: user)
      end

      it "when valid" do
        get "/api/v1/tracks/#{track.id}", headers: build_auth_header(user)
        attributes = response_json["data"]["attributes"]
        track_have_base_attributes(attributes)
  
        expect(response).to have_http_status(200)
        expect(attributes["own"]).to be_truthy()
        expect(attributes["wavFile"]).to be_falsy()
        expect(attributes["zipFile"]).to be_falsy()
        expect(response_json["data"]["relationships"]["genres"]["meta"].length).to be(2)
      end
    end

    context "return track base attributes with mp3_file and wavFile if user owns premium license" do
      before do
        create(:order_complete, orderable: track, license: create(:premium), user: user)
      end

      it 'when valid' do
        get "/api/v1/tracks/#{track.id}", headers: build_auth_header(user)
        attributes = response_json["data"]["attributes"]

        expect(response).to have_http_status(200)
        track_have_base_attributes(attributes)
        expect(attributes["own"]).to be_truthy()
        expect(attributes["wavFile"]).not_to be_empty()
        expect(attributes["zipFile"]).to be_falsy()
        expect(response_json["data"]["relationships"]["genres"]["meta"].length).to be(2)
      end
    end

    context "return track with all base attributes and files" do
      before do
        create(:order_complete, orderable: track, license: create(:unlimited), user: user)
      end

      it "when user owns unlimited license" do      
        get "/api/v1/tracks/#{track.id}", headers: build_auth_header(user)
        attributes = response_json["data"]["attributes"]

        expect(response).to have_http_status(200)
        track_have_base_attributes(attributes)
        expect(attributes["own"]).to be_truthy()
        expect(attributes["wavFile"]).not_to be_empty()
        expect(attributes["zipFile"]).not_to be_empty()
        expect(response_json["data"]["relationships"]["genres"]["meta"].length).to be(2)
      end
  
      it "when admin user" do
        get "/api/v1/tracks/#{track.id}", headers: build_auth_header(admin)
        attributes = response_json["data"]["attributes"]

        expect(response).to have_http_status(200)
        track_have_base_attributes(attributes)
        expect(attributes["own"]).to be_falsy()
        expect(attributes["wavFile"]).not_to be_empty()
        expect(attributes["zipFile"]).not_to be_empty()
        expect(response_json["data"]["relationships"]["genres"]["meta"].length).to be(2)
      end
    end

    context "return related tracks" do
      before do
        create(:genre_track, track: track, genre: genres.first)
        create(:genre_track, track: create(:related_track), genre: genres.first)
      end

      it "if list with any related track" do
        get "/api/v1/tracks/#{track.id}"
        expect(response).to have_http_status(200)
        expect(response_json["data"]["attributes"]["relatedTracks"]["data"].length).to be(1)
        expect(response_json["data"]["attributes"]["relatedTracks"]["data"].first["attributes"]["name"]).to eq("related track name")
      end
    end
  end

  describe 'GET index' do
    before(:each) {
      track = create(:track)
      relalted_track = create(:related_track)
      genre_two = create(:genre, name: "Salsa")
    }
    describe "return array with tracks" do
      context "return array all tracks" do
        it 'return tracks by page passed is url params' do
          get  '/api/v1/tracks/?page=1'
          expect(response).to have_http_status(200)
          expect(index_result_json.length).to be(2)
        end

        it 'return error message if page passed in url params contains no tracks' do
          get  '/api/v1/tracks/?page=2'
          expect(response).to have_http_status(404)
          expect(response_json[:errors]).to eq(["Not found"])
        end
      end

      context 'return tracks by genre' do
        before(:each) {
          create(:genre_track, track: Track.first, genre: Genre.first)
          create(:genre_track, track: Track.last, genre: Genre.last)
        }
        context 'one genre' do
          it 'return tracks by page passed in url params' do
            
            get  '/api/v1/tracks?genres=rock&page=1'
            expect(response).to have_http_status(200)
            expect(index_result_json.length).to be(1)
          end
          it 'return error message if page passed in url contains no tracks' do
            get  '/api/v1/tracks?genres=rock&page=2'
            expect(response).to have_http_status(404)
            expect(response_json[:errors]).to eq(["Not found"])
          end
        end

        context 'two genres' do
          it 'return tracks by page passed in url params' do
            get  '/api/v1/tracks?genres=salsa,rock&page=1'
            expect(response).to have_http_status(200)
            expect(index_result_json.length).to be(2)
          end
          it 'return error message if page passed in url contains no tracks' do
            get  '/api/v1/tracks?genres=salsa,rock&page=2'
            expect(response).to have_http_status(404)
            expect(response_json["errors"]).to eq(["Not found"])
          end
        end
      end
    end
  end
end
