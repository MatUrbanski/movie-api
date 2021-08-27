# frozen_string_literal: true

require 'spec_helper'

describe Omdb::Api do
  describe '.by_id' do
    let(:omdb_id) { 'tt0232500'                                                               }
    let(:uri)     { URI("http://www.omdbapi.com/?i=#{omdb_id}&apikey=#{ENV['OMDB_API_KEY']}") }

    let(:movie_data) do
      {
        'Title' => 'The Fast and the Furious',
        'Year' => '2001',
        'Rated' => 'PG-13',
        'Released' => '22 Jun 2001',
        'Runtime' => '106 min',
        'Genre' => 'Action, Crime, Thriller',
        'Director' => 'Rob Cohen',
        'Writer' => 'Ken Li, Gary Scott Thompson, Erik Bergquist',
        'Actors' => 'Vin Diesel, Paul Walker, Michelle Rodriguez'
      }
    end

    before do
      expect(Net::HTTP)
        .to receive(:get)
        .with(uri)
        .and_return(movie_data.to_json)
    end

    it 'returns movie informations details' do
      expect(described_class.by_id(omdb_id: omdb_id)).to eq movie_data
    end
  end
end
