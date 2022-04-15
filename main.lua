
SLASH_HELLO1 = "/helloworld"



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
