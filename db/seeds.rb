# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

imdb_ids = [
  "tt0232500", "tt0322259", "tt0463985", "tt1013752",
  "tt1596343", "tt1905041", "tt2820852", "tt4630562"
]
imdb_ids.each do |imdb_id|
  Movies::Create.call(params: {imdb_id: imdb_id})
end

User.create([
  {email: "owner@smallcinema.com", password: "P@ssw0rd!", role: "owner"},
  {email: "moviegoer@smallcinema.com", password: "P@ssw0rd!", role: "moviegoer"}
])
