function zMenuClass:removePreviousFeaturePanel()
end
function zMenuClass:buildFeaturePanel()
    --self:removePreviousFeaturePanel()
    self.feature_panel_main:clear()
    local data = self.raw_menu_layout.main_features[self.currentActiveTab] or {}
    self.num_of_cols = #data
    self.active_feature_panels = {}
    local pan_width = (self.feature_panel_main:w()-(5*(self.num_of_cols+1))) / self.num_of_cols
    local px,py,pw,ph = self.feature_panel_main:shape()
    for i, v in pairs(data) do
        local column_panel = self.feature_panel_main:panel({halign = "grow",x = (5*i)+(pan_width*(i-1)),y = 0, w = pan_width})
        for ii = 1, 5, 1 do
            local ass = column_panel:panel({halign = "grow",y=5 + ((ii-1)*25),h = 25})
            ass:rect({halign = "grow",x = 2,y = 2, h = ass:h()-4, w = ass:w()-4,color = Color(0.2,0.2,0.2),alpha = 0.5})
            ass:rect({halign = "grow",color = Color(1,1,1),alpha = 0.1})
            ass:text({halign = "grow",x = 5,text = "test", font_size = 16,align = "left",font =  "fonts/font_small_mf",color = Color(0.7,0.7,0.7),layer = 51})
            ass:text({halign = "grow",x = -5,text = "test", font_size = 16,align = "right",font =  "fonts/font_small_mf",color = Color(0.7,0.7,0.7),layer = 51})
        end
        table.insert(self.active_feature_panels,column_panel)
        --self:debug_panel_outline(column_panel)
    end
end