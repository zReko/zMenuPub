function zMenuClass:mouse_press(o,button,x,y)
    x,y = self:convertMousePos(x,y)
    self.menu_mouse_x,self.menu_mouse_y = x,y
    if button == Idstring("0")  then --LEFT CLICK
    elseif button == Idstring("1") then --RIGHT CLICK
        if self:isMouseInPanel(self.menu_master_panel) then
            self.mouse_move_panel_state = {x-self.menu_master_panel:world_x(),y-self.menu_master_panel:world_y()}
            self:updateMenuPos(x,y)
        end
    elseif button == Idstring("2") then --MIDDLE CLICK
    elseif button == Idstring("mouse wheel up") then
    elseif button == Idstring("mouse wheel down") then
    end
end