
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

TrinketInfo = GetInventoryItemCooldown(playerName, 14)
CurrentPlayerHealth = UnitHealth(playerName)
MaxPlayerHealth = UnitHealthMax(playerName)
DebuffInfo = UnitDebuff(playerName)

local function testTrinket(TrinketInfo)
    message("Start: " .. TrinketInfo.start .. ". Duration: " .. TrinketInfo.duration)
end

SlashCmdList["HELLO"] = helloWorldHandler
SlashCmdList["TRINKET"] = testTrinket


