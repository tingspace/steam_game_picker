# frozen_string_literal: true

require_relative 'lib/games'

games = ARGV.empty? ? Common.get_installed_games : Common.get_from_game_list(ARGV.first)
system("start #{Common::STEAM_BASE_DATA_URI}/#{games[rand(0..games.length-1)]}")