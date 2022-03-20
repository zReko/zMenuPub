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