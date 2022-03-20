function zMenuClass:updateMenuPos(x,y)
    self:setPointerImg(self.mouse_icons.hold)
    local start_pos = self.mouse_move_panel_state
    self.menu_master_panel:set_position(x-start_pos[1],y-start_pos[2])
end
function zMenuClass:updateMenuSize(x,y)
    self:setPointerImg(self.mouse_icons.hold)
    local new_x = self.last_update_x and (x - self.last_update_x) or 0 
    local new_y = self.last_update_y and (y - self.last_update_y) or 0 
    local should_update_x = true
    local should_update_y = true
    if (self.menu_master_panel:w() <= 300) and new_x < 0 then
        should_update_x = false
        new_x = 0
    end
    if self.menu_master_panel:h() <= 300 and new_y < 0 then
        should_update_y = false
        new_y = 0
    end
    local mul = self.pattern_scale_mul
    self.menu_master_panel:grow(new_x,new_y)
    self.feature_panel:grow(new_x,new_y)
    self.feature_panel:remove(self.feature_panel:child("background_texture"))
    self.feature_panel:bitmap({name = "background_texture",texture = "guis/textures/background_pattern",texture_rect = {0,0,(self.feature_panel:w()-8)/mul,(self.feature_panel:h()-8)/mul},x = 4,y = 4,w = self.feature_panel:w() - 8,h = self.feature_panel:h() - 8,layer = 1})
    self.left_side_panel:grow(0,new_y)
    self.left_side_panel:remove(self.left_side_panel:child("background_texture"))
    self.left_side_panel:bitmap({name = "background_texture",texture = "guis/textures/background_pattern",texture_rect = {0,0,(self.left_side_panel:w()-8)/mul,(self.left_side_panel:h()-8)/mul},x = 4,y = 4,w = self.left_side_panel:w() - 8,h = self.left_side_panel:h() - 8,layer = 1})
    self.profile_pic:set_y(self.menu_master_panel:h()-95)
    self.master_panel_mouse_resize_panel:set_position(self.menu_master_panel:w()-18,self.menu_master_panel:h()-18)
    if should_update_x then
        self.last_update_x = x
    end
    if should_update_y then
        self.last_update_y = y
    end
end