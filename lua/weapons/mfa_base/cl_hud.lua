
function SWEP:DoDrawCrosshair(x, y)
	local ss = ScreenScale(1)

	surface.SetDrawColor(color_black)
	surface.DrawLine(x - (ss*2) + 1, y + 1, x + (ss*2) + 1, y + 1)
	surface.DrawLine(x + 1, y - (ss*2) + 1, x + 1, y + (ss*2) + 1)
	
	surface.SetDrawColor(color_white)
	surface.DrawLine(x - (ss*2), y, x + (ss*2), y)
	surface.DrawLine(x, y - (ss*2), x, y + (ss*2))
	return true
end
