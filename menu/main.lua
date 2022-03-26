zMenuClass = class()
function zMenuClass:rgb255(...)
    local items = {...}
    local num = #items
    if num == 4 then
        return Color(items[1]/255,items[2]/255,items[3]/255,items[4]/255)
    elseif num == 3 then
        return Color(items[1]/255,items[2]/255,items[3]/255)
    end
end
function zMenuClass:debug_panel_fill(panel,colorr)
    panel:rect({color = colorr,visible = true, alpha = 0.5,layer = 10000})
end
function zMenuClass:debug_panel_outline(panel,colorr,layer)
    panel:rect({valign = "grow", halign = "grow",h = 1,color = colorr,visible = true,alpha = 0.5,layer = layer or 1000})
    panel:rect({valign = "grow", halign = "grow",y = panel:h()-1,h = 1,color = colorr,visible = true, alpha = 0.5,layer = layer or 1000})
    panel:rect({valign = "grow", halign = "grow",w = 1,color = colorr,visible = true,alpha = 0.5,layer = layer or 1000})
    panel:rect({valign = "grow", halign = "grow",x = panel:w()-1,w = 1,color = colorr,visible = true, alpha = 0.5,layer = layer or 1000})
end
function zMenuClass:init(x,y,w,h,res_x,res_y,open_on_init)
    if not SystemFS:is_dir(zMenuTools:modPath() .. "menu_data/menu_data.json") then
        io.open(zMenuTools:modPath() .. "menu_data/menu_data.json","a")
    end
    local file = io.open(zMenuTools:modPath() .. "menu_data/menu_data.json","r")
    local text = file:read("*all")
    local saved_tab_id = "weapon_stats_tab"
    if text ~= "" and (string.len(text) > 2) then
        local temp = json.decode(text)
        x,y,w,h,saved_tab_id = temp.x,temp.y,temp.w,temp.h,temp.last_tab_id or saved_tab_id
    end
    file:close()
    --res_y = res_y*2
    --res_x = res_x*2
    self.wsMain = zMenuTools:createCustomResWorkspace(res_x,res_y)
    self.wsMain:connect_keyboard(Input:keyboard())
    self.wsMain:connect_mouse(Input:mouse())
    self.menu_mouse_id = managers.mouse_pointer:get_id()
    self.menu_enabled = false
    self.scroll_data = {}
    self.item_height_data = {}
    self.current_notifications = {}
    self.pattern_scale_mul = 2
    self.mouse_convert_mul = res_y/720
    local hollow_icons = true
    self.grow_bitmap_list = {}
    self.icons = {
        background_transparent =         {0,197,34,212},
        toggle_circle_hollow =           {70,2,27,26},
        config_move =                    {0,55,48,48},
        arrow_right =                    {84,57,28,28},
        arrow_down =                     {111,56,28,28},
        cross =                          {51,57,28,28},
        check =                          {253,3,64,64},
        alert =                          {332,3,64,64},
        info =                           {182,3,64,64},
        toggle_circle = hollow_icons and {3,2,27,26} or {70,2,27,26},
        toggle_slider = hollow_icons and {5,28,65,26} or {72,28,65,26},
    }
    self.height_data = {
        ["divider"]         = 4,
        ["button"]          = 28,
    }
    self.menu_colors = {
        lightblue = self:rgb255(120,150,255)
    }
    self.mouse_icons = {
        point = "link",
        pointer = "arrow",
        hold = "grab",
        hand = "hand",
    }
    self.mainPanel = self.wsMain:panel():panel({layer = 250000})
    self.menu_master_panel = self.mainPanel:panel({layer = 1,alpha = 1,w = w,h = h,x = x,y = y,visible = open_on_init or false})
    self.raw_menu_layout = self:getMenuLayout()
    self:initMenuBoxes()
    self:initTabs()
    self:setCurrentActiveTab(saved_tab_id,true)
end
local box_id = 0
function zMenuClass:make_box(panel,ignore_background,with_grow)
    local panel_w,panel_h = panel:w(),panel:h()
    local grow = with_grow and "grow" or nil
    panel:rect({halign = grow,valign = grow,w = panel_w,h = panel_h,x = 0,y = 0,alpha = 1, color = self:rgb255(10,10,10)})
    panel:rect({halign = grow,valign = grow,w = panel_w - 2,h = panel_h - 2,x = 1,y = 1,alpha = 1,color = self:rgb255(60,60,60)})
    panel:rect({halign = grow,valign = grow,w = panel_w - 6,h = panel_h - 6,x = 3,y = 3,alpha = 1,color = self:rgb255(10,10,10)})
    if ignore_background then
        return
    end
    local grow_bitmap = panel:bitmap({halign = grow,valign = grow,texture = "guis/textures/z_background_pattern", texture_rect = {0,0,(panel_w-8)/self.pattern_scale_mul,(panel_h-8)/self.pattern_scale_mul},x = 4,y = 4,w = panel_w - 8,h = panel_h - 8,layer = 1})
    box_id = box_id + 1
    if grow then
        self.grow_bitmap_list["box_id_" .. box_id] = grow_bitmap
    end
end
function zMenuClass:add_profile_picture()
    if not self.cached_profile_picture_data then
        Steam:friend_avatar(1, Steam:userid(), function (texture)
            local avatar = texture or "guis/textures/pd2/none_icon"
            self.profile_picture_image:set_image(avatar)
            self.cached_profile_picture_data = avatar
        end)
        return
    end
    self.profile_picture_image:set_image(self.cached_profile_picture_data)
