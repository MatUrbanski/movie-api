# frozen_string_literal: true

# {MovieParams} validates PUT api/v1/movies/:id endpoint params.
#
# @example When params are valid:
#   MovieParams.new.permit!(title: 'Fast & Furious', price_in_cents: 5000)
#
# @example When params are invalid:
#   MovieParams.new.permit!({})
class MovieParams < ApplicationParams
  # @!method params
  #   It stores rules for validating PUT api/v1/movies/:id endpoint params. using dry-validation DSL.
  params do
    required(:title).filled(:string)
    required(:price_in_cents).filled(:integer)
  end
end
