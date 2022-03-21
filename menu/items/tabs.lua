function zMenuClass:createTabDivider(parent,height)
    local item_panel = parent:panel({y = height,h = 4,layer = 50})
    item_panel:rect({x = item_panel:x() + 5, w = item_panel:w() - 11, h = 4,alpha = 1,layer = 105, color = self:rgb255(10,10,10)})
    item_panel:rect({x = item_panel:x() + 6,y = 1, w = item_panel:w() - 13, h = 2,alpha = 1,layer = 105, color = self:rgb255(60,60,60)})
end
function zMenuClass:createTabButton(parent,height,item)
    local item_panel = parent:panel({x = 1,y = height,h = 30,layer = 50})
    item_panel:text({name = item.menu_id,text = string.upper(item.text), font_size = 15,y = 6,align = "center", font =  "fonts/font_small_mf",color = self:rgb255(255,255,255),layer = 51})
    self.tab_items[item.menu_id] = {panel = item_panel,menu_id = item.menu_id}

end

function zMenuClass:initTabs()
    local parent_panel = self.left_side_panel:panel({valign = "grow",halign = "grow",x = 4,y = 4,w = self.left_side_panel:w()-8,h = self.left_side_panel:h()-8})
    local tabs = self.raw_menu_layout.tab_list
    self.tab_items = {}
    local sum_of_h = 0
    for i,v in pairs(tabs) do
        local item_type = v.type
        local height = self.height_data[item_type]
        if item_type == "button" then
            self:createTabButton(parent_panel,sum_of_h,v)
            sum_of_h = sum_of_h + height
        elseif item_type == "divider" then
            self:createTabDivider(parent_panel,sum_of_h)
            sum_of_h = sum_of_h + height
        end
    end
    
    


















    --local sum_of_h = 50
    --for i, v in pairs(data)do
    --    local item_panel = nil
    --    if not self.config_state["hide_cheat_features"] or not v.is_cheat then
    --        if v.type == "button" then
    --            item_panel = left_main_panel:panel({x = 1,y = sum_of_h,h = 30})
    --            item_panel:text({name = v.menu_id,text = string.upper(v.text), font_size = 15,y = 6,align = "center", font =  "fonts/font_small_mf",color = self:rgb255(255,255,255),layer = 51})
    --            item_panel:gradient({name = v.menu_id .. "gradient",blend_mode = "normal", orientation = "horizontal",w = 0,y = 2,h = 26,gradient_points = {0, self:rgb255(100,120,150,255), 1, self:rgb255(0,120,150,255)}})
    --            item_panel:rect({name = v.menu_id .. "line1",y = item_panel:h() - 3,w = 0,h = 1,layer = 105, color = self:rgb255(120,150,255)})
    --            item_panel:rect({name = v.menu_id .. "line2",y = 2,w = 0,h = 1,layer = 105, color = self:rgb255(120,150,255)})
    --            item_panel:rect({name = v.menu_id .. "line3",y = 2,w = 1,h = 26,layer = 105, color = self:rgb255(120,150,255),alpha = 0})
    --            item_panel:rect({name = v.menu_id .. "line4",x = item_panel:w()-3,y = 2,w = 1,h = 26,layer = 105, color = self:rgb255(120,150,255),alpha = 0})
    --            sum_of_h = sum_of_h + 30
    --            --self:debug_panel_outline(item_panel)
    --            self.left_panel_items[v.menu_id] = {panel = item_panel,menu_id = v.menu_id,states = v.states}
    --        elseif v.type == "divider" then
    --            item_panel = left_main_panel:panel({y = sum_of_h,h = 4})
    --            item_panel:rect({x = item_panel:x() + 5, w = item_panel:w() - 11, h = 4,alpha = 1,layer = 105, color = self:rgb255(10,10,10)})
    --            item_panel:rect({x = item_panel:x() + 6,y = 1, w = item_panel:w() - 13, h = 2,alpha = 1,layer = 105, color = self:rgb255(60,60,60)})
    --            sum_of_h = sum_of_h + 4
    --        elseif v.type == "divider2" then
    --            item_panel = left_main_panel:panel({y = sum_of_h,h = 4})
    --            item_panel:rect({x = item_panel:x(), w = item_panel:w(), h = 4,alpha = 1,layer = 105, color = self:rgb255(10,10,10)})
    --            item_panel:rect({x = item_panel:x(),y = 1, w = item_panel:w(), h = 2,alpha = 1,layer = 105, color = self:rgb255(60,60,60)})
    --            sum_of_h = sum_of_h + 4
    --        end
    --    end
    --end




end