end
function zMenuClass:initMenuBoxes()
    local mp = self.menu_master_panel
    self.search_bar = mp:panel({layer = 5,x = 5,y = 5,w = 200,h = 35})
    self.profile_pic = mp:panel({layer = 5,x = 5,y = mp:h()-95,w = 200,h = 90})
    self.profile_picture = self.profile_pic:panel({layer = 5,x = 5,y = 5,h = 80,w = 80})
    self.left_side_panel = mp:panel({layer = 5,x = 5,y = 41,w = 200,h = self.profile_pic:y()-43})
    self.feature_panel = mp:panel({layer = 5,x = 206,y = 5,w = mp:w()-211,h = mp:h()-10})
    self.feature_panel_main = self.feature_panel:panel({layer = 20,valign = "grow",halign = "grow",x = 9,y = 9,h = self.feature_panel:h()-18,w = self.feature_panel:w()-18})
    self:make_box(self.profile_picture,true)
    self:make_box(mp,true,true)
    self:make_box(self.left_side_panel,nil,true)
    self:make_box(self.search_bar)
    self:make_box(self.profile_pic)
    self:make_box(self.feature_panel,nil,true)
    self.profile_picture_image = self.profile_picture:bitmap({texture = "guis/textures/pd2/none_icon",layer = 20,x = 4,y =4,alpha = 1,w = 72,h=72})
    self.profile_pic:text({text = tostring(Steam:username()),x = 87,y = 45, font_size = 24,align = "left",font =  "fonts/font_small_mf",color = self.menu_colors.lightblue,layer = 20})
    self.profile_pic:text({text = tostring(Steam:userid()),x = 87,y = 69, font_size = 16,align = "left",font =  "fonts/font_small_mf",color = self:rgb255(255,255,255),layer = 20})
    self:add_profile_picture()
    self.master_panel_mouse_resize_panel = mp:panel({layer = 300, alpha = 1, x = mp:w()-18,w = 18, y = mp:h()-18,h = 18})
    self.master_panel_mouse_resize_panel:gradient({blend_mode = "normal", orientation = "vertical",x = self.master_panel_mouse_resize_panel:w()-3,w=2,h=17,gradient_points = {1, self.menu_colors.lightblue,0.65, self.menu_colors.lightblue, 0, self:rgb255(0,0,0,0)}})
    self.master_panel_mouse_resize_panel:gradient({blend_mode = "normal", orientation = "horizontal",y = self.master_panel_mouse_resize_panel:h()-3,h=2,w=17,gradient_points = {1, self.menu_colors.lightblue,0.65, self.menu_colors.lightblue, 0, self:rgb255(0,0,0,0)}})
    local search_panel_main = self.search_bar:panel({x = 5,y = 5, w = self.search_bar:w()-10, h = 25,alpha = 0.5})
    search_panel_main:rect({layer = 50,color = self:rgb255(10,10,10)})
    search_panel_main:rect({x = 1,y = 1,w = search_panel_main:w()-2,h = search_panel_main:h()-2, layer = 51,color = self:rgb255(60,60,60)})
    search_panel_main:text({name = "search_bar_id",text = "Search",x = 5,y = 3,font_size = 18,layer = 105,align = "left",font =  "fonts/font_small_mf",color = self:rgb255(200,200,200)})
end
function zMenuClass:isMenuopen()
    return self.menu_enabled
end
function zMenuClass:openMenu()
    managers.menu._input_enabled = false
	for _, menu in ipairs(managers.menu._open_menus) do
		menu.input._controller:disable()
    end
	if not self._controller then
        self._controller = managers.controller:create_controller("zMenuMouseController", nil, false)
        self._controller:add_trigger("cancel", callback(self, self, "keyboard_cancel"))
		self._controller:add_trigger("confirm", callback(self, self, "keyboard_confirm"))
		if managers.menu:is_pc_controller() then
			managers.mouse_pointer:use_mouse({mouse_move = callback(self,self,"mouse_move"),mouse_press = callback(self,self,"mouse_press"),mouse_release = callback(self,self,"mouse_release"),id = self.menu_mouse_id})
		end
    end
    self._controller:enable()
    self.menu_enabled = true
    self.menu_master_panel:set_visible(true)
end
function zMenuClass:closeMenu()
    managers.mouse_pointer:remove_mouse(self.menu_mouse_id)
	if self._controller then
		self._controller:destroy()
		self._controller = nil
    end
    managers.menu._input_enabled = true
    for _, menu in ipairs(managers.menu._open_menus) do
        menu.input._controller:enable()
    end
    self.menu_enabled = false
    self.menu_master_panel:set_visible(false)
end
function zMenuClass:keyboard_cancel()
    if self:isMenuopen() then
        self:closeMenu()
    end
end
function zMenuClass:keyboard_confirm()
    
end
function zMenuClass:update()
    self:updateNotifications()
end
zMenuTools:logFileLoad("[ZM]","main.lua","loaded item")
local path = zMenuTools:modPath()  .. "menu/items/"
for _, v in pairs(SystemFS:list(path)) do
    dofile(path .. v)
    zMenuTools:logFileLoad("[ZM]",v,"loaded item")
end
