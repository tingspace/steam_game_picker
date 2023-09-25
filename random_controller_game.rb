# frozen_string_literal: true

require 'yaml'
require_relative './lib/config'

games = YAML.load_file('game_lists.yml')['controller_friendly']
system("start #{Common::STEAM_BASE_DATA_URI}/#{games[rand(0..games.length-1)]}")