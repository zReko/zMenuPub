function zMenuClass:createTabDivider(parent,height,hh)
    local item_panel = parent:panel({y = height,h = hh,layer = 50})
    item_panel:rect({x = item_panel:x() + 5,w = item_panel:w() - 10,h = 4,alpha = 1,layer = 50,color = self:rgb255(10,10,10)})
    item_panel:rect({x = item_panel:x() + 6,y = 1,w = item_panel:w() - 12,h = 2,alpha = 1,layer = 50,color = self:rgb255(60,60,60)})
end
function zMenuClass:createTabButton(parent,height,item,hh)
    local item_panel = parent:panel({y = height,h = hh,layer = 50})
    local text = item_panel:text({name = item.menu_id,text = string.upper(item.text), font_size = 16,y = 6,align = "center",font =  "fonts/font_small_mf",color = self:rgb255(255,255,255),layer = 51})
    self.tab_items[item.menu_id] = {panel = item_panel,menu_id = item.menu_id,button_text = text}
end
function zMenuClass:checkTabHover()
    if self.currentTabHover then
        local item = self.tab_items[self.currentTabHover]
        if not self:isMouseInPanel(item.panel) and item.menu_id ~= self.currentActiveTab then
            local panel = item.button_text
            panel:stop()
            panel:animate(function(o) zMenuTools:animate_UI(0.2,
                function(p)
                    o:set_font_size(math.lerp(o:font_size(),16,p))
                    o:set_y(math.lerp(o:y(),6,p))
                    o:set_color(self:animateColors3(o:color(),Color(1,1,1),p))
                    o:set_kern(math.lerp(o:kern(),0.5,p))
                end)
            end)
            self:setPointerImg(self.mouse_icons.arrow)
            self.currentTabHover = nil
        end
        return
    end
    if not self:isMouseInPanel(self.left_side_panel) then
        return
    end
    for i,v in pairs(self.tab_items) do
        if self:isMouseInPanel(v.panel) and i ~= self.currentActiveTab then
            self.currentTabHover = i
            v.button_text:stop()
            v.button_text:animate(function(o) zMenuTools:animate_UI(0.05,
                function(p)
                    o:set_font_size(math.lerp(o:font_size(),20,p))
                    o:set_y(math.lerp(o:y(),4,p))
                    o:set_color(self:animateColors3(o:color(),Color(1,1,1),p))
                    o:set_kern(math.lerp(o:kern(),0,p))
                end)
            end)
            self:setPointerImg(self.mouse_icons.point)
            return
        end
    end
end
function zMenuClass:setCurrentActiveTab(tab_id,play_anim)
    if self.currentActiveTab then
        local item = self.tab_items[self.currentActiveTab].button_text
        item:stop()
        item:animate(function(o) zMenuTools:animate_UI(0.5,
            function(p)
                o:set_font_size(math.lerp(o:font_size(),16,p))
                o:set_y(math.lerp(o:y(),6,p))
                o:set_color(self:animateColors3(o:color(),Color(1,1,1),p))
                o:set_kern(math.lerp(o:kern(),0.5,p))
            end)
        end)
    end
    local item = self.tab_items[tab_id].button_text
    if play_anim then
        item:set_font_size(22)
        item:set_y(3)
        item:set_color(Color(0.2,0.6,1))
        item:set_kern(2.5)
    else
        item:stop()
        item:animate(function(o) zMenuTools:animate_UI(1,
            function(p)
                o:set_font_size(math.lerp(o:font_size(),22,p*3))
                o:set_y(math.lerp(o:y(),3,p*3))
                o:set_color(self:animateColors3(o:color(),Color(0.2,0.6,1),p))
                o:set_kern(math.lerp(o:kern(),2.5,p))
            end)
        end)
    end
    self:setPointerImg(self.mouse_icons.pointer)
    self.currentActiveTab = tab_id
    self.currentTabHover = nil
end
function zMenuClass:checkTabClick()
    for i,v in pairs(self.tab_items) do
        if self:isMouseInPanel(v.panel) and i ~= self.currentActiveTab then
            self:setCurrentActiveTab(i)
            return
        end
    end
end
function zMenuClass:initTabs()
    local parent_panel = self.left_side_panel:panel({valign = "grow",x = 4,y = 4,w = self.left_side_panel:w()-8,h = self.left_side_panel:h()-8})
    local tabs = self.raw_menu_layout.tab_list
    self.tab_items = {}
    local sum_of_h = 0
    local last_id = ""
    local last_h = 0
    for i,v in pairs(tabs) do
        local item_type = v.type
        local type_h = self.height_data[item_type]
        if item_type == "button" then
            self:createTabButton(parent_panel,sum_of_h,v,type_h)
            sum_of_h = sum_of_h + type_h
        elseif item_type == "divider" then
            self:createTabDivider(parent_panel,sum_of_h,type_h)
            sum_of_h = sum_of_h + type_h
        end
        if v.menu_id then
            last_id = v.menu_id
            last_h = type_h
        end
    end
    self.max_height_menu = (self.tab_items[last_id].panel:world_y() + last_h + 100) - self.menu_master_panel:y()
end