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
    if PackageManager:package_exists(pack) then
        if PackageManager:loaded(pack) then
            self:logFileLoad("[ZM]", pack, "already loaded package")
        else
            PackageManager:load(pack)
            self:logFileLoad("[ZM]", pack, "loaded package")
        end
    end
end
function zMenuToolsClass:isPackageLoaded(pack)
    if PackageManager:package_exists(pack) and PackageManager:loaded(pack) then
        return true
    end
    return false
end
function zMenuToolsClass:animate_UI(TOTAL_T, callback)
    local t = 0
    local const_frames = 0
    local count_frames = const_frames + 1
    while t < TOTAL_T do
        t = t + coroutine.yield()
        if count_frames >= const_frames then
            callback(t / TOTAL_T, t)
            count_frames = 0
        end
        count_frames = count_frames + 1
	end
	callback(1, TOTAL_T)
end
function zMenuToolsClass:animateInf_UI(callback)
    local const_frames = 0
    local count_frames = const_frames + 1
    while true do
        coroutine.yield()
        if count_frames >= const_frames then
            callback()
            count_frames = 0
        end
        count_frames = count_frames + 1
	end
	callback()
end
function zMenuToolsClass:createCustomResWorkspace(wid,hei,namee)
    local name = "_fullrect_" .. tostring(wid) .. "x" .. tostring(hei) .. "_data" .. (namee and "_" or "") .. (namee or "")
    managers.gui_data[name] = {}
    managers.gui_data[name].w = wid
    managers.gui_data[name].h = hei
    managers.gui_data[name].width = managers.gui_data[name].w
    managers.gui_data[name].height = managers.gui_data[name].h
    managers.gui_data[name].x = RenderSettings.resolution.x / 2 - math.min(RenderSettings.resolution.y, RenderSettings.resolution.x / (wid / hei)) * wid / hei / 2
    managers.gui_data[name].y = RenderSettings.resolution.y / 2 - math.min(RenderSettings.resolution.x, RenderSettings.resolution.y * wid / hei) / (wid / hei) / 2
    managers.gui_data[name].on_screen_width = math.min(RenderSettings.resolution.x, RenderSettings.resolution.y * wid / hei)
    managers.gui_data[name].convert_x = 0
    managers.gui_data[name].convert_y = 0
	local ws = (managers.gui_data._scene_gui or Overlay:gui()):create_scaled_screen_workspace(10, 10, 10, 10, 10)
	managers.gui_data._workspace_configuration[ws:key()] = {workspace_object = nil}
	managers.gui_data:_set_layout(ws, managers.gui_data[name])
	return ws
end
function zMenuToolsClass:debugTable(tbl,num,loc)
    self:dumpContentIntoFile(self:getArrayContent(tbl,num),loc or "[debugTable]")
end
function zMenuToolsClass:dumpContentIntoFile(data,path,mode)
    local file_name = self:modPath() .. path ..".txt"
    local file = io.open(file_name, "a")
    file:close()
    local file = io.open(file_name, mode or "w+")
    file:write(data)
    file:flush()
    file:close()
end
local function not_in_list(str,tbl)
    if tbl ~= nil then
        for _,v in pairs(tbl)do
            if tostring(str) == v then
                return false
            end
        end
    end
    return true
end
local function count_table_elements(tbl)
    local count = 0
    if type(tbl) == "table" then
        for _ in pairs(tbl)do
            count = count + 1
        end
    else
        return ""
    end
    return " ITEMS: [" .. tostring(count) .. "]"
end
local function remove_newline(str)
    return str:gsub("[\n\r]", "[NEWLINE]")
end
local function table_recursion(item,depth,original_d,ignore_tables)
    local text = ""
    local space_wdith = 50
    local stringlen = original_d - depth
    if depth and depth > 0 then
        if type(item) == "table" then
            for i ,v in pairs(item)do
                text = text .. string.rep("     ",stringlen) ..tostring(i) .. string.rep(" ",space_wdith - string.len(tostring(i))) .. remove_newline(tostring(v)) .. "             " .. tostring(type(v)) .. count_table_elements(v) .."\n"
                if type(v) == "table" and not_in_list(i,ignore_tables) == true then
                    depth = depth - 1
                    text = text .. table_recursion(v,depth,original_d,ignore_tables)
                    depth = depth + 1
                end
            end
        end
    end
    return tostring(text)
end
function zMenuToolsClass:getArrayContent(item,num,tab)
    return table_recursion(item,num,num,tab)
end
zMenuTools = zMenuToolsClass:new()
zMenuTools:logFileLoad("[ZM]", "Tools.lua", "loaded")
