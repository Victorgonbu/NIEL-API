namespace :genre do
  task create: :environment do
    GENRE_ATTRIBUTES = [
      {
        name: 'Rock'
      },
      {
        name: 'Salsa'
      },
      {
        name: 'Reggaeton'
      }
    ].freeze

    GENRE_ATTRIBUTES.each do |attrs|
      Genre.find_or_create_by!(attrs)
    end
  end
end