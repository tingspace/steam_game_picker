# Steam Game Picker

Struggling to pick a Steam game? Run this script to launch a random Steam Game that you already have installed!

Indecision is the enemy of fun!

## How to use it

Pre-requisites:
- Ruby
- Windows (10+)
- Steam
- Installed Games
- Editing knowledge of `.yml` files
- Knowledge of where your Steam Libraries are

Steps:
1. Open the `config.yml` file and update it with the right locations
2. Open a terminal and `cd` to wherever you have cloned this repo
3. Run `ruby random_game.rb` (Or `./random_game.rb` of your system allows)
4. Profit???

## Implementation notes

Games are launched using the [Steam browser protocol](https://developer.valvesoftware.com/wiki/Steam_browser_protocol). (IE: `steam://rungameid/239030`)

To do this, the script needs to know the Steam `appid`s you have installed. The script does this by reading the `appmanifest` files in your Steam Libraries and parses for the `appid` contained within and builds a list of these `appid`s.

After the index is built & numbered, I just pick a random number and select the game in the list at that index to launch. 

NOTE: These `appmanifest` files are in the Valve [KeyValues](https://developer.valvesoftware.com/wiki/KeyValues) Data Format (VDF). I couldn't find a good Ruby library for this, so I'm writing my own in `/lib/vdf_ruby` (See [README](./lib/vdf_ruby/README.md) in that directory for more details)