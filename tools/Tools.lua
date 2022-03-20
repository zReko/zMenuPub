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
    local text = "      " .. prefix ..  " --- " .. suffix .. " --- " .. text
    local repeatstr = 75 - string.len(text)
    log(text .. string.rep(" ", repeatstr))
end
function zMenuToolsClass:loadPackage(pack)
    local canLoad = false
    if PackageManager:package_exists(pack) then
        canLoad = true
    end
    if canLoad and PackageManager:loaded(pack) then
        canLoad = false
        self:setLoadedPackage(pack)
        self:logFileLoad("[ZM]", pack, "already loaded package")
    end
    if canLoad then
        PackageManager:load(pack)
        self:setLoadedPackage(pack)
        self:logFileLoad("[ZM]", pack, "loaded package")
    end
end
function zMenuToolsClass:setLoadedPackage(pack)
    self.loadedPacks = self.loadedPacks or {}
    self.loadedPacks[pack] = true
end
function zMenuToolsClass:isPackageLoaded(pack)
    if PackageManager:package_exists(pack) and PackageManager:loaded(pack) then
        return true
    end
    return false
end
zMenuTools = zMenuToolsClass:new()
zMenuTools:logFileLoad("[ZM]", "Tools.lua", "loaded")
