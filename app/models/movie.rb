# frozen_string_literal: true

# {Movie} model stores authentication informations.
#
# @!attribute id
#   @return [UUID] ID of the {Movie} in UUID format.
#
# @!attribute title
#   @return [String] Title of the {Movie}, it's stored in the PostgreSQL citext column.
#
# @!attribute price_in_cents
#   @return [Integer] {Movie} price in cents.
#
# @!attribute omdb_id
#   @return [String] Movie ID in the OMDB API database.
#
# @!attribute created_at
#   @return [DateTime] Time when {Movie} was created.
#
# @!attribute updated_at
#   @return [DateTime] Time when {Movie} was updated.
class Movie < Sequel::Model
  # Create column accessor for averate_rating attribute.
  def_column_accessor :average_rating

  one_to_many :ratings

  dataset_module do
    # It returns movies with average rating.
    #
    # @return [Sequel::Postgres::Dataset] Movies dataset.
    #
    # @example Get movies with average rating:
    #   Movie.with_average_rating.all
    def with_average_rating
      Movie
        .select_all(:movies)
        .select_append { avg(ratings[:value]).as(:average_rating) }
        .left_outer_join(:ratings, movie_id: :id)
        .group_by { movies[:id] }
    end
  end
end
