
function SWEP:Think()
	local p = self:GetOwner()

	do
		-- Accels
		local doo = ( self:GetFireDelay() >= ( CurTime() - engine.TickInterval() ) )-- or ( self:GetFireRecoveryDelay() >= ( CurTime() - engine.TickInterval() ) )
		local inaccrange = self.Stats["Bullet"]["Spread acceleration time"]
		if inaccrange then
			self:SetAccelInaccuracy( math.Approach( self:GetAccelInaccuracy(), ( doo and 1 or 0 ), FrameTime() / ( doo and inaccrange.min or inaccrange.max ) ) )
		end

		do -- Burst features
			local maa = self.Stats["Function"]["Shots fired maximum"]
			if self:GetBurstCount() != 0 and maa.max != 0 and self:GetBurstCount() < maa.max then
				if self:Clip1() <= 0 then
					self:SetBurstCount(0)
				else
					self:PrimaryAttack(true)
				end
			end

			if self:GetBurstCount() >= self.Stats["Function"]["Shots fired maximum"].min and !p:KeyDown(IN_ATTACK) then
				self:SetBurstCount( 0 )
			end
		end
		
		-- Events
		for i, v in ipairs(self.EventTable) do
			for ed, bz in pairs(v) do
				if ed <= CurTime() then
					self:PlayEvent(bz)
					self.EventTable[i][ed] = nil
					if table.IsEmpty(v) and i != 1 then self.EventTable[i] = nil end
				end
			end
		end

		do -- Reloading
			if self:GetReloadLoadDelay() != 0 and self:GetReloadLoadDelay() <= CurTime() then
				self:SetReloadLoadDelay(0)
				self:Load()
			end
				
			if self:GetReloadingState() and self:Clip1() > 0 and ( p:KeyDown(IN_ATTACK) or p:KeyDown(IN_ATTACK2) ) then
				self:FinishReload()
			end

			if self:GetReloadingState() and self:GetReloadDelay() < CurTime() then
				if self.qa["reload_insert"] and self:Clip1() < self.Stats["Magazines"]["Maximum loaded"] and self:Ammo1() > 0 then
					self:InsertReload()
				else
					self:FinishReload()
				end
			end
		end
		
		-- ADS
		local canzoom = self:GetOwner():KeyDown(IN_ATTACK2) and !( self:GetReloadDelay() > CurTime() )
		self:SetADSDelta( math.Approach( self:GetADSDelta(), ( canzoom and 1 or 0 ), FrameTime() / ( self.Stats["ADS"] and self.Stats["ADS"]["Time"] or 0.3 ) ) )

		-- Idles
		if self:GetNextIdle() <= CurTime() then
			if self:GetOverheated() and self.qa["idle_oh"] then
				self:SendAnim(self.qa["idle_oh"])
			elseif self.qa["idle"] then
				self:SendAnim(self.qa["idle"])
			end
		end
	end
end