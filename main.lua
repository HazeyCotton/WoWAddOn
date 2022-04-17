-- On runtime grabs user player's name for later use. it is set as a global variable
playerName = UnitName("player")
--SLASH_ is used to create commands in WoW
SLASH_TRINK1 = "/trinket"
--trinketHandler()
--used for obtaining start, duration, and enable from WoW API then creates cooldown variable 
local function trinketHandler()
    local start, duration, enable = GetInventoryItemCooldown(playerName, 13)

    local cooldown = duration-(GetTime() - start);

    local table = {start, duration, enable, cooldown}

    --Now to store into JSON files
    file = io.open("exampleTrinket.JSON", "w")
    io.write(table)
    io.close(file)

end
--combined with SLASH_ to create commands in WoW
SlashCmdList["TRINK"] = trinketHandler

SLASH_HEALTH1 = "/health"
--healthHandler()
--used for obtaining health and maxHealth from WoW API
local function healthHandler()
    local health = UnitHealth(playerName)
    local maxHealth = UnitHealthMax(playerName)

    local table = {health, maxHealth}

    --Now to store into JSON files
    file = io.open("exampleHealth.JSON", "w")
    io.write(table)
    io.close(file)

end

SlashCmdList["HEALTH"] = healthHandler

SLASH_DEBUFF1 = "/debuff"
--debuffHandler()
--used for grabbing all necessary variables from UnitDebuff in the WoW API
local function debuffHandler()
    local name, rank, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable, shouldConsolidate, spellId = UnitDebuff(playerName, 1)

    local table = {name, rank, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable, shouldConsolidate, spellId}

    --Now to store into JSON files
    file = io.open("exampleDebuff.JSON", "w")
    io.write(table)
    io.close(file)
end

SlashCmdList["DEBUFF"] = debuffHandler




