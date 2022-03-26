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
function zMenuToolsClass:ChatHiddenMessage(prefix, message, color)
    managers.chat:_receive_message(1, prefix, message, color or Color(0.031, 0.090, 1))
end
function zMenuToolsClass:isPlaying()
    if not BaseNetworkHandler then
        return false
    end
    return BaseNetworkHandler._gamestate_filter.any_ingame_playing[game_state_machine:last_queued_state_name()]
end
function zMenuToolsClass:isInTitlescreen()
    if not game_state_machine then
        return false
    end
    return string.find(game_state_machine:current_state_name(), "titlescreen")
end
function zMenuToolsClass:isLoading()
    if not BaseNetworkHandler then
        return false
    end
    return BaseNetworkHandler._gamestate_filter.waiting_for_players[game_state_machine:last_queued_state_name()]
end
function zMenuToolsClass:isInGame()
    if not game_state_machine then
        return false
    end
    return string.find(game_state_machine:current_state_name(), "game")
end
function zMenuToolsClass:isChatOpen()
    if managers.menu_component and managers.menu_component._contract_broker_gui and managers.menu_component._contract_broker_gui._search_focus == true then
        return true
    end
    if managers.hud and managers.hud._chat_focus == true then
        return true
    end
    if managers.menu_component and managers.menu_component._game_chat_gui and managers.menu_component._game_chat_gui:input_focus() == true then
        return true
    end
    return false
end
function zMenuToolsClass:isInHeist()
    if not self:bIsLoading() and self:bIsInGame() then
        return true
    end
    return false
end
function zMenuToolsClass:isInLoadout()
    if self:bIsLoading() and self:bIsInGame() then
        return true
    end
    return false
end
function zMenuToolsClass:isInMenu()
    if not self:bIsLoading() and not self:bIsInGame() then
        return true
    end
    return false
end
function zMenuToolsClass:allEnemies()
    return managers.enemy:all_enemies()
end
function zMenuToolsClass:allCivilians()
    return managers.enemy:all_civilians()
end
function zMenuToolsClass:isEneOrCiv(unit)
    if managers.enemy:is_civilian(unit) or managers.enemy:is_enemy(unit) then
        return true
    end
    return false
end
function zMenuToolsClass:isHost()
    if not Network then
        return false
    end
    return not Network:is_client()
end
function zMenuToolsClass:inChat()
    if managers.hud and managers.hud._chat_focus then
        return true
    end
    return false
end
function zMenuToolsClass:isOnLadder()
    if self:localPlayer() then
        return self:localPlayer():movement():current_state():on_ladder() or false
    end
    return false
end
function zMenuToolsClass:isSteelsight()
    if self:localPlayer() then
        return self:localPlayer():movement():current_state():in_steelsight() or false
    end
    return false
end
function zMenuToolsClass:isInAir()
    if self:localPlayer() then
        return self:localPlayer():movement():current_state():in_air() or false
    end
    return false
end
function zMenuToolsClass:localPlayer()
    if managers.player and managers.player:local_player() then
        return managers.player:local_player()
    end
    return nil
end
function zMenuToolsClass:pLocalPlayerPos()
    if self:localPlayer() then
        return self:localPlayer():movement():m_pos()
    end
    return nil
end
function zMenuToolsClass:pLocalPlayerRot()
    if self:localPlayer() then
        return self:localPlayer():movement():m_head_rot()
    end
    return nil
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
        coroutine.yield()
        t = t + self:currentTimeDelta()
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
function zMenuToolsClass:loadSharedFeatures()
    local path = self:modPath()  .. "features/shared/"
    for _, v in pairs(SystemFS:list(path)) do
        dofile(path .. v)
        self:logFileLoad("[ZM]",v,"loaded feature")
    end
end
function zMenuToolsClass:loadPreplanFeatures()
    local path = self:modPath()  .. "features/preplan/"
    for _, v in pairs(SystemFS:list(path)) do
        dofile(path .. v)
        self:logFileLoad("[ZM]",v,"loaded feature")
    end
end
function zMenuToolsClass:loadHeistFeatures()
    local path = self:modPath()  .. "features/heist/"
    for _, v in pairs(SystemFS:list(path)) do
        dofile(path .. v)
        self:logFileLoad("[ZM]",v,"loaded feature")
    end
end
function zMenuToolsClass:loadMenuFeatures()
    local path = self:modPath()  .. "features/menu/"
    for _, v in pairs(SystemFS:list(path)) do
        dofile(path .. v)
        self:logFileLoad("[ZM]",v,"loaded feature")
    end
end
function zMenuToolsClass:initMenu(open_on_start)
    --local resMAIN = {1600,900}
    local resolution = {1920,1080}
    --local resMAIN = {2560,1440}
    --local resMAIN = {3840,2160}
    local padding = 300
    local x = padding
    local y = padding
    local w = resolution[1] - padding*2
    local h = resolution[2] - padding*2
    dofile(self:modPath()  .. "menu/main.lua")
    zMenu = zMenuClass:new(x,y,w,h,resolution[1],resolution[2],open_on_start or false)
    zMenuUpdator:add(function ()zMenu:update()end,"menuLoop")
end
function zMenuToolsClass:reloadMenu()
    if zMenu:isMenuopen()  then
        zMenu:closeMenu()
    end
    zMenu.mainPanel:parent():remove(zMenu.mainPanel)
    managers.gui_data:destroy_workspace(zMenu.wsMain)
    zMenu = nil
    self:initMenu(true)
    zMenu:openMenu()
end
function zMenuToolsClass:easeInOutSine(time, start, final, delta)
    return -final/2 * (math.cos(math.pi*time/delta) - 1) + start;
end
zMenuTools = zMenuToolsClass:new()
zMenuTools:logFileLoad("[ZM]", "Tools.lua", "loaded")
