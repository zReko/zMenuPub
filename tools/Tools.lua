local zMenuToolsClass = class()
function zMenuToolsClass:has_mod_path()
    if self.mod_path and self.mod_path ~= "" and string.len(self.mod_path) > 3 then
        return true
    end
    return false
end
function zMenuToolsClass:assign_path(path)
    self.mod_path = path
end
function zMenuToolsClass:mod_path()
    return self.mod_path or ""
end
function zMenuToolsClass:currentTime()
    return TimerManager:main():time()
end
function zMenuToolsClass:currentTimeDelta()
    return TimerManager:main():delta_time()
end

zMenuTools = zMenuToolsClass:new()
