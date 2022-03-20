local BackUpperClass = class()
function BackUpperClass:init(class_name)
    self._name = class_name
    self._originals = {}
    self._hacked = {}
end
function BackUpperClass:backup(stuff_string, name)
    if self._originals[name] or self._originals[stuff_string] then
        return self._originals[name] or self._originals[stuff_string]
    end
    local execute, serr = loadstring(self._name .. '._originals["' .. (name or stuff_string) .. '"] = ' .. stuff_string)
    local success, err = pcall(execute)
    if success then
        return self._originals[name] or self._originals[stuff_string]
    end
end
function BackUpperClass:restore(stuff_string, name)
    local n = self._originals[name] or self._originals[stuff_string]
    if n then
        local exec, serr = loadstring(stuff_string .. " = " .. self._name .. '._originals["' .. stuff_string .. '"]')
        local success, err = pcall(exec)
        if success then
            self._originals[stuff_string] = nil
            self._hacked[stuff_string] = nil
        end
    end
end
function BackUpperClass:restore_all()
    for n, _ in pairs(self._originals) do
        local exec, serr = loadstring(n .. " = " .. self._name .. '._originals["' .. n .. '"]')
        local success, err = pcall(exec)
        if success then
            self._originals[n] = nil
            self._hacked[n] = nil
        end
    end
end
zMenuBackupper = BackUpperClass:new("zMenuBackupper")
