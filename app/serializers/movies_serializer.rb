# frozen_string_literal: true

# {MoviesSerializer} is responsible for representing multiple movies ({Movie}) in JSON format.
#
# @example Represent multiple movies {Movie} in the JSON format:
#   MoviesSerializer.new(movie: Movie.all).render
class MoviesSerializer < ApplicationSerializer
  # It generates Hash object with multiple movies ({Movie}) details.
  #
  # @return [Hash] object with multiple movies ({Movie}) details.
  def to_json
    {
      movies: movies
    }
  end

  private

  # It returns array of movies ({Movie}).
  #
  # @return [Array<>Hash] movies ({Movie}) data.
  def movies
    @movies.map do |movie|
      MovieSerializer.new(movie: movie).to_json
    end
  end
end
