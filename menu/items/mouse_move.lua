function zMenuClass:isMouseInPanel(panel)
    return panel:inside(self.menu_mouse_x,self.menu_mouse_y)
end
function zRekoMenuClass:convertMousePos(x,y)
    local x_new, y_new = managers.mouse_pointer:convert_fullscreen_16_9_mouse_pos(x, y)
    return math.floor(x_new*self.mouse_convert_mul),math.floor(y_new*self.mouse_convert_mul)
end
function zMenuClass:mouse_move(o,x,y)
    self.menu_mouse_x,self.menu_mouse_y = self:convertMousePos(x,y)
end