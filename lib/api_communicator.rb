require 'rest-client'
require 'json'
require 'pry'
def get_character_movies_from_api(character_name)
  #make the web request
  response_string = RestClient.get('http://www.swapi.co/api/people/')
  response_hash = JSON.parse(response_string)
  character_hash = response_hash["results"].find do |response|
    response["name"].downcase == character_name
  end
  character_hash ? character_films = character_hash["films"] : "Invalid character name."
  film_hash = character_films.map do |film|
    film_string = RestClient.get(film)
    JSON.parse(film_string)
  end
  film_titles = []
  film_hash.each do |film|
    film_titles << film["title"]
  end
  film_titles
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `print_movies`
  #  and that method will do some nice presentation stuff like puts out a list
  #  of movies by title. Have a play around with the puts with other info about a given film.
end
# def print_movies(films)
#   films.each do |film|
#     puts film
#   end
# end
def show_character_movies(character)
  films = get_character_movies_from_api(character)
  films.each do |film|
    puts film
  end
  # print_movies(something)
end
## BONUS
# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
