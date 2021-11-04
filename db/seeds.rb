# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# GENRES

#names = ['reggaeton', 'hip-hop', 'rap', 'bachata', 'afrobeat']
#
#names.each do |name|
#  record = Genre.new(name: name, icon: 'none')
#  if record.valid?
#    record.save
#  end
#end
#
#10.times do
#  track = Track.new(name: "track sample", bpm: 12, pcm: '[]')
#  if track.save
#    track.genre_tracks.create(genre_id: Genre.first.id)
#    track.genre_tracks.create(genre_id: Genre.second.id)
#    track.genre_tracks.create(genre_id: Genre.third.id)
#    track.genre_tracks.create(genre_id: Genre.fourth.id)
#    track.genre_tracks.create(genre_id: Genre.fifth.id)
#    track.image_file.attach(io: File.open(File.join(Rails.root,'app/assets/tests/image.png')), filename: 'image.png')
#    track.mp3_file.attach(io: File.open(File.join(Rails.root,'app/assets/tests/mp3.mp3')), filename: 'mp3.mp3')
#    track.zip_file.attach(io: File.open(File.join(Rails.root,'app/assets/tests/zip.zip')), filename: 'zip.zip')
#    track.wav_file.attach(io: File.open(File.join(Rails.root,'app/assets/tests/wav.wav')), filename: 'wav.wav')
#  end
#end

track = Track.new(name: "track with large title | trueno type beat", bpm: 12, pcm: '[]')
if track.save
  track.genre_tracks.create(genre_id: Genre.fourth.id)
  track.genre_tracks.create(genre_id: Genre.fifth.id)

  track.image_file.attach(io: File.open(File.join(Rails.root,'app/assets/tests/image.png')), filename: 'image.png')
  track.mp3_file.attach(io: File.open(File.join(Rails.root,'app/assets/tests/mp3.mp3')), filename: 'mp3.mp3')
  track.zip_file.attach(io: File.open(File.join(Rails.root,'app/assets/tests/zip.zip')), filename: 'zip.zip')
  track.wav_file.attach(io: File.open(File.join(Rails.root,'app/assets/tests/wav.wav')), filename: 'wav.wav')
end

#LICENSES
#License.create(name: 'Standard', description: 'Cannot be registered, Cannot be monetized', files: ".Mp3-file", price_cents: 29, number: 1)
#License.create(name: 'Premium', description: 'Cannot be registered, Cannot be monetized', files: ".Mp3-file, .Wav-file", price_cents: 49, number: 2)
#License.create(name: 'Unlimited', description: "Acquire beat's rights, Can be registered, Can be monetized", files: ".Mp3-file, .Wav-file, Stems", price_cents: 99, number: 3)
#License.create(name: 'Custom', description: "Acquire beat's rights, Can be registered, Can be monetized", files: "Custom-beat, .Mp3-file, .Wav-file, Stems", price_cents: 199, number: 4)
