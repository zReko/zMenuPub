function zMenuClass:updateMenuPos(x,y)
    local start_pos = self.mouse_move_panel_state
    self.menu_master_panel:set_position(x-start_pos[1],y-start_pos[2])
end