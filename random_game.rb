# Note: You can use the Windows Registry to find the Steam Install Path
# HOWEVER
# I am too lazy to learn the Win32 API just for this shitty script

# What to do:
# 1. Check for config file
# 2. If config file doesn't exist, prompt for user input for Steam Install path
# 3. Find libraryfolders.vdf file
# 4. Parse file to get library locations
# 5. Open location to read files
# 6. Find files in this format: appmanifest_123.acf
# 7. Compile the list of games

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
