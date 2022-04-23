require 'rails_helper'

describe 'License', type: :request, debug: true do
  let!(:standard) do
    FactoryBot.create(:standard)
  end
  let!(:premium) do
    FactoryBot.create(:premium)
  end

  let!(:unlimited) do
    FactoryBot.create(:unlimited)
  end
  
  describe 'GET index', focus: true do
    it 'should return all licenses' do

      get '/api/v1/licenses'
      
      expect(response_json["data"].length).to be(3)
      expect(response_json["data"][0]["attributes"]["name"]).to eq("License name")
      expect(response_json["data"][0]["attributes"]["description"]).to eq("License description")
      expect(response_json["data"][0]["attributes"]["files"]).to eq("mp3")
      expect(response_json["data"][0]["attributes"]["number"]).to eq(1)
      expect(response_json["data"][0]["attributes"]["price_cents"]).to eq(30)
      expect(response_json["data"][0]["relationships"]).to have_key("orders")
    end
  end
end