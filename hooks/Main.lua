local hook_files = {
    ["lib/setups/gamesetup"] =                                      {"gamesetup.lua"},
    ["lib/setups/setup"] =                                          {"setup.lua"},
    ["core/lib/setups/coresetup"] =                                 {"coresetup.lua"},
    ["lib/states/menumainstate"] =                                  {"menumainstate.lua"},
    ["lib/states/ingamewaitingforplayers"] =                        {"ingamewaitingforplayers.lua"},
    ["lib/managers/menumanager"] =                                  {"menumanager.lua"},
    ["lib/units/beings/player/states/playerstandard"] =             {"playerstandard.lua"},
    ["lib/units/cameras/fpcameraplayerbase"] =                      {"fpcameraplayerbase.lua"},
}
if not zMenuTools then
    local function getScriptPath()
        local string = debug.getinfo(2, "S").source:sub(2)
        return string:match("(.*/)")
    end
    local function stringExplode(string, separator)
        local parts = {}
        for part in string:gmatch("([^" .. separator .. "]+)") do
            table.insert(parts, part)
        end
        return parts
    end
    local scriptPathTable = stringExplode(getScriptPath(), "/")
    local modPath = scriptPathTable[1] .. "/" .. scriptPathTable[2] .. "/"
    dofile(modPath .. "tools/Tools.lua")
    dofile(modPath .. "tools/Backupper.lua")
    dofile(modPath .. "tools/Updator.lua")
    zMenuTools:assignPath(modPath)
end
if RequiredScript then
	local requiredScript_key = RequiredScript:lower()
    if hook_files[requiredScript_key] then
        for _, file in ipairs(hook_files[requiredScript_key]) do
            if SystemFS:exists(zMenuTools:modPath() .. "hooks/" .. file) then
                dofile(zMenuTools:modPath() .. "hooks/" .. file)
                zMenuTools:logFileLoad("[ZM]", file, "hooked")
            end
        end
	end
end