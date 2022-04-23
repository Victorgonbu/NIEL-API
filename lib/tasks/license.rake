namespace :license do
    task create: :environment do
        LICENSES_ATTRIBUTES = [
            {
                name: 'standard',
                privileges: ['cant_be_registered', 'cant_be_monetized'],
                files: ['mp3_file'],
                uuid: 1,
                price_cents: 29
            },
            {
                name: 'premium',
                privileges: ['cant_be_registered', 'cant_be_monetized'],
                files: ['mp3_file', 'wav_file'],
                uuid: 2,
                price_cents: 49
            },
            {
                name: 'unlimited',
                privileges: ['beat_rights', 'can_be_registered', 'can_be_monetized'],
                files: ['mp3_file', 'wav_file', 'stems'],
                uuid: 3,
                price_cents: 99
            },
            {
                name: 'custom',
                privileges: ['beat_rights', 'can_be_registered', 'can_be_monetized'],
                files: ['mp3_file', 'wav_file', 'stems', 'custom_beat'],
                uuid: 4,
                price_cents: 199
            }
        ]

        LICENSES_ATTRIBUTES.each do |attrs|
            License.find_or_create_by!(attrs)
        end
    end
end