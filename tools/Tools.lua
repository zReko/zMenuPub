local zMenuToolsClass = class()
function zMenuToolsClass:has_mod_path()
    if self.mod_path and self.mod_path ~= "" and string.len(self.mod_path) > 3 then
        return true
    end
    return false
end
function zMenuToolsClass:assignPath(path)
    self.mod_path = path
end
function zMenuToolsClass:modPath()
    return self.mod_path or ""
end
function zMenuToolsClass:currentTime()
    return TimerManager:main():time()
end
function zMenuToolsClass:currentTimeDelta()
    return TimerManager:main():delta_time()
end
function zMenuToolsClass:logFileLoad(prefix, text, suffix)
    local text = prefix .. "                   " .. text
    local repeatstr = 75 - string.len(text)
    log(text .. string.rep(" ", repeatstr) .. suffix)
end
zMenuTools = zMenuToolsClass:new()
zMenuTools:logFileLoad("[ZM]", "Tools.lua", "loaded")
