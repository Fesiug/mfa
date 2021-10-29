
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


local col_a = Color(255, 255, 255, 255)
local col_s = Color(0, 0, 0, 127)
local s_dist = 2
local shad = 4
local len, wid = 3, 2

function SWEP:DoDrawCrosshair()
	local w = self
	local p = w:GetOwner()
	local x2, y2 = ScrW()/2, ScrH()/2
	local x, y = x2, y2

	local ss = ScreenScale(5)
	local gap = ss*1

	local spread = self.Stats["Bullet"]["Spread"]
	if istable(spread) then
		spread = Lerp( self:GetAccelInaccuracy(), spread.min, spread.max )
	end
	spread = spread * 0.5
	gap = ss*spread

	cam.Start3D()
		local lool = ( EyePos() + ( EyeAngles() + Angle(spread, 0, 0) ):Forward() ):ToScreen()
	cam.End3D()
	gap = (ScrH()/2) - lool.y

	surface.SetDrawColor(col_s)
	for i=1, 2 do
		if i == 2 then
			surface.SetDrawColor(col_a)
			x, y = x2, y2
		else
			x, y = x+s_dist, y+s_dist
		end
		-- right
		surface.DrawRect(x + gap, y - (wid/2), len, wid)

		-- left
		surface.DrawRect(x - gap - len, y - (wid/2), len, wid)

		-- top
		surface.DrawRect(x - (wid/2), y + gap, wid, len)

		-- bottom
		surface.DrawRect(x - (wid/2), y - gap - len, wid, len)

		-- cent
		surface.DrawRect(x - (wid/2), y - (wid/2), wid, wid)
	end

	return true
end