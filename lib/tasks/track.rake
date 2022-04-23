namespace :track do
    task create: :environment do
        TRACK_ATTRIBUTES = [
            {
                name: 'test track 1',
                pcm: '[1, 0, 3, 4]',
                bpm: 234,
                buyable: true,
                mp3_file: Rack::Test::UploadedFile.new('app/assets/tests/mp3.mp3', 'audio/mp3'),
                wav_file: Rack::Test::UploadedFile.new('app/assets/tests/wav.wav', 'audio/wav'),
                image_file: Rack::Test::UploadedFile.new('app/assets/tests/image.png', 'image/png'),
                zip_file: Rack::Test::UploadedFile.new('app/assets/tests/zip.zip', 'file/zip')
            }
        ]

        TRACK_ATTRIBUTES.each do |attrs|
            Track.create!(attrs)
        end
    end
end