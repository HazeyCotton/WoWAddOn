SLASH_HELLO1 = "/helloworld"


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


SlashCmdList["HELLO"] = helloWorldHandler

SLASH_TRINK1 = "/trinket"

local function trinketHandler(name)
    local trinket1 = {}
    local playerName = UnitName("player")
    trinket1 = GetInventoryItemCooldown(playerName, 13)
    message(trinket1)
end

SlashCmdList["TRINK"] = trinketHandler



