require 'rails_helper'

RSpec.describe GenreTrack, type: :model do
  describe 'associations' do
    it {should belong_to(:genre)}
    it {should belong_to(:track)}
  end
end
