# Murder Mystery

Engaging Murder Mystery game for FiveM servers

## Features

- Role assignment (Murderer and Innocent)
- Player location tracking
- Game session management

## Requirements

- FiveM server
- ESX Framework
- MySQL

## Installation

1. Download the script files.
2. Place them in your FiveM server's resources folder.
3. Add `start murderMystery` to your server.cfg file.

## Usage

### Commands

| Command       | Description                     | Permission |
|---------------|---------------------------------|------------|
| `/mystery`    | Opens the role menu             | Player     |
| `/startmystery`| Starts the Murder Mystery game   | Admin      |

### Permissions

- `admin` permission is required to start the game.

## Configuration

Edit the `config.lua` file to customize game settings:

```lua
Config = {}

-- Game settings
Config.GameDuration = 300 -- 5 minutes in seconds
Config.RoleRevealTime = 60 -- 1 minute in seconds

-- Menu settings
Config.MenuTitle = 'Murder Mystery'
Config.MenuSubtitle = 'Game Options'

-- Role settings
Config.Roles = {
    murderer = {
        name = 'Murderer',
        color = '~r~',
        description = 'You are the killer. Eliminate all innocents.'
    },
    innocent = {
        name = 'Innocent',
        color = '~g~',
        description = 'You are innocent. Find the murderer and survive.'
    }
}

-- Database settings
Config.DatabaseTable = 'murder_mystery'
```

---

## Generated with EnderDevelopment

This plugin was generated in minutes with [EnderDevelopment](https://enderdevelopment.com) — the AI platform that turns your ideas into working Minecraft plugins, Discord bots and FiveM scripts.

**Want your own?** [Generate this project on EnderDevelopment](https://dash.enderdevelopment.com?utm_source=github&utm_medium=readme&utm_campaign=murder-mystery&utm_content=bottom) — describe it in one sentence and get the full source code.
