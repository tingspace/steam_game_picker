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
1. Open the `config.yml` file and update it to your locations
2. Open a terminal to where you have cloned this repo
3. Run `ruby random_game.rb`
4. Profit???

## Implementation notes

This makes use of the [Steam browser protocol](https://developer.valvesoftware.com/wiki/Steam_browser_protocol) to launch the games. (IE: `steam://rungameid/239030`)

To do this, the script tries to find the Steam `appid`s currently installed by reading the `appmanifest` files in your Libraries.

These `appmanifest` files are in the Valve [KeyValues](https://developer.valvesoftware.com/wiki/KeyValues) format. I couldn't find a good Ruby library for this, so I'm writing my own in `/lib/vdf_ruby`

Since I'm writing my own library to parse the data format just for this one purpose, expect some bugs if you use it for any other purpose.

If I can ever make the package stable, maybe one day I'll split [vdf_ruby](./lib/vdf_ruby) into its own repo & package.