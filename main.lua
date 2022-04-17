playerName = UnitName("player")

SLASH_TRINK1 = "/trinket"

local function trinketHandler()
    local start, duration, enable = GetInventoryItemCooldown(playerName, 13)

    local cooldown = duration-(GetTime() - start);

    message(cooldown)
end

SlashCmdList["TRINK"] = trinketHandler

SLASH_HEALTH1 = "/health"

local function healthHandler()
    local health = UnitHealth(playerName)
    local maxHealth = UnitHealthMax(playerName)

    message(health)
end

SlashCmdList["HEALTH"] = healthHandler

SLASH_DEBUFF1 = "/debuff"

local function debuffHandler()
    local name, rank, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable, shouldConsolidate, spellId = UnitDebuff(playerName, 1)
    message(name)
end

SlashCmdList["DEBUFF"] = debuffHandler

