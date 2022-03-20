local zMenuClass = class()

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
    panel:rect({h = 1,color = colorr,visible = true,alpha = 0.5,layer = layer or 1000})
    panel:rect({y = panel:h()-1,h = 1,color = colorr,visible = true, alpha = 0.5,layer = layer or 1000})
    panel:rect({w = 1,color = colorr,visible = true,alpha = 0.5,layer = layer or 1000})
    panel:rect({x = panel:w()-1,w = 1,color = colorr,visible = true, alpha = 0.5,layer = layer or 1000})
end
function zMenuClass:init(x,y,w,h,res_x,res_y)
    self.wsMain = zMenuTools:createCustomResWorkspace(res_x,res_y)
    self.wsMain:connect_keyboard(Input:keyboard())
    self.wsMain:connect_mouse(Input:mouse())
    self.menu_mouse_id = managers.mouse_pointer:get_id()
    self.menu_enabled = false
    self.scroll_data = {}
    self.item_height_data = {}
    self.pattern_scale_mul = 2
    local hollow_icons = true
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
    self.mainPanel = self.wsMain:panel():panel({layer = 250000})
    self.menu_master_panel = self.mainPanel:panel({layer = 1,alpha = 1,w = w,h = h,x = x,y = y,visible = true})
    self:init_menu()
end
function zMenuClass:make_box(panel,ignore_background)
    local panel_w,panel_h = panel:w(),panel:h()
    panel:rect({w = panel_w,h = panel_h,x = 0,y = 0,alpha = 1, color = self:rgb255(10,10,10)})
    panel:rect({w = panel_w - 2,h = panel_h - 2,x = 1,y = 1,alpha = 1,color = self:rgb255(60,60,60)})
    panel:rect({w = panel_w - 6,h = panel_h - 6,x = 3,y = 3,alpha = 1,color = self:rgb255(10,10,10)})
    if ignore_background then
        return
    end
    panel:bitmap({texture = "guis/textures/background_pattern", texture_rect = {0,0,panel_w/self.pattern_scale_mul, panel_h/self.pattern_scale_mul},x = 4,y = 4,w = panel_w - 8,h = panel_h - 8,layer = 1})
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
function zMenuClass:init_menu()
    self.search_bar = self.menu_master_panel:panel({layer = 5,x = 5,y = 5,w = 200,h = 30})
    self.profile_pic = self.menu_master_panel:panel({layer = 5,x = 5,y = self.menu_master_panel:h()-95,w = 200,h = 90})
    self.profile_picture = self.profile_pic:panel({layer = 5,x = 5,y = 5,h = 80,w = 80})
    self.left_side_panel = self.menu_master_panel:panel({layer = 5,x = 5,y = 36,w = 200,h = self.profile_pic:y()-38})
    self.feature_panel = self.menu_master_panel:panel({layer = 5,x = 206,y = 5,w = self.menu_master_panel:w()-211,h = self.menu_master_panel:h()-10})
    self:make_box(self.profile_picture,true)
    self:make_box(self.profile_picture,true)
    self:make_box(self.menu_master_panel)
    self:make_box(self.left_side_panel)
    self:make_box(self.search_bar)
    self:make_box(self.profile_pic)
    self:make_box(self.feature_panel)
    self.profile_picture_image = self.profile_picture:bitmap({texture = "guis/textures/pd2/none_icon",layer = 20,x = 4,y =4,alpha = 1,w = 72,h=72})
    self.profile_pic:text({text = "Status:",x = 87,y = 51,font_size = 16,align = "left", font =  "fonts/font_small_mf",color = self:rgb255(255,255,255),layer = 20})
    self.profile_pic:text({text = "DEV",x = 122,y = 51,font_size = 16,align = "left",font =  "fonts/font_small_mf",color = self:rgb255(100,255,100),layer = 20})
    self.profile_pic:text({text = tostring(Steam:username()),x = 87,y = 27, font_size = 24,align = "left",font =  "fonts/font_small_mf",color = self:rgb255(120,150,255),layer = 20})
    self.profile_pic:text({text = tostring(Steam:userid()),x = 87,y = 69, font_size = 16,align = "left",font =  "fonts/font_small_mf",color = self:rgb255(255,255,255),layer = 20})
    self:add_profile_picture()
end
function zMenuClass:reload()

end
function zMenuClass:destory()

end


zMenuTools:logFileLoad("[ZM]","main.lua","loaded item")
local path = zMenuTools:modPath()  .. "menu/items/"
for _, v in pairs(SystemFS:list(path)) do
    dofile(path .. v)
    zMenuTools:logFileLoad("[ZM]",v,"loaded item")
end
--local resMAIN = {1600,900}
local resolution = {1920,1080}
--local resMAIN = {2560,1440}
--local resMAIN = {3840,2160}
local padding = 300
local x = padding
local y = padding
local w = resolution[1] - padding*2
local h = resolution[2] - padding*2
zMenu = zMenuClass:new(x,y,w,h,resolution[1],resolution[2])
