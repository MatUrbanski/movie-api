# frozen_string_literal: true

# {MovieSerializer} is responsible for representing single movie ({Movie}) in JSON format.
#
# @example Represent {Movie} in the JSON format:
#   MovieSerializer.new(movie: Movie.last).render
class MovieSerializer < ApplicationSerializer
  # It generates Hash object with single movie ({Movie}) details.
  #
  # @return [Hash] object with single movie ({Movie}) details.
  #
  # @example Prepare data before transformation to the JSON format:
  #   MovieSerializer.new(movie: Movie.last).to_json
  def to_json
    movie = {
      id: @movie.id,
      title: @movie.title,
      price_in_cents: @movie.price_in_cents,
      average_rating: @movie.average_rating.to_f,
      created_at: @movie.created_at,
      updated_at: @movie.updated_at
    }

    movie = movie.merge(omdb_data: @omdb_data) if @omdb_data.present?

    movie
  end
end
