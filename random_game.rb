require 'yaml'
require_relative './lib/vdf_ruby/parser'

CONFIG_FILE = 'config.yml'
STEAM_BASE_DATA_URI = 'steam://rungameid/'
STEAM_INSTALL_KEY = 'steam_install_path'
STEAM_LIBRARIES_KEY = 'steam_library_locations'
APP_STATE_KEY = 'AppState'

unless File.exist?(CONFIG_FILE)
  # TODO: Accept User input here
  STDERR.puts("#{CONFIG_FILE} not found in current directory")
  exit 1
end

config = YAML.load_file(CONFIG_FILE)
games = Array.new
config[STEAM_LIBRARIES_KEY].each do |lib|
  Dir.children(lib).each do |entry|
    next unless entry.include?('appmanifest')
    manifest = VDFRuby::Parser.new("#{lib}/#{entry}").parse
    games.push({
                    'Name' => manifest[APP_STATE_KEY]['name'],
                    'GameId' => manifest[APP_STATE_KEY]['appid'],
                    'Library' => lib
                  })
  end
end

puts games
