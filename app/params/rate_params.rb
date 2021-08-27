# frozen_string_literal: true

# {RateParams} validates POST api/v1/movies/:id/rate endpoint params.
#
# @example When params are valid:
#   RateParams.new.permit!(value: '1')
#
# @example When params are invalid:
#   RateParams.new.permit!({})
class RateParams < ApplicationParams
  # @!method params
  #   It stores rules for validating POST api/v1/movies/:id/rate endpoint params using dry-validation DSL.
  params do
    required(:value).value(included_in?: %w[1 2 3 4 5])
  end
end
