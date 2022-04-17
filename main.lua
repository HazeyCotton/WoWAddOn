-- Global Variables
playerName = UnitName("player")
healthResult = ""
trinketResult = ""
debuffResult = ""

--SLASH_ is used to create commands in WoW
SLASH_TRINK1 = "/trinket"
--trinketHandler()
--used for obtaining start, duration, and enable from WoW API then creates cooldown variable 
local function trinketHandler()
    local start, duration, enable = GetInventoryItemCooldown(playerName, 13)

    local cooldown = duration-(GetTime() - start);

    local table = {start, duration, enable, cooldown}

    --concats values into JSON string
    trinketResult = "{start: " .. start .. ", duration: " .. duration .. ", cooldown: " .. cooldown .. "}"
    message(trinketResult)

end
--combined with SLASH_ to create commands in WoW
SlashCmdList["TRINK"] = trinketHandler

SLASH_HEALTH1 = "/health"
--healthHandler()
--used for obtaining health and maxHealth from WoW API
local function healthHandler()
    local health = UnitHealth(playerName)
    local maxHealth = UnitHealthMax(playerName)

    --concats values into JSON string
    healthResult = "{Health: " .. health .. ", maxHealth: " .. maxHealth .. "}"
    message(healthResult)

end

SlashCmdList["HEALTH"] = healthHandler

SLASH_DEBUFF1 = "/debuff"
--debuffHandler()
--used for grabbing all necessary variables from UnitDebuff in the WoW API
local function debuffHandler()
    local name, rank, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable, shouldConsolidate, spellId = UnitDebuff(playerName, 1)

    --concats values into JSON string
    debuffResult = "{Name: " .. name .. ", count: " .. count .. ", debuffType: " .. debuffType .. ", duration: " .. duration .. ", expirationTime: " .. expirationTime .."}"
    message(debuffResult)
end

SlashCmdList["DEBUFF"] = debuffHandler




