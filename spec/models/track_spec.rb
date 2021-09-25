require 'rails_helper'

RSpec.describe Track, type: :model do
  describe 'associations' do 
    it {should have_one_attached(:image_file)}
    it {should have_one_attached(:mp3_file)}
    it {should have_one_attached(:zip_file)}
    it {should have_one_attached(:wav_file)}
    it {should have_many(:genre_tracks)}
    it {should have_many(:genres)}
    it {should have_many(:orders)}
    it {should have_many(:purchases).class_name('Order')}
  end
end
