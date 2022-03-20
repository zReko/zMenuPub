function zMenuClass:updateMenuPos(x,y)
    local start_pos = self.mouse_move_panel_state
    self.menu_master_panel:set_position(x-start_pos[1],y-start_pos[2])
end
function zMenuClass:updateMenuSize(x,y)
    local new_x = self.last_update_x and (x - self.last_update_x) or 0 
    local new_y = self.last_update_y and (y - self.last_update_y) or 0 
    self.menu_master_panel:grow(new_x,new_y)
    self.feature_panel:grow(new_x,new_y)
    self.left_side_panel:grow(0,new_y)
    self.profile_pic:set_y(self.menu_master_panel:h()-95)
    self.master_panel_mouse_resize_panel:set_position(self.menu_master_panel:w()-18,self.menu_master_panel:h()-18)
    self.last_update_x = x
    self.last_update_y = y
end