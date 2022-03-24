function zMenuClass:removePreviousFeaturePanel()
end
function zMenuClass:buildFeaturePanel()
    --self:removePreviousFeaturePanel()
    self.feature_panel_main:clear()
    local data = self.raw_menu_layout.main_features[self.currentActiveTab] or {}
    self.num_of_cols = #data
    self.active_feature_panels = {}
    local px,py,pw,ph = self.feature_panel_main:shape()
    for i, v in pairs(data) do
        local column_panel = self.feature_panel_main:panel({halign = "grow",x = (i-1)*(pw/self.num_of_cols),y = 0, w = pw/self.num_of_cols})
        column_panel:text({halign = "grow",valign = "grow",text = "test", font_size = 16,align = "left",font =  "fonts/font_small_mf",color = Color(0.7,0.7,0.7),layer = 51})
        column_panel:text({halign = "grow",valign = "grow",text = "test", font_size = 16,align = "right",font =  "fonts/font_small_mf",color = Color(0.7,0.7,0.7),layer = 51})
        table.insert(self.active_feature_panels,column_panel)
        self:debug_panel_outline(column_panel)
    end
end