if not game:IsLoaded() then
    game.Loaded:Wait()
end

local Players = game:GetService("Players")
local player = Players.LocalPlayer or Players.PlayerAdded:Wait()

local GamesHub = {
    [9229146348] = "https://raw.githubusercontent.com/Xenon150/JUST-ONE-MORE-ASYM/refs/heads/main/JUST_ONE_MORE_ASYM.lua", -- JUST ONE MORE ASYM
    [6035872082] = "https://raw.githubusercontent.com/Xenon150/Rivals/refs/heads/main/Rivals.lua", -- Rivals
    [3620011279] = "https://raw.githubusercontent.com/Xenon150/Raf2/refs/heads/main/Raf2.lua", -- Raf2
    [3647333358] = "https://raw.githubusercontent.com/Xenon150/evade12/refs/heads/main/evade.lua", -- Evade
    [1742264997] = "https://raw.githubusercontent.com/Xenon150/SCP-_Roleplay/refs/heads/main/SCP_Roleplay.lua", -- SCP roleplay
    [3140407822] = "https://raw.githubusercontent.com/Xenon150/Brother-s_Vow/refs/heads/main/brother's_vow.lua", -- Brother's Vow
}

local currentPlaceId = game.PlaceId
local currentGameId  = game.GameId  -- Одинаков для всех сабплейсов!

local scriptToLoad = GamesHub[currentGameId]

if not scriptToLoad then
    player:Kick(
        "\n[Xenon Hub]\nThis game is not supported!"
        .. "\nPlace ID: "    .. tostring(currentPlaceId)
        .. "\nGame ID: "     .. tostring(currentGameId)
    )
    return
end

print("Xenon Loader: Game found! GameId: " .. tostring(currentGameId) .. " | PlaceId: " .. tostring(currentPlaceId))

local fetchSuccess, scriptText = pcall(function()
    return game:HttpGet(scriptToLoad)
end)

if not fetchSuccess or type(scriptText) ~= "string" or #scriptText == 0 then
    player:Kick("\n[Xenon Hub]\nNetwork Error!\nCould not fetch the script.")
    return
end

local compiledScript, compileError = loadstring(scriptText)

if not compiledScript then
    player:Kick("\n[Xenon Hub]\nCompilation Error!\n" .. tostring(compileError))
    return
end

print("Xenon Loader: Executing script...")
local execSuccess, execError = pcall(compiledScript)

if not execSuccess then
    player:Kick("\n[Xenon Hub]\nRuntime Error!\n" .. tostring(execError))
    return
end
