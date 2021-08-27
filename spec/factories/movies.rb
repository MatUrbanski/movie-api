# frozen_string_literal: true

FactoryBot.define do
  factory :movie do
    sequence(:title) { |n| "Movie #{n}"     }
    omdb_id          { SecureRandom.hex(20) }
    price_in_cents   { 5000                 }
  end
end
