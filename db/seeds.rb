# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# GENRES

names = ['reggaeton', 'hip-hop', 'rap', 'bachata', 'afrobeat', '']

names.each do |name|
  record = Genre.new(name: name, icon: 'none')
  if record.valid?
    record.save
  end
end