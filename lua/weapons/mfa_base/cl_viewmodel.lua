
SWEP.VMPos_To = Vector()
SWEP.VMAng_To = Angle()
SWEP.MyVel = 0
SWEP.LastFT = 0

function SWEP:GetViewModelPosition(pos, ang)
	local p = LocalPlayer()
	local ps = p:IsSprinting()

	-- cod4 style shit
	do
		local movin = p:KeyDown(IN_FORWARD) or p:KeyDown(IN_BACK) or p:KeyDown(IN_MOVELEFT) or p:KeyDown(IN_MOVERIGHT)
		pos_want = Vector()
		ang_want = Angle()

		if self.LastFT != FrameTime() then self.MyVel = math.Approach(self.MyVel, p:OnGround() and p:GetVelocity():Length2D() or 0, FrameTime()*(p:GetWalkSpeed())*10) end
		
		if !p:OnGround() then
			pos_want = Vector(0, 0, 0.2)
			ang_want = Angle(0, 0, -5)
		elseif ps and movin then
			pos_want = Vector(0.5, 0, -1)
			ang_want = Angle(-5, 5, 0)
		elseif movin then
			pos_want = Vector(-0.25, 0, -0.5)
			ang_want = Angle(0, 0, 0)
		end
		if self.Stats["Appearance"]["VM Offset"] then pos_want:Add( self.Stats["Appearance"]["VM Offset"] ) end

		local blah = (self.MyVel/p:GetWalkSpeed())
		pos_want.x = pos_want.x + math.pow(math.sin(CurTime()*math.pi*1), 2) * 0.5 * blah * (ps and 2 or 1)
		pos_want.z = pos_want.z + math.pow(math.sin(CurTime()*math.pi*2), 2) * 0.125 * blah * (ps and 2 or 1)

		ang_want.x = ang_want.x + math.pow(math.sin(CurTime()*math.pi*2), 2) * 0.75 * blah * (ps and 2 or 1)
		ang_want.y = ang_want.y + math.pow(math.sin(CurTime()*math.pi*1), 2) * -0.5 * blah * (ps and 1 or 1)
		ang_want.z = ang_want.z + math.sin(CurTime()*math.pi*2) * -2 * blah * (ps and -1 or 1)

		-- idle
		pos_want.z = pos_want.z + ( math.sin(CurTime()*math.pi*0.5) * 0 )
		ang_want.x = ang_want.x + ( math.sin(CurTime()*math.pi*1) * -0.25 )
		ang_want.y = ang_want.y + ( math.sin(CurTime()*math.pi*0.5) * 0.2 )

		if self.LastFT != FrameTime() then
			self.VMPos_To = LerpVector(math.min(FrameTime()*4, 1), self.VMPos_To, pos_want)
			self.VMAng_To = LerpAngle(math.min(FrameTime()*4, 1), self.VMAng_To, ang_want)
		end
		self.LastFT = FrameTime()
	end

	local qu = self.VMPos_To
	local qa = self.VMAng_To

	
	pos:Add( ang:Right() * qu.x )
	pos:Add( ang:Forward() * qu.y )
	pos:Add( ang:Up() * qu.z )

	ang:RotateAroundAxis(ang:Right(), qa.x)
	ang:RotateAroundAxis(ang:Forward(), qa.z) -- these are flip cuz
	ang:RotateAroundAxis(ang:Up(), qa.y)

	return pos, ang
end