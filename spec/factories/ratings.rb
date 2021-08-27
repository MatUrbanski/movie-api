# frozen_string_literal: true

FactoryBot.define do
  factory :rating do
    value { 3 }

    user
    movie
  end
end
