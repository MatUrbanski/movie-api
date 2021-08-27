# frozen_string_literal: true

require 'spec_helper'

describe 'GET /api/v1/movies', type: :request do
  include_examples 'authorization check', 'get', '/api/v1/movies'

  context 'when Authorization headers contains valid token' do
    let(:token) { access_token(user) }
    let(:user)  { create(:user)      }

    context 'when there is no movies in the database' do
      let(:movies_json_response) do
        {
          'movies' => []
        }
      end

      before do
        header 'Authorization', token

        get '/api/v1/movies'
      end

      it 'returns 200 HTTP status' do
        expect(response.status).to eq 200
      end

      it 'returns empty array in the reponse body' do
        expect(json_response).to eq movies_json_response
      end
    end

    context 'when there are movies in database' do
      let!(:movie) { create(:movie) }

      let(:movies_json_response) do
        {
          'movies' => [
            {
              'id' => movie.id,
              'title' => movie.title,
              'price_in_cents' => movie.price_in_cents,
              'average_rating' => movie.average_rating.to_f,
              'created_at' => movie.created_at.iso8601,
              'updated_at' => movie.updated_at.iso8601
            }
          ]
        }
      end

      before do
        header 'Authorization', token

        get '/api/v1/movies'
      end

      it 'returns 200 HTTP status' do
        expect(response.status).to eq 200
      end

      it 'returns movies data in JSON reponse' do
        expect(json_response).to eq movies_json_response
      end
    end
  end
end
