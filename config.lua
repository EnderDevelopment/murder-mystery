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