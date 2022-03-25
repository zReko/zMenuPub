function zMenuClass:createTabDivider(parent,height,hh)
    local item_panel = parent:panel({y = height,h = hh,layer = 50})
    item_panel:rect({x = item_panel:x() + 5,w = item_panel:w() - 10,h = hh,alpha = 1,layer = 50,color = self:rgb255(10,10,10)})
    item_panel:rect({x = item_panel:x() + 6,y = 1,w = item_panel:w() - 12,h = hh-2,alpha = 1,layer = 50,color = self:rgb255(60,60,60)})
end
function zMenuClass:createTabButton(parent,height,item,hh)
    local item_panel = parent:panel({y = height,h = hh,layer = 50})
    local text = item_panel:text({name = item.menu_id,text = string.upper(item.text), font_size = 16,word_wrap = true,y = 6,align = "center",font =  "fonts/font_small_mf",color = Color(0.7,0.7,0.7),layer = 51})
    text:set_kern(-0.5)
    self.tab_items[item.menu_id] = {panel = item_panel,menu_id = item.menu_id,button_text = text}
end
function zMenuClass:animSelect(item)
    local t = 0
    item:animate(function(o) zMenuTools:animateInf_UI(function(p)
            t = t + zMenuTools:currentTimeDelta()
            o:set_kern(zMenuTools:easeInOutSine(t,1,2,0.016))
        end)
    end)
end
function zMenuClass:checkTabHover()
    if self.currentTabHover then
        local item = self.tab_items[self.currentTabHover]
        if not self:isMouseInPanel(item.panel) and item.menu_id ~= self.currentActiveTab then
            local panel = item.button_text
            panel:stop()
            panel:animate(function(o) zMenuTools:animate_UI(1,
                function(p)
                    o:set_font_size(math.lerp(o:font_size(),16,p))
                    o:set_y(math.lerp(o:y(),6,p))
                    o:set_color(self:animateColors3(o:color(),Color(0.7,0.7,0.7),p))
                    o:set_kern(math.lerp(o:kern(),-0.5,p))
                end)
            end)
            self:unHighlightElement()
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
            local item = v.button_text
            item:stop()
            item:set_font_size(20)
            item:set_y(4)
            item:set_color(Color(1,1,1))
            item:set_kern(1)
            self:setPointerImg(self.mouse_icons.point)
            self:highlightElement(v.panel)
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
                o:set_color(self:animateColors3(o:color(),Color(0.7,0.7,0.7),p))
                o:set_kern(math.lerp(o:kern(),-0.5,p))
            end)
        end)
    end
    local item = self.tab_items[tab_id].button_text
    if play_anim then
        item:set_font_size(22)
        item:set_y(3)
        item:set_color(Color(0.2,0.6,1))
        item:set_kern(1)
        self:animSelect(item)
    else
        item:stop()
        self:animSelect(item)
        item:animate(function(o) zMenuTools:animate_UI(0.3,
            function(p)
                o:set_font_size(math.lerp(o:font_size(),22,p))
                o:set_y(math.lerp(o:y(),3,p))
                o:set_color(self:animateColors3(o:color(),Color(0.2,0.6,1),p))
            end)
        end)
    end
    self:setPointerImg(self.mouse_icons.pointer)
    self.currentActiveTab = tab_id
    self.currentTabHover = nil
    self:buildFeaturePanel()
end
function zMenuClass:checkTabClick()
    for i,v in pairs(self.tab_items) do
        if self:isMouseInPanel(v.panel) and i ~= self.currentActiveTab then
            self:setCurrentActiveTab(i)
            return
        end
    end
end
function zMenuClass:adjustScrollWhenScaling(new_y)
    local panel = self.tab_scroll_panel
    if self.tab_scroll_target < 0 and self.tab_scroll_target + panel:h() < panel:parent():h() then
        panel:move(0,new_y)
        self.tab_scroll_target = self.tab_scroll_target + new_y
        if self.tab_scroll_target > 0 then
            panel:set_y(0)
            self.tab_scroll_target = 0
        end
    end
end
function zMenuClass:doOverScroll(panel,amount)
    local original_y = self.tab_scroll_target
    panel:stop()
    panel:animate(function(o) zMenuTools:animate_UI(0.1,
        function(p)
            o:set_y(math.lerp(o:y(),original_y+amount,p))
            self:checkTabHover()
        end)
        panel:animate(function(o) zMenuTools:animate_UI(0.1,
            function(p)
                o:set_y(math.lerp(o:y(),original_y,p))
                self:checkTabHover()
            end)
        end)
    end)
end
function zMenuClass:doTabScroll(amount)
    local panel = self.tab_scroll_panel
    if panel:h() < panel:parent():h() then
        return
    end
    if self.tab_scroll_target + amount > 0 then
        if self.tab_scroll_target == 0 then
            self:doOverScroll(panel,amount)
            return
        end
        self.tab_scroll_target = 0
        amount = 0
    end
    if (self.tab_scroll_target + panel:h()) + amount < panel:parent():h() then
        if self.tab_scroll_target + panel:h() == panel:parent():h() then
            self:doOverScroll(panel,amount)
            return
        end
        amount = panel:parent():h() - (self.tab_scroll_target + panel:h())
    end 
    self.tab_scroll_target = self.tab_scroll_target + amount
    panel:stop()
    panel:animate(function(o) zMenuTools:animate_UI(0.1,
        function(p)
            o:set_y(math.lerp(o:y(),self.tab_scroll_target,p))
            self:checkTabHover()
        end)
    end)
end
function zMenuClass:initTabs()
    local parent_panel = self.left_side_panel:panel({valign = "grow",x = 4,y = 4,w = self.left_side_panel:w()-8,h = self.left_side_panel:h()-8})
    self.tab_scroll_panel = parent_panel:panel({h = 2000})
    local tabs = self.raw_menu_layout.tab_list
    self.tab_items = {}
    local sum_of_h = 0
    local last_id = ""
    local last_h = 0
    for i,v in pairs(tabs) do
        local item_type = v.type
        local type_h = self.height_data[item_type] or 0
        if item_type == "button" then
            self:createTabButton(self.tab_scroll_panel,sum_of_h,v,type_h)
            sum_of_h = sum_of_h + type_h
        elseif item_type == "divider" then
            self:createTabDivider(self.tab_scroll_panel,sum_of_h,type_h)
            sum_of_h = sum_of_h + type_h
        elseif item_type == "empty_space" then
            type_h = v.height
            sum_of_h = sum_of_h + type_h
        end
        if v.menu_id then
            last_id = v.menu_id
            last_h = type_h
        end
    end
    self.tab_scroll_panel:set_h(self.tab_items[last_id].panel:y() + last_h)
    self.tab_scroll_target = 0
end