
function SWEP:Deploy()
	if self.Stats["Appearance"] and self.Stats["Appearance"]["Holdtype"] then
		self:SetHoldType( self.Stats["Appearance"]["Holdtype"] or "pistol" )
	else
		self:SetHoldType( "pistol" )
	end
	self:SetADSDelta(0)
	self:SetReloadDelay(CurTime())

	local playa = self:SendAnim( self.qa["draw"] )
	if playa then
		self:SetReloadDelay( CurTime() + playa[1] )
	end

	return true
end

function SWEP:Holster(wep)
	if wep == self then return false end
	if self:GetHolster_Time() > CurTime() then self:SetHolster_Entity(wep) return false end

	if !self.qa["holster"] or (self:GetHolster_Time() != 0 and self:GetHolster_Time() <= CurTime()) or !IsValid(wep) then
		self:SetHolster_Time(0)
		self:SetHolster_Entity(NULL)

		return true
	else
		self:SetHolster_Entity(wep)

		local at = self:SendAnim( self.qa["holster"] )
		self:SetHolster_Time( CurTime() + at[1] )
		self:SetReloadLoadDelay(0)
		self:SetReloadingState( false )
		self:SetBurstCount(0)
		self:SetNextIdle(math.huge)
	end
end

hook.Add("StartCommand", "MFA_StartCommand", function( ply, cmd )
	local wep = ply:GetActiveWeapon()
	if IsValid(wep) and wep.MFA then
		if wep:GetHolster_Time() != 0 and wep:GetHolster_Time() <= CurTime() then
			if IsValid(wep:GetHolster_Entity()) then
				wep:SetHolster_Time(-math.huge)
				cmd:SelectWeapon(wep:GetHolster_Entity())
			end
		end
	end
end)