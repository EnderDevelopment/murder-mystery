local ESX = exports['es_extended']:getSharedObject()

local isGameActive = false
local playerRole = nil

-- Function to display the role menu
local function showRoleMenu()
    local elements = {}
    
    if playerRole then
        table.insert(elements, {
            label = Config.Roles[playerRole].color .. Config.Roles[playerRole].name .. '~s~',
            value = 'role_info'
        })
    end
    
    table.insert(elements, {
        label = 'Player Locations',
        value = 'player_locations'
    })
    
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'role_menu', {
        title = Config.MenuTitle,
        align = 'top-left',
        elements = elements
    }, function(data, menu)
        if data.current.value == 'role_info' then
            ESX.ShowNotification(Config.Roles[playerRole].description)
        elseif data.current.value == 'player_locations' then
            TriggerServerEvent('murderMystery:getPlayerLocations')
        end
    end, function(data, menu)
        menu.close()
    end)
end

-- Function to display player locations
RegisterNetEvent('murderMystery:showPlayerLocations')
AddEventHandler('murderMystery:showPlayerLocations', function(playerLocations)
    local elements = {}
    
    for _, player in ipairs(playerLocations) do
        table.insert(elements, {
            label = player.name .. ' - ' .. player.coords.x .. ', ' .. player.coords.y .. ', ' .. player.coords.z,
            value = player.id
        })
    end
    
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'player_locations', {
        title = 'Player Locations',
        align = 'top-left',
        elements = elements
    }, function(data, menu)
        menu.close()
    end, function(data, menu)
        menu.close()
    end)
end)

-- Function to set player role
RegisterNetEvent('murderMystery:setPlayerRole')
AddEventHandler('murderMystery:setPlayerRole', function(role)
    playerRole = role
    ESX.ShowNotification('Your role is: ' .. Config.Roles[role].color .. Config.Roles[role].name .. '~s~')
end)

-- Command to open the role menu
RegisterCommand('mystery', function()
    if isGameActive then
        showRoleMenu()
    else
        ESX.ShowNotification('No active game.')
    end
end, false)

-- Event to start the game
RegisterNetEvent('murderMystery:startGame')
AddEventHandler('murderMystery:startGame', function()
    isGameActive = true
    ESX.ShowNotification('Murder Mystery game has started!')
end)

-- Event to end the game
RegisterNetEvent('murderMystery:endGame')
AddEventHandler('murderMystery:endGame', function()
    isGameActive = false
    playerRole = nil
    ESX.ShowNotification('Murder Mystery game has ended.')
end)