function zMenuClass:createTabDivider(parent,height,hh)
    local item_panel = parent:panel({y = height,h = hh,layer = 50})
    item_panel:rect({x = item_panel:x() + 5,w = item_panel:w() - 10,h = 4,alpha = 1,layer = 50,color = self:rgb255(10,10,10)})
    item_panel:rect({x = item_panel:x() + 6,y = 1,w = item_panel:w() - 12,h = 2,alpha = 1,layer = 50,color = self:rgb255(60,60,60)})
end
function zMenuClass:createTabButton(parent,height,item,hh)
    local item_panel = parent:panel({y = height,h = hh,layer = 50})
    local text = item_panel:text({name = item.menu_id,text = string.upper(item.text), font_size = 16,y = 7,align = "center",font =  "fonts/font_small_mf",color = self:rgb255(255,255,255),layer = 51})
    self.tab_items[item.menu_id] = {panel = item_panel,menu_id = item.menu_id,button_text = text}
end
function zMenuClass:checkTabHover()
    if not self:isMouseInPanel(self.left_side_panel) then
        return
    end
    if self.current_tab_hover then
        local item = self.tab_items[self.current_tab_hover]
        if not self:isMouseInPanel(item.panel) then
            local panel = item.button_text
            panel:stop()
            panel:animate(function(o) zMenuTools:animate_UI(0.2,
                function(p)
                    o:set_font_size(math.lerp(o:font_size(),16,p))
                    o:set_y(math.lerp(o:y(),7,p))
                end)
            end)
            self.current_tab_hover = nil
        end
        return
    end
    for i,v in pairs(self.tab_items) do
        if self:isMouseInPanel(v.panel) then
            self.current_tab_hover = i
            v.button_text:stop()
            v.button_text:animate(function(o) zMenuTools:animate_UI(0.05,
                function(p)
                    o:set_font_size(math.lerp(o:font_size(),20,p))
                    o:set_y(math.lerp(o:y(),5,p))
                end)
            end)
            return
        end
    end
end
function zMenuClass:initTabs()
    local parent_panel = self.left_side_panel:panel({valign = "grow",halign = "grow",x = 4,y = 4,w = self.left_side_panel:w()-8,h = self.left_side_panel:h()-8})
    local tabs = self.raw_menu_layout.tab_list
    self.tab_items = {}
    local sum_of_h = 0
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
    end
end