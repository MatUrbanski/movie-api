# frozen_string_literal: true

require 'spec_helper'

describe 'GET /api/v1/movies/:id', type: :request do
  include_examples 'authorization check', 'get', '/api/v1/movies/21c9177e-9497-4c86-945b-7d1097c8865f'

  context 'when Authorization headers contains valid token' do
    let(:user)  { create(:user)      }
    let(:token) { access_token(user) }
    let(:movie) { create(:movie)     }

    let(:omdb_data) do
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

    context 'when id is valid' do
      let(:movie_json_response) do
        {
          'id' => movie.id,
          'title' => movie.title,
          'price_in_cents' => movie.price_in_cents,
          'average_rating' => movie.average_rating.to_f,
          'created_at' => movie.created_at.iso8601,
          'updated_at' => movie.updated_at.iso8601,
          'omdb_data' => omdb_data
        }
      end

      before do
        expect(Omdb::Api)
          .to receive(:by_id)
          .with(omdb_id: movie.omdb_id)
          .and_return(omdb_data)

        header 'Authorization', token

        get "/api/v1/movies/#{movie.id}"
      end

      it 'returns 200 HTTP status' do
        expect(response.status).to eq 200
      end

      it 'returns movie data in the JSON response' do
        expect(json_response).to eq movie_json_response
      end
    end

    context 'when id is invalid' do
      before do
        header 'Authorization', token

        get '/api/v1/movies/21c9177e-9497-4c86-945b-7d1097c8865f'
      end

      it 'returns 404 HTTP status' do
        expect(response.status).to eq 404
      end

      it 'returns error message in the JSON response' do
        expect(json_response).to eq({ 'error' => 'Record not found.' })
      end
    end
  end
end
