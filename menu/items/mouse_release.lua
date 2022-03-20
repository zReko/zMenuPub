function zMenuClass:mouse_release(o,button,x,y)
    x,y = self:convertMousePos(x,y)
    self.menu_mouse_x,self.menu_mouse_y = x,y
    if button == Idstring("0")  then --LEFT CLICK
        if self.mouse_resize_panel_state then
            self:saveMenuTransformData()
            self.mouse_resize_panel_state = nil
        end
        self.last_update_y = nil
        self.last_update_x = nil
        if self:isMouseInPanel(self.master_panel_mouse_resize_panel) then
            self:setPointerImg(self.mouse_icons.hand)
        end
        return
    elseif button == Idstring("1") then --RIGHT CLICK
        if self.mouse_move_panel_state then
            self:saveMenuTransformData()
            self.mouse_move_panel_state = nil
        end
        self:setPointerImg(self.mouse_icons.arrow)
        return
    elseif button == Idstring("2") then --MIDDLE CLICK
    elseif button == Idstring("mouse wheel up") then
    elseif button == Idstring("mouse wheel down") then
    end
end