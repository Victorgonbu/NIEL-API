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
  
  describe 'GET index' do
    it 'should return all licenses' do

      get '/api/v1/licenses'
      debugger
      expect(response_json["data"])
    end
  end
end