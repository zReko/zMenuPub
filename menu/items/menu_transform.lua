function zMenuClass:updateMenuPos(x,y)
    self:setPointerImg(self.mouse_icons.hold)
    local start_pos = self.mouse_move_panel_state
    self.menu_master_panel:set_position(x-start_pos[1],y-start_pos[2])
end
function zMenuClass:doShittyTextFix()
    --ghetto retarded fix
    --text elements that are outside of their parent panels are not visible when initialized but updating them fixes it ¯\_(ツ)_/¯
    self.menu_master_panel:move(-1,0)
    self.menu_master_panel:move(1,0)
end
function zMenuClass:resizeBitmapBox(bitmap)
    local mul = self.pattern_scale_mul
    local parent = bitmap:parent()
    bitmap:set_texture_rect(0,0,(parent:w()-8)/mul,(parent:h()-8)/mul)
end

function zMenuClass:resizeMenu(new_x,new_y)
    self.menu_master_panel:grow(new_x,new_y)
    self.feature_panel:grow(new_x,new_y)
    local pan_width = (self.feature_panel_main:w()-(5*(self.num_of_cols-1))) / self.num_of_cols
    for i, v in pairs(self.active_feature_panels) do
        v:set_x((5*(i-1))+(pan_width*(i-1)))
        v:set_w(pan_width)
    end
    self.left_side_panel:grow(0,new_y)
    for i, v in pairs(self.grow_bitmap_list) do
        if tostring(v) == "[Bitmap NULL]" then
            self.grow_bitmap_list[i] = nil
        else
            self:resizeBitmapBox(v)
        end
    end
    self.profile_pic:set_y(self.menu_master_panel:h()-95)
    self.master_panel_mouse_resize_panel:set_position(self.menu_master_panel:w()-18,self.menu_master_panel:h()-18)
    self:adjustScrollWhenScaling(new_y)
    self:doShittyTextFix()
end
function zMenuClass:updateMenuSize(x,y)
    self:setPointerImg(self.mouse_icons.hold)
    local new_x = self.last_update_x and (x - self.last_update_x) or 0 
    local new_y = self.last_update_y and (y - self.last_update_y) or 0 
    local should_update_x = true
    local should_update_y = true
    if (self.menu_master_panel:w()-math.abs(new_x) < 600) and new_x < 0 then
        new_x = self.menu_master_panel:w()-599
        new_x = -new_x
        if new_x <= 0 then
            self.last_update_x = self.last_update_x - math.abs(new_x)
            should_update_x = false
        end
    end
    if (self.menu_master_panel:h()-math.abs(new_y) < 300) and new_y < 0 then
        new_y = self.menu_master_panel:h()-(300-1)
        new_y = -new_y
        if new_y <= 0 then
            self.last_update_y = self.last_update_y - math.abs(new_y)
            should_update_y = false
        end
    end
    self:resizeMenu(new_x,new_y)
    if should_update_x then
        self.last_update_x = x
    end
    if should_update_y then
        self.last_update_y = y
    end
end