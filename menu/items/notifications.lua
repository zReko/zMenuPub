local current_time = 0
function zMenuClass:updateNotifications()
    current_time = current_time + zMenuTools:currentTimeDelta()
end
local function replace(str, what, with)
    what = string.gsub(what, "[%(%)%.%+%-%*%?%[%]%^%$%%]", "%%%1") -- escape pattern
    with = string.gsub(with, "[%%]", "%%%%") -- escape replacement
    return string.gsub(str, what, with)
end
function zMenuClass:showNotification(params)
    local text = params.text or ""
    local text_color = params.text_color or Color(1,1,1)
    if params.text_color == true then
        text_color = self:rgb255(120,255,120)
    elseif params.text_color== false then
        text_color = self:rgb255(255,90,90)
    end
    local time = params.time or 5
    local highlight_message = params.highlight_message or nil
    local highlight_message_color = params.highlight_message_color or Color(1,1,1,1)
    local rgb_enabled = params.rgb_enabled or false
    local rgb_speed = params.rgb_speed or 1
    local icon = params.icon or nil
    local icon_color = params.icon_color or nil
    local parent_panel = self.mainPanel
    local notification_panel = parent_panel:panel({x = parent_panel:x(),w = parent_panel:w(),y = parent_panel:h()-32,h = 800,alpha = 1,layer = 5000,visible = true})
    local text_panel = notification_panel:text({word_wrap = true,wrap = true,align = "left",text = text,x = 8,y = 5,font_size = 20,alpha = 1,font = "fonts/font_small_mf",color = text_color,layer = 4})
    if highlight_message then
        highlight_message = replace(highlight_message,"-","%-")
        local start = string.find(string.lower(text),string.lower(highlight_message))
        if start then
            text_panel:set_selection(start-1,start + string.len(highlight_message))
            text_panel:set_selection_color(highlight_message_color)
            if rgb_enabled then
                text_panel:animate(function(o) zMenuTools:animate_UI(time-0.05,
                    function(p)
                        local r,g,b = self:get_rgb_from_hsv((zMenuTools:currentTime()*(360*rgb_speed))%360,1,1)
                        o:set_selection_color(Color(r,g,b))
                    end)
                end)
            end
        end
    end
    local text_height_px = select(4,text_panel:text_rect()) + 2
    local text_width_px = select(3,text_panel:text_rect()) + 2
    notification_panel:set_w(text_width_px+14)
    notification_panel:set_h(text_height_px+11)
    notification_panel:set_y(parent_panel:h()-50)

    if icon then
        local yes_icon = notification_panel:bitmap({texture = "guis/textures/z_menu_icons",x = notification_panel:w()+6,y = (notification_panel:h()/2)-16,rotation = 0.0001,texture_rect = icon,w = 100,h = 100,layer = 20000,color = icon_color,alpha = 0.8})
        local state = true
        local anim_state = 0
        local yes_icon_x = yes_icon:x()
        local yes_icon_y = yes_icon:y()
        yes_icon:animate(function(o) zMenuTools:animateInf_UI(
            function(p)
                anim_state = anim_state + zMenuTools:currentTimeDelta()/2
                if state then
                    o:set_alpha(math.lerp(o:alpha(),0.3,anim_state))
                    o:set_x(math.lerp(o:x(),yes_icon_x+2,anim_state))
                    o:set_y(math.lerp(o:y(),yes_icon_y+2,anim_state))
                    o:set_w(math.lerp(o:w(),32-4,anim_state))
                    o:set_h(math.lerp(o:h(),32-4,anim_state))
                else
                    o:set_alpha(math.lerp(o:alpha(),1,anim_state))
                    o:set_x(math.lerp(o:x(),yes_icon_x,anim_state))
                    o:set_y(math.lerp(o:y(),yes_icon_y,anim_state))
                    o:set_w(math.lerp(o:w(),32,anim_state))
                    o:set_h(math.lerp(o:h(),32,anim_state))
                end
                if o:alpha() <= 0.35 then
                    state = false
                    anim_state = 0
                end
                if o:alpha() >= 0.9 then
                    state = true
                    anim_state = 0
                end
            end)
        end)
    end
    self:make_box(notification_panel)
    local linerect = notification_panel:rect({w = notification_panel:w() - 8,h = 2,x = 4,y = text_height_px+4,alpha = 1,color = text_color,layer = 3})
    local target_y = notification_panel:y()
    local data = {height = notification_panel:h(),cur_time = current_time + time,anim_y = notification_panel,anim_x = text_panel,line = linerect,panel_y = target_y,positions = 1}
    if not self.current_notifications then
        self.current_notifications = {}
    end
    table.insert(self.current_notifications,data)
    local start_w = linerect:w()
    local start_x = linerect:x()
    linerect:animate(function(o) zMenuTools:animate_UI(time,
        function(p)
            o:set_w(math.lerp(start_w,start_x,p))
            local current_y = (notification_panel:y() - data.panel_y)/20
            notification_panel:set_y(notification_panel:y()-current_y)
            --self:check_mouse_pos(data)
        end)
    end)
    for i,v in pairs(self.current_notifications) do
        self.current_notifications[i].panel_y = self.current_notifications[i].panel_y - notification_panel:h() - 2
    end
end