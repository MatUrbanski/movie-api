# frozen_string_literal: true

# {Rating} model stores information about {Movie} user ratings.
#
# @!attribute id
#   @return [UUID] ID of the {Rating} in UUID format.
#
# @!attribute rating
#   @return [Integer] {Movie} rating. Valid values are from 1 to 5.
#
# @!attribute user_id
#   @return [UUID] ID of the {User} which {Rating} belongs to in UUID format.
#
# @!attribute movie_id
#   @return [UUID] ID of the {Movie} which {Rating} belongs to in UUID format.
#
# @!attribute created_at
#   @return [DateTime] Time when {Rating} was created.
#
# @!attribute updated_at
#   @return [DateTime] Time when {Rating} was updated.
class Rating < Sequel::Model
  many_to_one :user
  many_to_one :movie

  # It validates {Rating} object.
  #
  # @example Validate {Rating}:
  #   Rating.new.validate
  def validate
    super

    validates_includes([1, 2, 3, 4, 5], :value) if value
  end
end
