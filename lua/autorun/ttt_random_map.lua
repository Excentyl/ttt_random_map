if SERVER then
    local random_map = "ttt_random_map"
    RMAP = {}

    function RMAP:GetMaps()
        local files = file.Find("maps/ttt_*.bsp", "GAME")
        local maps = {}

        for k, map in pairs(files) do
            local mapstr = map:sub(1, -5)

            if mapstr != random_map then 
                table.insert(maps, mapstr)
            end
        end

        return maps
    end

    function RMAP:ChangeToRandomLevel()
        local maps = RMAP:GetMaps()
        local rm = maps[math.random(#maps)]
        RunConsoleCommand("changelevel", rm)
    end

    local function CheckIfDefaultMap()
        if game.GetMap() == random_map then
            RMAP:ChangeToRandomLevel()
        end
    end

    concommand.Add("changetorandomlevel", RMAP:ChangeToRandomLevel())
    concommand.Add("getmap", function()
    end)

    hook.Add("InitPostEntity", "change_to_random_map_event", CheckIfDefaultMap)
end