# frozen_string_literal: true

require 'yaml'

module Common

  CONFIG_FILE = 'config.yml'
  STEAM_INSTALL_KEY = 'steam_install_path'
  STEAM_LIBRARIES_KEY = 'steam_library_locations'
  SKIP_APPIDS = 'skip_appids'
  STEAM_BASE_DATA_URI = 'steam://rungameid'

  APP_STATE_KEY = 'AppState'
  def self.read_config
    unless File.exist?(CONFIG_FILE)
      # TODO: Accept User input here
      STDERR.puts("#{CONFIG_FILE} not found in current directory")
      exit 1
    end

    YAML.load_file(CONFIG_FILE)
  end
end
