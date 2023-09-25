# frozen_string_literal: true

require_relative './vdf_ruby/parser'

module Common
  NAME_KEY = 'Name'
  APP_ID_KEY = 'AppId'
  LIBRARY_KEY = 'Library'

  def self.get_games(config = read_config)
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

end