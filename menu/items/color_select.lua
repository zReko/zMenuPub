function zMenuClass:get_rgb_from_hsv(hue,saturation,value)
	local chroma = value * saturation
	local red,green,blue
	if not hue or (hue <= 0) then 
		return 0,0,0
	else
		local hue = math.clamp(hue,0,360) / 60
		local num = chroma * (1 - math.abs((hue % 2) - 1))
		if 0 <= hue and hue <= 1 then 
			red = chroma
			green = num
			blue = 0
		elseif 1 <= hue and hue <= 2 then 
			red = num
			green = chroma
			blue = 0
		elseif 2 <= hue and hue <= 3 then 
			red = 0
			green = chroma
			blue = num
		elseif 3 <= hue and hue <= 4 then 
			red = 0
			green = num
			blue = chroma
		elseif 4 <= hue and hue <= 5 then 
			red = num
			green = 0
			blue = chroma
		elseif 5 <= hue and hue <= 6 then 
			red = chroma
			green = 0
			blue = num
		else
			red = 0
			green = 0
			blue = 0
		end
	end
	local diff = value - chroma
	red = red + diff
	green = green + diff
	blue = blue + diff
	return red,green,blue
end
function zMenuClass:animateColors4(cur_color,target_color,p)
    local color_current = {cur_color:color():unpack()}
    local target_color = {target_color:color():unpack()}
    return Color(math.lerp(color_current[1],target_color[1],p),math.lerp(color_current[2],target_color[2],p),math.lerp(color_current[3],target_color[3],p),math.lerp(color_current[3],target_color[3],p))
end
function zMenuClass:animateColors3(cur_color,target_color,p)
    local color_current = {cur_color:unpack()}
    local target_color = {target_color:unpack()}
    return Color(math.lerp(color_current[1],target_color[1],p),math.lerp(color_current[2],target_color[2],p),math.lerp(color_current[3],target_color[3],p))
end