require 'rails_helper'

describe 'License', type: :request do
  before do
    create(:standard)
    create(:premium)
    create(:unlimited)
  end

  describe 'GET index' do
    it 'should return all licenses' do

      get '/api/v1/licenses'
      
      expect(index_result_json.length).to be(3)
    end
  end
end