FactoryBot.define do
  factory :track do
    name {'track name'}
    bpm {100}
    pcm {'[1, 0, 3, 4]'}
    buyable {true}
    mp3_file {Rack::Test::UploadedFile.new('app/assets/tests/mp3.mp3', 'audio/mp3')}
    wav_file {Rack::Test::UploadedFile.new('app/assets/tests/wav.wav', 'audio/wav')}
    image_file {Rack::Test::UploadedFile.new('app/assets/tests/image.png', 'image/png')}
    zip_file {Rack::Test::UploadedFile.new('app/assets/tests/zip.zip', 'file/zip')}
  end

  factory :track_with_genres, parent: :track do
    name {'track with genre assciations'}
    after(:create) do |track|
      first_genre = create(:genre)
      second_genre = create(:genre, name: 'Afrobeat')
      create(:genre_track, track: track, genre: first_genre)
      create(:genre_track, track: track, genre: second_genre)
    end
  end

  factory :related_track, parent: :track do
    name {"related track name"}
  end
end
