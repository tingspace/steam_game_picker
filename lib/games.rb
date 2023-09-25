# frozen_string_literal: true

require 'yaml'
require_relative 'vdf_ruby/parser'
require_relative 'config'

module Common
  NAME_KEY = 'Name'
  APP_ID_KEY = 'AppId'
  LIBRARY_KEY = 'Library'

  def self.get_installed_games(config = read_config)
    skipped_games = config[SKIP_APPIDS].nil? ? Array.new : config[SKIP_APPIDS]
    games = Array.new
    config[STEAM_LIBRARIES_KEY].each do |lib|
      Dir.children(lib).each do |entry|
        next unless entry.include?('appmanifest')
        manifest = VDFRuby::Parser.new("#{lib}/#{entry}").parse[APP_STATE_KEY]
        next if skipped_games.include?(manifest['appid'])
        games.push({
                     NAME_KEY => manifest['name'],
                     APP_ID_KEY => manifest['appid'],
                     LIBRARY_KEY => lib
                   })
      end
    end

    games
  end

  GAME_LIST_FILE = 'game_lists.yml'

  def self.get_from_game_list(key = nil)
    games = YAML.load_file(GAME_LIST_FILE)[key]
    raise "No list of games for #{key}" if games.nil?

    games
  end

end