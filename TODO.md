# TODO

## Fix VDF Parser

Current bugs:
1. Hash is a flat data structure (VDF Hierarchies are not respected)
2. Due to the first, any keys with the same name will merge results

Implementation notes:
- The contents of the whole VDF file is loaded into memory instantly
- To avoid writing code that traverses through the chars of a string, words are split by spaces

## Stop relying on self-config

1. Find `Steam Install` directory
2. Find `libraryfolders.vdf` file
3. Parse file to get Library Locations
4. Get all files from `${library}/steamapps`
5. Filter to files using the following naming format: `appmanifest_123.acf`
6. Build list of games using `appid`, `name`, and `location`

Note: You can use the Windows Registry to find the Steam Install Path ([source](https://developer.valvesoftware.com/wiki/Counter-Strike:_Global_Offensive_Game_State_Integration/en#Locating_CS:GO_Install_Directory))
**HOWEVER**
I am too lazy to learn the [Win32 API](https://learn.microsoft.com/en-us/windows/win32/winprog64/accessing-an-alternate-registry-view?redirectedfrom=MSDN) just for this shitty script

## Make multi-platform

Currently, this approach only works on Windows. Ideally this will work on macOS & Linux systems (Specifically Ubuntu & derivatives, Fedora, Arch) 
