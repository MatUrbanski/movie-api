# frozen_string_literal: true

require 'spec_helper'

describe 'PUT /api/v1/movies/:id', type: :request do
  include_examples 'authorization check', 'put', '/api/v1/movies/21c9177e-9497-4c86-945b-7d1097c8865f'

  context 'when Authorization headers contains valid token' do
    let(:admin) { true                        }
    let(:token) { access_token(user)          }
    let(:user)  { create(:user, admin: admin) }

    context 'when id is valid' do
      let(:movie) { create(:movie) }

      before do
        header 'Authorization', token

        put "/api/v1/movies/#{movie.id}", params

        movie.refresh
      end

      context 'when request contains incorrectly formatted params' do
        let(:params) { {} }

        it 'returns 422 HTTP status' do
          expect(response.status).to eq 422
        end

        it 'returns error message in JSON response' do
          expect(json_response).to eq({ 'title' => ['is missing'], 'price_in_cents' => ['is missing'] })
        end
      end

      context 'when request params are valid' do
        let(:params) { { title: 'Fast & Furious', price_in_cents: 123_123 } }

        let(:movie_json_response) do
          {
            'id' => movie.id,
            'title' => 'Fast & Furious',
            'price_in_cents' => 123_123,
            'average_rating' => movie.average_rating.to_f,
            'created_at' => movie.created_at.iso8601,
            'updated_at' => movie.updated_at.iso8601
          }
        end

        it 'returns 200 HTTP status' do
          expect(response.status).to eq 200
        end

        it 'returns updated movie data in the JSON response' do
          expect(json_response).to eq movie_json_response
        end
      end
    end

    context 'when id is invalid' do
      before do
        header 'Authorization', token

        put '/api/v1/movies/21c9177e-9497-4c86-945b-7d1097c8865f'
      end

      it 'returns 404 HTTP status' do
        expect(response.status).to eq 404
      end

      it 'returns error message in the JSON response' do
        expect(json_response).to eq({ 'error' => 'Record not found.' })
      end
    end

    context 'when user is not admin' do
      let(:admin) { false          }
      let(:movie) { create(:movie) }

      before do
        header 'Authorization', token

        put "/api/v1/movies/#{movie.id}"
      end

      it 'returns 401 HTTP status' do
        expect(response.status).to eq 401
      end
    end
  end
end
