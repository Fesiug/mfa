
-- Animation

function SWEP:GetVM(ind)
	if self:GetOwner():IsPlayer() then
		return self:GetOwner():GetViewModel(ind or 0)
	else
		print("GETVM called on a not-player! Get to it, marine!!", self, self:GetOwner())
	end
end

if SERVER then util.AddNetworkString("MFA_NetworkTP") end
function SWEP:SendAnim(name, ind)
	-- Select a random animation from a table if this one doesn't have any
	if !name.seq then name = name[ math.Round( util.SharedRandom( "Random animation", 1, #name, CurTime() ) ) ] end

	if SERVER and name.tpanim and self:GetOwner():IsPlayer() then 
		net.Start("MFA_NetworkTP")
			net.WriteEntity(self:GetOwner())
			net.WriteUInt(self:GetOwner():SelectWeightedSequence(name.tpanim), 16)
			net.WriteFloat(name.tpanim_starttime or 0)
		net.Broadcast()
	end

	local vm = self:GetVM(ind)
	if !IsValid(vm) then return end
	local anim = vm:LookupSequence( name.seq )
	vm:SendViewModelMatchingSequence(anim)
	vm:SetPlaybackRate(name.rate or 1)
	local dur = vm:SequenceDuration() / ( name.rate or 1 )
	self:SetNextIdle( CurTime() + dur )

	if name.events then self:PlaySoundTable( name.events, 1 / ( name.rate or 1 ) ) end
	if name.time_load then self:SetReloadLoadDelay( CurTime() + name.time_load ) end

	-- Our confirmation letter
	return { dur }
end

if CLIENT then
	net.Receive("MFA_NetworkTP", function()
		local ent = net.ReadEntity()
		local seq = net.ReadUInt(16)
		local starttime = net.ReadFloat()
		--if ent != LocalPlayer() then
			ent:AddVCDSequenceToGestureSlot( GESTURE_SLOT_ATTACK_AND_RELOAD, seq, starttime, true )
		--end
	end)
end

SWEP.EventTable = { [1] = {} }
function SWEP:PlaySoundTable(soundtable, mult)
	local owner = self:GetOwner()

	mult = 1 / (mult or 1)

	for _, v in pairs(soundtable) do
		if table.IsEmpty(v) then continue end

		local ttime
		if v.t then
			ttime = (v.t * mult)
		else
			continue
		end
		if ttime < 0 then continue end
		if !(IsValid(self) and IsValid(owner)) then continue end

		local jhon = CurTime() + ttime

		if !self.EventTable[1] then self.EventTable[1] = {} end

		for i, de in ipairs(self.EventTable) do
			if de[jhon] then
				if !self.EventTable[i+1] then self.EventTable[i+1] = {} continue end
			else
				self.EventTable[i][jhon] = v
			end
		end

	end
end

function SWEP:PlayEvent(v)
	if !v or !istable(v) then error("no event to play") end

	if v.s then
		if v.s_km then
			self:StopSound(v.s)
		end
		self:EmitSound(v.s, v.l, v.p, v.v, v.c or CHAN_AUTO)
	end
end