# frozen_string_literal: true

# seeds.rb file is launched during rake db:seed command.

User.find_or_create(email: 'cinema-owner@example.com') do |user|
  user.password              = 'password'
  user.password_confirmation = 'password'
  user.authentication_token  = AuthenticationTokenGenerator.call
  user.admin                 = true
end

User.find_or_create(email: 'moviegoer@example.com') do |user|
  user.password              = 'password'
  user.password_confirmation = 'password'
  user.authentication_token  = AuthenticationTokenGenerator.call
  user.admin                 = false
end

Movie.find_or_create(title: 'The Fast and the Furious') do |movie|
  movie.omdb_id              = 'tt0232500'
  movie.price_in_cents       = 5000
end

Movie.find_or_create(title: '2 Fast 2 Furious') do |movie|
  movie.omdb_id              = 'tt0322259'
  movie.price_in_cents       = 5000
end

Movie.find_or_create(title: 'The Fast and the Furious: Tokyo Drift') do |movie|
  movie.omdb_id              = 'tt0463985'
  movie.price_in_cents       = 5000
end

Movie.find_or_create(title: 'Fast & Furious') do |movie|
  movie.omdb_id              = 'tt1013752'
  movie.price_in_cents       = 5000
end

Movie.find_or_create(title: 'Fast Five') do |movie|
  movie.omdb_id              = 'tt1596343'
  movie.price_in_cents       = 5000
end

Movie.find_or_create(title: 'Fast & Furious 6') do |movie|
  movie.omdb_id              = 'tt1905041'
  movie.price_in_cents       = 5000
end

Movie.find_or_create(title: 'Furious 7') do |movie|
  movie.omdb_id              = 'tt2820852'
  movie.price_in_cents       = 5000
end

Movie.find_or_create(title: 'The Fate of the Furious') do |movie|
  movie.omdb_id              = 'tt4630562'
  movie.price_in_cents       = 5000
end
