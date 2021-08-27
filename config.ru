# frozen_string_literal: true

# This file contains configuration to let the webserver which application to run.

require_relative 'app'

# Enable Rack::Attack
use Rack::Attack

run App.freeze.app
