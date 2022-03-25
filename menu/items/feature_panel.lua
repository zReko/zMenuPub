function zMenuClass:removePreviousFeaturePanel()
    if not self.active_feature_panels or #self.active_feature_panels == 0 then
        return
    end
    for i, v in pairs(self.active_feature_panels) do
        v:stop()
        v:animate(function(o) zMenuTools:animate_UI(1,
            function(p)
                o:set_y(math.lerp(o:y(),-750,p))
                o:set_alpha(math.lerp(o:alpha(),0,p))
            end)
            v:parent():remove(v)
        end)
    end
end

function zMenuClass:buildFeaturePanel()
    self:removePreviousFeaturePanel()
    local data = self.raw_menu_layout.main_features[self.currentActiveTab] or {}
    self.num_of_cols = #data
    self.active_feature_panels = {}
    local pan_width = (self.feature_panel_main:w()-(5*(self.num_of_cols-1))) / self.num_of_cols
    local px,py,pw,ph = self.feature_panel_main:shape()
    --self:debug_panel_outline(self.feature_panel_main)
    for i, v in pairs(data) do
        local column_panel = self.feature_panel_main:panel({y = 0,halign = "grow",x = (5*(i-1))+(pan_width*(i-1)), w = pan_width})
        local total_h = 0
        for ii = 1, 20, 1 do
            local ass = column_panel:panel({halign = "grow",y=((ii-1)*25),h = 25})
            self:make_box(ass,true,true)
            ass:text({halign = "grow",x = 5,text = "test",y = 3, font_size = 16,align = "left",font = "fonts/font_small_mf",color = Color(0.3,0.3,0.3),layer = 51})
            ass:text({halign = "grow",text = "123",y = 3, font_size = 16,align = "center",font = "fonts/font_small_mf",color = Color(0.7,0.7,0.7),layer = 51})
            ass:text({halign = "grow",x = -5,text = "test",y = 3, font_size = 16,align = "right",font = "fonts/font_small_mf",color = Color(1,1,1),layer = 51})
            total_h = total_h + 25
        end
        column_panel:set_y(-total_h*2)
        column_panel:set_h(total_h)
        column_panel:animate(function(o) zMenuTools:animate_UI(2,
            function(p)
                o:set_y(math.lerp(o:y(),0,p))
                o:set_alpha(math.lerp(o:alpha(),1,p))
            end)
        end)
        --self:debug_panel_outline(column_panel)
        table.insert(self.active_feature_panels,column_panel)
    end
end