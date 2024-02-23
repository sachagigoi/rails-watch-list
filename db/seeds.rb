# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require 'json'
require 'open-uri'

puts "Cleaning database..."
Movie.destroy_all

# URL du endpoint
url = 'https://tmdb.lewagon.com/movie/top_rated'

# Lecture des données JSON depuis l'URL
response = URI.open(url).read

# Analyse des données JSON
data = JSON.parse(response)

# Récupération des résultats
movies = data['results']

# Itération à travers les résultats et création des instances de films
movies.each do |movie_data|
  Movie.create(
    title: movie_data['title'],
    overview: movie_data['overview'],
    poster_url: "https://image.tmdb.org/t/p/original/#{movie_data['poster_path']}",
    rating: movie_data['vote_average']
  )
end

puts "#{movies.size} films créés avec succès."
puts Movie.all
