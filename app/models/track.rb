class Track < ApplicationRecord
  has_one_attached :image_file, dependent: :destroy
  has_one_attached :mp3_file, dependent: :destroy
  has_one_attached :zip_file, dependent: :destroy
  has_one_attached :wav_file, dependent: :destroy
  has_many :genre_tracks, dependent: :destroy
  has_many :genres, through: :genre_tracks
  has_many :orders, as: :orderable, dependent: :destroy
  has_many :purchases, ->{where complete: true}, as: :orderable, class_name: 'Order', dependent: :destroy
end
