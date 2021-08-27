# frozen_string_literal: true

require 'spec_helper'

describe 'POST /api/v1/movies/:id/rate', type: :request do
  include_examples 'authorization check', 'put', '/api/v1/movies/21c9177e-9497-4c86-945b-7d1097c8865f'

  context 'when Authorization headers contains valid token' do
    let(:token) { access_token(user) }
    let(:user)  { create(:user)      }

    context 'when id is valid' do
      let(:movie) { create(:movie) }

      before do
        header 'Authorization', token

        post "/api/v1/movies/#{movie.id}/rate", params

        movie.refresh
      end

      context 'when request contains incorrectly formatted params' do
        let(:params) { {} }

        it 'returns 422 HTTP status' do
          expect(response.status).to eq 422
        end

        it 'returns error message in JSON response' do
          expect(json_response).to eq({ 'value' => ['is missing'] })
        end
      end

      context 'when request params are valid' do
        let(:params) { { value: '3' } }

        let(:created_rating) do
          Rating.find(
            user: user,
            movie: movie,
            value: 3
          )
        end

        it 'returns 200 HTTP status' do
          expect(response.status).to eq 200
        end

        it 'returns empty response body' do
          expect(response.body).to eq ''
        end

        it 'creates movie rating' do
          expect(created_rating.present?).to eq true
        end
      end
    end

    context 'when id is invalid' do
      before do
        header 'Authorization', token

        post '/api/v1/movies/21c9177e-9497-4c86-945b-7d1097c8865f/rate'
      end

      it 'returns 404 HTTP status' do
        expect(response.status).to eq 404
      end

      it 'returns error message in the JSON response' do
        expect(json_response).to eq({ 'error' => 'Record not found.' })
      end
    end

    context 'when movie rating is already present' do
      let(:movie)   { create(:movie)                                      }
      let!(:rating) { create(:rating, user: user, movie: movie, value: 5) }
      let(:params)  { { value: '1' }                                      }

      before do
        header 'Authorization', token

        post "/api/v1/movies/#{movie.id}/rate", params

        rating.reload
      end

      it 'returns 200 HTTP status' do
        expect(response.status).to eq 200
      end

      it 'returns empty response body' do
        expect(response.body).to eq ''
      end

      it 'updates rating value' do
        expect(rating.value).to eq 1
      end
    end
  end
end
