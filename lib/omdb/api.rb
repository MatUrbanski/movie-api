# frozen_string_literal: true

require 'net/http'

module Omdb
  # {Omdb::Api} is and API Client that communicates with the Open Movie Database JSON API.
  module Api
    # Get {Movie} informations from the Open Movie Database JSON API.
    #
    # @param [String] omdb_id of {Movie}.
    #
    # @return [Hash] Movie informations details.
    #
    # @example Get :
    #   Omdb::Api.by_id(ombd_id: 'tt0232500')
    def self.by_id(omdb_id:)
      uri      = URI("http://www.omdbapi.com/?i=#{omdb_id}&apikey=#{ENV['OMDB_API_KEY']}")
      response = Net::HTTP.get(uri)

      JSON.parse(response)
    end
  end
end
