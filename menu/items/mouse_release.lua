function zMenuClass:mouse_release(o,button,x,y)
    x,y = self:convertMousePos(x,y)
    self.menu_mouse_x,self.menu_mouse_y = x,y
    if button == Idstring("0")  then --LEFT CLICK
    elseif button == Idstring("1") then --RIGHT CLICK
        self.mouse_move_panel_state = nil
    elseif button == Idstring("2") then --MIDDLE CLICK
    elseif button == Idstring("mouse wheel up") then
    elseif button == Idstring("mouse wheel down") then
    end
end