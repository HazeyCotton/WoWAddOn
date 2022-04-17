
SLASH_HELLO1 = "/helloworld"
SLASH_TRINK1 = "/trinket"



local function helloWorldHandler(name)

    local nameExists = string.len(name) > 0

    if(nameExists) then
        message("Hello, " .. name .. "!")
    else
        local playerName = UnitName("player")

        message("Hello, " .. playerName .. "!")
    end
end



local playerName = UnitName("player")

TrinketInfo1 = GetInventoryItemCooldown(playerName, 13)
TrinketInfo2 = GetInventoryItemCooldown(playerName, 14)
CurrentPlayerHealth = UnitHealth(playerName)
MaxPlayerHealth = UnitHealthMax(playerName)
DebuffInfo = UnitDebuff(playerName)

local function testTrinket(TrinketInfo)
    message("Start: ".. TrinketInfo1.start .. ". Duration: " .. TrinketInfo1.duration .. "! Start: " .. TrinketInfo2.start .. ". Duration: " .. TrinketInfo2.duration)
end

SlashCmdList["HELLO"] = helloWorldHandler
SlashCmdList["TRINK"] = testTrinket


