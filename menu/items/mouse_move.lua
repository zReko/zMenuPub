function zMenuClass:isMouseInPanel(panel)
    return panel:inside(self.menu_mouse_x,self.menu_mouse_y)
end
function zMenuClass:isPanelInPanel(panel1,panel2)
    if panel1:x()>panel2:x() and panel1:y() > panel2:y() then
        if panel1:x()+panel1:w()<panel2:x()+panel2:w() and anel1:y()+panel1:h()<panel2:y()+panel2:h() then
            return true
        end
    end
    return false
end
function zMenuClass:convertMousePos(x,y)
    local x_new, y_new = managers.mouse_pointer:convert_fullscreen_16_9_mouse_pos(x, y)
    return math.floor(x_new*self.mouse_convert_mul),math.floor(y_new*self.mouse_convert_mul)
end
function zMenuClass:setPointerImg(name)
    managers.mouse_pointer:set_pointer_image(name or "arrow")
end
function zMenuClass:saveMenuTransformData()
    local file = io.open(zMenuTools:modPath() .. "menu_data/menu_data.json","w+")
    local data = {x = self.menu_master_panel:x(),y=self.menu_master_panel:y(),w = self.menu_master_panel:w(),h = self.menu_master_panel:h()}
    file:write(json.encode(data))
    file:close()
end
function zMenuClass:unHighlightElement()
    if self.currentPanelHover then
        local rect_item = self.currentPanelHover
        rect_item:stop()
        rect_item:animate(function(o) zMenuTools:animate_UI(5,
            function(p)
                o:set_alpha(math.lerp(o:alpha(),0,p))
            end)
            o:set_alpha(0)
            o:parent():remove(o)
        end)
        self.currentPanelHover = nil
    end
end
function zMenuClass:highlightElement(mouse_check_panel,size,color)
    size = size or {}
    self:unHighlightElement()
    if not self.currentPanelHover then
        local rect_item = mouse_check_panel:rect({x = size.x or 0,y = size.y or 0,w = mouse_check_panel:w()-(size.w or 0),h = mouse_check_panel:h()-(size.h or 0),layer = 100,Color = color or Color(1,1,1),alpha = 0})
        rect_item:stop()
        rect_item:animate(function(o) zMenuTools:animate_UI(0.2,
            function(p)
                o:set_alpha(math.lerp(o:alpha(),0.15,p))
            end)
        end)
        self.currentPanelHover = rect_item
    end
end
function zMenuClass:mouse_move(o,x,y)
    x,y = self:convertMousePos(x,y)
    self.menu_mouse_x,self.menu_mouse_y = x,y
    if not self:isMouseInPanel(self.menu_master_panel) then
        self:setPointerImg(self.mouse_icons.arrow)
    end
    if self:isMouseInPanel(self.master_panel_mouse_resize_panel) then
        self:setPointerImg(self.mouse_icons.hand)
    end
    if self.mouse_move_panel_state then
        self:updateMenuPos(x,y)
        return
    end
    if self.mouse_resize_panel_state then
        self:updateMenuSize(x,y)
        return
    end
    self:checkTabHover()
end