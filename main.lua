SLASH_HELLO1 = "/helloworld"
SLASH_TRINK1 = "/trinket"

local playerName = UnitName("player")

local function helloWorldHandler(name)

    local nameExists = string.len(name) > 0

    if(nameExists) then
        message("Hello, " .. name .. "!")
    else
        local playerName = UnitName("player")

        message("Hello, " .. playerName .. "!")
    end
end


local TrinketInfo1 = GetInventoryItemCooldown("player", 13)
local TrinketInfo2 = GetInventoryItemCooldown("player", 14)
local CurrentPlayerHealth = UnitHealth(playerName)
local MaxPlayerHealth = UnitHealthMax(playerName)
local DebuffInfo = UnitDebuff(playerName)

local function testTrinket(TrinketInfo1)
    message(TrinketInfo1)
end

SlashCmdList["HELLO"] = helloWorldHandler
SlashCmdList["TRINK"] = testTrinket


