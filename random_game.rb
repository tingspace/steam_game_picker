require 'yaml'
require_relative './lib/vdf_ruby/parser'

CONFIG_FILE = 'config.yml'
STEAM_INSTALL_KEY = 'steam_install_path'
STEAM_LIBRARIES_KEY = 'steam_library_locations'
SKIP_APPIDS = 'skip_appids'

STEAM_BASE_DATA_URI = 'steam://rungameid'

APP_STATE_KEY = 'AppState'

unless File.exist?(CONFIG_FILE)
  # TODO: Accept User input here
  STDERR.puts("#{CONFIG_FILE} not found in current directory")
  exit 1
end

config = YAML.load_file(CONFIG_FILE)
skip_ids = config[SKIP_APPIDS].nil? ? Array.new : config[SKIP_APPIDS]
games = Array.new
config[STEAM_LIBRARIES_KEY].each do |lib|
  Dir.children(lib).each do |entry|
    next unless entry.include?('appmanifest')
    manifest = VDFRuby::Parser.new("#{lib}/#{entry}").parse
    games.push({
                    'Name' => manifest[APP_STATE_KEY]['name'],
                    'AppId' => manifest[APP_STATE_KEY]['appid'],
                    'Library' => lib
                  })
  end
end

MAX_TICKS = 10

ticks = 0
chosen_appid = String.new
while chosen_appid.empty?
  raise "Could not find a random game after #{MAX_TICKS} iterations" if ticks >= MAX_TICKS
  random_appid = games[rand(0..games.length-1)]['AppId']
  chosen_appid = random_appid unless skip_ids.include?(random_appid)
  ticks += 1
end

system("start #{STEAM_BASE_DATA_URI}/#{games[rand(0..games.length-1)]['AppId']}")
