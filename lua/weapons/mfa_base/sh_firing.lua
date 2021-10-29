

function SWEP:CanPrimaryAttack()
	if CurTime() < self:GetFireDelay() then
		return false
	end

	if CurTime() < self:GetReloadDelay() then
		return false
	end

	if CurTime() < self:GetHolster_Time() then
		return false
	end

	if self:Clip1() < self.Stats["Function"]["Ammo required"] then
		return false
	end

	if self.Stats["Function"]["Shots fired maximum"].max > 0 and self:GetBurstCount() >= self.Stats["Function"]["Shots fired maximum"].max then
		return false
	end

	return true
end

function SWEP:PrimaryAttack(forced)
	local p = self:GetOwner()
	if self:GetFireDelay() > CurTime() then return false end
	if !forced and self:GetFireRecoveryDelay() > CurTime() then return false end
	if self:GetReloadDelay() > CurTime() then return false end
	
	if self.Stats["Function"]["Ammo required"] > self:Clip1() then
		self:EmitSound( self.Stats["Appearance"]["Sounds"]["Dry"] )
		self:SetFireDelay( CurTime() + 0.2 )
		return false
	end

	if self.Stats["Function"]["Shots fired maximum"].max != 0 and
		self:GetBurstCount() >= self.Stats["Function"]["Shots fired maximum"].max then
		return false
	end

	-- Play shoot sound
	self:EmitSound( self.Stats["Appearance"]["Sounds"]["Fire"] )
	self:ShootBullet()

	local time = self.Stats["Function"]["Fire delay"]
	if istable(time) then
		time = Lerp( self:GetAccelFirerate(), time.min, time.max )
	end

	self:SetFireDelay( CurTime() + time )
	self:SetFireRecoveryDelay( CurTime() + self.Stats["Function"]["Fire recovery delay"] )
	self:SetBurstCount( self:GetBurstCount() + 1 )

	if self.qa["fire"] then self:SendAnim( self.qa["fire"] ) end

	self:SetClip1( math.max( self:Clip1() - self.Stats["Function"]["Ammo used"], 0) )
end

function SWEP:SecondaryAttack()
	return true
end

function SWEP:ShootBullet()
	for i=1, self.Stats["Bullet"]["Count"] do
		local devi = Angle(0, 0, 0)

		local rnd = util.SharedRandom(CurTime()/11, 0, 360, i)
		local rnd2 = util.SharedRandom(CurTime()/22, 0, 1, i*2)

		local spread = self.Stats["Bullet"]["Spread"]
		if istable(spread) then
			spread = Lerp( self:GetAccelInaccuracy(), spread.min, spread.max )
		end
		spread = spread * 0.5
		local deviat = Angle( math.cos(rnd), math.sin(rnd), 0 ) * ( rnd2 * spread )
		
		local bullet = {}
		bullet.Num		= 1
		bullet.Attacker = self:GetOwner()
		bullet.Src		= self:GetOwner():GetShootPos()
		bullet.Dir		= ( self:GetOwner():EyeAngles() + deviat ):Forward()
		bullet.Spread	= vector_origin
		bullet.Tracer	= 0
		bullet.Force	= self.Stats["Bullet"]["Force"] or 1
		bullet.Damage	= 0
		bullet.AmmoType = self.Primary.Ammo
		bullet.Callback = function( atk, tr, dmg )
			local ent = tr.Entity

			dmg:SetDamage( self.Stats["Bullet"]["Damage"].max )
			dmg:SetDamageType(DMG_BULLET)

			-- ArcCW
			if IsValid(ent) then
				local d = dmg:GetDamage()
				local min, max = self.Stats["Bullet"]["Range"].min, self.Stats["Bullet"]["Range"].max
				local range = atk:GetPos():Distance(ent:GetPos())
				local XD = 0
				if range < min then
					XD = 0
				else
					XD = math.Clamp((range - min) / (max - min), 0, 1)
				end

				dmg:SetDamage( Lerp(XD, self.Stats["Bullet"]["Damage"].max, self.Stats["Bullet"]["Damage"].min) )

				if CLIENT and IsValid(dmg:GetAttacker()) and dmg:GetAttacker():IsPlayer() then
					if false then--if GetConVar("osii_debug_dmgrange"):GetBool() then
						dmg:GetAttacker():ChatPrint( 100-math.Round(XD*100) .. "% range, " .. math.Round(dmg:GetDamage()) .. " dmg" )
					end
				end
			end
		end

		self:FireBullets( bullet )
	end
end