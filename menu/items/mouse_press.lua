function zMenuClass:mouse_press(o,button,x,y)
    x,y = self:convertMousePos(x,y)
    self.menu_mouse_x,self.menu_mouse_y = x,y
    if button == Idstring("0")  then --LEFT CLICK
        if self:isMouseInPanel(self.master_panel_mouse_resize_panel) then
            self.mouse_resize_panel_state = {x-self.master_panel_mouse_resize_panel:world_x(),y-self.master_panel_mouse_resize_panel:world_y()}
            self:updateMenuSize(x,y)
            return
        end
        if self:isMouseInPanel(self.left_side_panel) then
            self:checkTabClick()
            return
        end
    elseif button == Idstring("1") then --RIGHT CLICK
        if self:isMouseInPanel(self.menu_master_panel) then
            self.mouse_move_panel_state = {x-self.menu_master_panel:world_x(),y-self.menu_master_panel:world_y()}
            self:updateMenuPos(x,y)
            return
        end
    elseif button == Idstring("2") then --MIDDLE CLICK
    elseif button == Idstring("mouse wheel up") then
        if self:isMouseInPanel(self.left_side_panel) then
            self:doTabScroll(20)
            return
        end
    elseif button == Idstring("mouse wheel down") then
        if self:isMouseInPanel(self.left_side_panel) then
            self:doTabScroll(-20)
            return
        end
    end
end