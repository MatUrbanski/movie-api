# frozen_string_literal: true

require 'spec_helper'

describe Movie, type: :model do
  describe 'title presence validation' do
    let(:movie) { build(:movie, title: title) }

    before { movie.valid? }

    context 'when is blank' do
      let(:title) { nil }

      it 'adds error to the :title field' do
        expect(movie.errors[:title]).to eq ['is not present']
      end
    end

    context 'when is not blank' do
      let(:title) { 'The Fast and the Furious' }

      it 'does not add error to the :title field' do
        expect(movie.errors[:title]).to eq nil
      end
    end
  end

  describe 'title uniqueness validation' do
    let(:movie) { build(:movie, title: title) }

    before do
      create(:movie, title: 'The Fast and the Furious')

      movie.valid?
    end

    context 'when movie title is unique' do
      let(:title) { '2 Fast 2 Furious' }

      it 'does not add error to the :title field' do
        expect(movie.errors[:title]).to eq nil
      end
    end

    context 'when movie title is not unique' do
      let(:title) { 'The Fast and the Furious' }

      it 'adds error to the :title field' do
        expect(movie.errors[:title]).to eq ['is already taken']
      end
    end
  end

  describe 'omdb_id presence validation' do
    let(:movie) { build(:movie, omdb_id: omdb_id) }

    before { movie.valid? }

    context 'when is blank' do
      let(:omdb_id) { nil }

      it 'adds error to the :omdb_id field' do
        expect(movie.errors[:omdb_id]).to eq ['is not present']
      end
    end

    context 'when is not blank' do
      let(:omdb_id) { 'test-omdb-id' }

      it 'does not add error to the :omdb_id field' do
        expect(movie.errors[:omdb_id]).to eq nil
      end
    end
  end

  describe 'omdb_id uniqueness validation' do
    let(:movie) { build(:movie, omdb_id: omdb_id) }

    before do
      create(:movie, omdb_id: 'test-omdb-id')

      movie.valid?
    end

    context 'when movie omdb_id is unique' do
      let(:omdb_id) { 'test-omdb-id-2' }

      it 'does not add error to the :omdb_id field' do
        expect(movie.errors[:omdb_id]).to eq nil
      end
    end

    context 'when movie omdb_id is not unique' do
      let(:omdb_id) { 'test-omdb-id' }

      it 'adds error to the :omdb_id field' do
        expect(movie.errors[:omdb_id]).to eq ['is already taken']
      end
    end
  end

  describe 'price_in_cents presence validation' do
    let(:movie) { build(:movie, price_in_cents: price_in_cents) }

    before { movie.valid? }

    context 'when is blank' do
      let(:price_in_cents) { nil }

      it 'adds error to the :price_in_cents field' do
        expect(movie.errors[:price_in_cents]).to eq ['is not present']
      end
    end

    context 'when is not blank' do
      let(:price_in_cents) { 5000 }

      it 'does not add error to the :price_in_cents field' do
        expect(movie.errors[:price_in_cents]).to eq nil
      end
    end
  end

  describe '#with_average_rating' do
    let(:movie)             { create(:movie) }
    let(:movie_with_rating) { described_class.with_average_rating.with_pk!(movie.id) }

    before do
      create(:rating, movie: movie, value: 4)
    end

    it 'returns movies with average_rating attribute' do
      expect(movie_with_rating.average_rating).to eq 4
    end
  end
end
