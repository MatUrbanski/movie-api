# frozen_string_literal: true

require 'spec_helper'

describe Rating, type: :model do
  describe 'value presence validation' do
    let(:rating) { build(:rating, value: value) }

    before { rating.valid? }

    context 'when is blank' do
      let(:value) { nil }

      it 'adds error to the :value field' do
        expect(rating.errors[:value]).to eq ['is not present']
      end
    end

    context 'when is not blank' do
      let(:value) { 1 }

      it 'does not add error to the :rating field' do
        expect(rating.errors[:rating]).to eq nil
      end
    end
  end

  describe 'rating format validation' do
    let(:rating) { build(:rating, value: value) }

    before { rating.valid? }

    context 'when is invalid' do
      let(:value) { 7 }

      it 'adds error to the :email field' do
        expect(rating.errors[:value]).to eq ['is not in range or set: [1, 2, 3, 4, 5]']
      end
    end

    context 'when is valid' do
      let(:value) { 3 }

      it 'does not add error to the :email field' do
        expect(rating.errors[:value]).to eq nil
      end
    end
  end

  describe 'user_id presence validation' do
    let(:rating) { build(:rating, user: user) }

    before { rating.valid? }

    context 'when is blank' do
      let(:user) { nil }

      it 'adds error to the :user_id field' do
        expect(rating.errors[:user_id]).to eq ['is not present']
      end
    end

    context 'when is not blank' do
      let(:user) { create(:user) }

      it 'does not add error to the :user_id field' do
        expect(rating.errors[:user_id]).to eq nil
      end
    end
  end

  describe 'movie_id presence validation' do
    let(:rating) { build(:rating, movie: movie) }

    before { rating.valid? }

    context 'when is blank' do
      let(:movie) { nil }

      it 'adds error to the :movie_id field' do
        expect(rating.errors[:movie_id]).to eq ['is not present']
      end
    end

    context 'when is not blank' do
      let(:movie) { create(:movie) }

      it 'does not add error to the :movie_id field' do
        expect(rating.errors[:movie_id]).to eq nil
      end
    end
  end

  describe 'uniqueness validation' do
    let(:user)  { create(:user)  }
    let(:movie) { create(:movie) }

    before do
      create(:rating, user: user, movie: movie)

      rating.valid?
    end

    context 'when rating is unique' do
      let(:rating) { build(:rating) }

      it 'does not add error to the [:user_id, :movie_id] field' do
        expect(rating.errors[%i[user_id movie_id]]).to eq nil
      end
    end

    context 'when rating is not unique' do
      let(:rating) { build(:rating, user: user, movie: movie) }

      it 'adds error to the [:user_id, :movie_id] field' do
        expect(rating.errors[%i[user_id movie_id]]).to eq ['is already taken']
      end
    end
  end
end
