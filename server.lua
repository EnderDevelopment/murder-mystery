local ESX = exports['es_extended']:getSharedObject()

local isGameActive = false
local gameId = nil
local murdererId = nil
local innocentIds = {}

-- Function to start the game
local function startGame()
    isGameActive = true
    gameId = 'game' .. os.time()
    
    -- Get all players
    local players = ESX.GetPlayers()
    
    -- Assign roles
    if #players > 0 then
        murdererId = players[math.random(#players)]
        
        for _, playerId in ipairs(players) do
            if playerId ~= murdererId then
                table.insert(innocentIds, playerId)
            end
        end
    
        -- Notify players
        for _, playerId in ipairs(players) do
            local xPlayer = ESX.GetPlayerFromId(playerId)
            
            if xPlayer then
                if playerId == murdererId then
                    TriggerClientEvent('murderMystery:setPlayerRole', playerId, 'murderer')
                    MySQL.Async.execute('INSERT INTO murder_mystery (player_id, role, game_id) VALUES (@player_id, @role, @game_id)', {
                        ['@player_id'] = playerId,
                        ['@role'] = 'murderer',
                        ['@game_id'] = gameId
                    })
                else
                    TriggerClientEvent('murderMystery:setPlayerRole', playerId, 'innocent')
                    MySQL.Async.execute('INSERT INTO murder_mystery (player_id, role, game_id) VALUES (@player_id, @role, @game_id)', {
                        ['@player_id'] = playerId,
                        ['@role'] = 'innocent',
                        ['@game_id'] = gameId
                    })
                end
            end
        end
    
        -- Start the game
        TriggerClientEvent('murderMystery:startGame', -1)
        
        -- End the game after the specified duration
        Citizen.SetTimeout(Config.GameDuration * 1000, function()
            endGame()
        end)
    else
        print('Not enough players to start the game.')
    end
end

-- Function to end the game
local function endGame()
    isGameActive = false
    murdererId = nil
    innocentIds = {}
    
    -- Notify players
    TriggerClientEvent('murderMystery:endGame', -1)
end

-- Command to start the game
ESX.RegisterCommand('startmystery', 'admin', function(xPlayer, args, showError)
    if not isGameActive then
        startGame()
    else
        xPlayer.showNotification('Game is already active.')
    end
end, true, {help = 'Start the Murder Mystery game'})

-- Event to get player locations
RegisterNetEvent('murderMystery:getPlayerLocations')
AddEventHandler('murderMystery:getPlayerLocations', function()
    local playerLocations = {}
    
    for _, playerId in ipairs(ESX.GetPlayers()) do
        local xPlayer = ESX.GetPlayerFromId(playerId)
        
        if xPlayer then
            local playerPed = GetPlayerPed(playerId)
            local playerCoords = GetEntityCoords(playerPed)
            
            table.insert(playerLocations, {
                id = playerId,
                name = xPlayer.getName(),
                coords = playerCoords
            })
        end
    end
    
    TriggerClientEvent('murderMystery:showPlayerLocations', source, playerLocations)
end)