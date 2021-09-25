require 'rails_helper'

RSpec.describe Genre, type: :model do
  describe 'associations' do
    it {should have_many(:genre_tracks)}
    it {should have_many(:tracks)}
  end

  describe '#slugify' do
  subject {FactoryBot.build(:genre)}
    it 'parameterize name and assign it to record slug' do
      expect(subject.slugify).to eq(subject.name.parameterize)
    end
  end
end
