if zMenu:isMenuopen() then
    zMenu:closeMenu()
    return
end
zMenu:openMenu()
--local text = params.text or ""
--local text_color = params.text_color or Color(1,1,1,1)
--local time = params.time or 5
--local highlight_message = params.highlight_msg or nil
--local highlight_message_color = params.highlight_msg_color or Color(1,1,1,1)
--local rgb_enabled = params.rgb_enabled or false
--local rgb_speed = params.rgb_speed or 1
--local icon = params.icon or nil
--local icon_color = params.icon_color or nil

zMenu:showNotification({
    text = "Random ASS FUCKING TEXT \nAYY lmao",
    text_color = Color(0.2,0.2,1),
    time = 5,
    highlight_message = "FUCKING TEXT",
    highlight_message_color = Color(0,1,0),
    icon = zMenu.icons.alert,
    icon_color = Color(0,0.5,1)
})