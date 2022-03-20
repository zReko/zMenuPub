function zMenuClass:isMouseInPanel(panel)
    return panel:inside(self.menu_mouse_x,self.menu_mouse_y)
end
function zMenuClass:convertMousePos(x,y)
    local x_new, y_new = managers.mouse_pointer:convert_fullscreen_16_9_mouse_pos(x, y)
    return math.floor(x_new*self.mouse_convert_mul),math.floor(y_new*self.mouse_convert_mul)
end
function zMenuClass:mouse_move(o,x,y)
    x,y = self:convertMousePos(x,y)
    self.menu_mouse_x,self.menu_mouse_y = x,y
    if self.mouse_move_panel_state then
        self:updateMenuPos(x,y)
        return
    end
    if self.mouse_resize_panel_state then
        self:updateMenuSize(x,y)
        return
    end
end