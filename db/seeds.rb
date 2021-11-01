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

License.create(name: 'Standard', description: )