
function SWEP:Reload()
	if self:GetFireDelay() > CurTime() then return end
	if self:GetFireRecoveryDelay() > CurTime() then return end
	if self:GetReloadDelay() > CurTime() then return end
	if SERVER and self.Stats["Magazines"]["Amount reloaded"] <= 0 then self:GetOwner():DropWeapon(self) return end
	if math.min( self:Ammo1(), self.Stats["Magazines"]["Maximum loaded"] - self:Clip1() ) <= 0 then return end

	return self:StartReload()
end

function SWEP:StartReload()
	if self:GetReloadingState() then return end

	local selanim = nil
	if self.qa["reload_enter"] then
		selanim = self.qa["reload_enter"]
	elseif self:Clip1() == 0 and self.qa["reload_empty"] then
		selanim = self.qa["reload_empty"]
	elseif self.qa["reload_full"] then
		selanim = self.qa["reload_full"]
	elseif self.qa["reload"] then
		selanim = self.qa["reload"]
	else
		return
	end

	local playa = self:SendAnim( selanim )
	if playa then
		self:SetReloadDelay( CurTime() + playa[1] )
	else
		self:SetReloadDelay( CurTime() + self:GetVM():SequenceDuration() )
	end

	self:SetReloadingState(true)
	self:SetBurstCount(0)

	if !self.Stats["Magazines"]["Don't unload"] then
		self:GetOwner():SetAmmo( self:Ammo1() + self:Clip1(), self:GetPrimaryAmmoType() )
		self:SetClip1( 0 )
	end
end

function SWEP:InsertReload()
	if self.qa["reload_insert"] then
		local playa = self:SendAnim(self.qa["reload_insert"])
		self:SetReloadDelay( CurTime() + playa[1] )
	end
end

function SWEP:FinishReload()
	if self.qa["reload_exit"] then
		local playa = self:SendAnim(self.qa["reload_exit"])
		self:SetReloadDelay( CurTime() + playa[1] )
	end
	self:SetReloadingState(false)
end

function SWEP:Load()
	local thing = math.min( self:Ammo1(), self.Stats["Magazines"]["Amount reloaded"], self.Stats["Magazines"]["Maximum loaded"] - self:Clip1() )
	self:GetOwner():SetAmmo( self:Ammo1() - thing, self:GetPrimaryAmmoType() )
	self:SetClip1( self:Clip1() + thing )
end