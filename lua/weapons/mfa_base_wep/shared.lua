
AddCSLuaFile()

SWEP.MFA								= true

SWEP.Base								= "weapon_base" -- bastard of it all
SWEP.Category							= "TTT"
SWEP.Spawnable							= false
SWEP.DrawCrosshair						= true

--
-- Weapon configuration
--
SWEP.PrintName							= "MFA weapon base"
SWEP.Slot								= 2

SWEP.UseHands							= true
SWEP.ViewModel							= "models/weapons/cstrike/c_rif_famas.mdl"
SWEP.WorldModel							= "models/weapons/w_rif_famas.mdl"
SWEP.ViewModelFOV						= 75

SWEP.Primary.ClipSize					= -1
SWEP.Primary.DefaultClip				= 0
SWEP.Primary.Ammo						= "none"
SWEP.Primary.ClipMax					= -1

SWEP.HoldTypeHip						= "ar2"
SWEP.HoldTypeSight						= "rpg"
SWEP.HoldTypeSprint						= "passive"

--
-- Recoil
--
SWEP.RecoilUp							= 2 -- degrees punched
SWEP.RecoilUpDecay						= 30 -- how much recoil to remove per second
SWEP.RecoilSide							= 0.5 -- degrees punched, in either direction (-100% to 100%)
SWEP.RecoilSideDecay					= 30 -- how much recoil to remove per second
SWEP.RecoilUpDrift						= 0.5 -- how much will be smooth recoil
SWEP.RecoilSideDrift					= 0.5 -- how much will be smooth recoil
SWEP.RecoilFlipChance					= ( 1 / 3 ) -- chance to flip recoil direction
SWEP.RecoilADSMult						= ( 1 / 3 ) -- multiply shot recoil by this amount when ads'd

-- after the fact
SWEP.Recoil2UpDrift						= 0.5 -- how much to return to the original pos
SWEP.Recoil2SideDrift					= 0.5
SWEP.Recoil2UpDecay						= 20 -- how much recoil to remove per second
SWEP.Recoil2SideDecay					= 20 


SWEP.Dispersion							= 1
SWEP.Dispersion_Move					= 2 -- at 200 hu/s
SWEP.Dispersion_Air						= 2
SWEP.Dispersion_Crouch					= ( 1 / 3 )
SWEP.Dispersion_Sights					= ( 1 / 3 )

SWEP.Dispersion_FireShoot				= 0.4
SWEP.Dispersion_FireDecay				= 3

SWEP.BodyDamageMults = {
	[HITGROUP_HEAD]		= 2.7,
	[HITGROUP_LEFTARM]	= 1,
	[HITGROUP_RIGHTARM]	= 1,
	[HITGROUP_LEFTLEG]	= 0.55,
	[HITGROUP_RIGHTLEG]	= 0.55,
	[HITGROUP_GEAR]		= 1,
}

SWEP.ActivePos = {
	Pos = Vector(0, 0, 0),
	Ang = Angle(0, 0, 0),
}

SWEP.IronsightPos = {
	Pos = Vector(0, 0, 0),
	Ang = Angle(0, 0, 0),
}

SWEP.RunPose = {
	Pos = Vector(0, 0, 0),
	Ang = Angle(-12, 12, -12),
}

--
-- Useless shit that you should NEVER touch
--
SWEP.Weight								= 5
SWEP.AutoSwitchTo						= false
SWEP.AutoSwitchFrom						= false
SWEP.m_WeaponDeploySpeed				= 10
-- Don't touch this
SWEP.UseHands							= false
SWEP.Primary.Automatic					= true -- This should ALWAYS be true.
SWEP.Secondary.ClipSize					= -1
SWEP.Secondary.DefaultClip				= 0
SWEP.Secondary.Automatic				= true
SWEP.Secondary.Ammo						= "none"
SWEP.Secondary.ClipMax					= -1

function SWEP:Initalize()
	self.Primary.Automatic = true
	self.Secondary.Automatic = true
end

ATTTSG_NO = 0
ATTTSG_START = 1
ATTTSG_INSERT = 2
ATTTSG_FINISH = 3

function SWEP:SetupDataTables()
	self:NetworkVar("Bool", 0, "FiredLastShot")
	self:NetworkVar("Bool", 1, "UserSight")
	self:NetworkVar("Bool", 2, "RecoilFlip")
	self:NetworkVar("Bool", 3, "FiremodeDebounce")

	self:NetworkVar("Int", 0, "BurstCount")
	self:NetworkVar("Int", 1, "Firemode")
	self:NetworkVar("Int", 2, "ShotgunReloading")

	self:NetworkVar("Float", 0, "IdleIn")
	self:NetworkVar("Float", 1, "SightDelta")
	self:NetworkVar("Float", 2, "LoadIn")
	self:NetworkVar("Float", 3, "NextMechFire")
	self:NetworkVar("Float", 4, "ReloadingTime")
	self:NetworkVar("Float", 5, "RecoilP")
	self:NetworkVar("Float", 6, "RecoilY")
	self:NetworkVar("Float", 7, "DISP_Air")
	self:NetworkVar("Float", 8, "DISP_Move")
	self:NetworkVar("Float", 9, "DISP_Crouch")
	self:NetworkVar("Float", 10, "StopSightTime")
	self:NetworkVar("Float", 11, "DISP_Fire")
	self:NetworkVar("Float", 12, "SprintDelta")
	self:NetworkVar("Float", 13, "Recoil2P")
	self:NetworkVar("Float", 14, "Recoil2Y")
	
	self:SetFiremode(1)
	self:SetNextMechFire(0)
	self:SetRecoilFlip( util.SharedRandom( "recoilflipinit", 0, 1, CurTime() ) < 0.5 and true or false )
	self.Primary.DefaultClip = self.Primary.ClipSize * 1

end

function SWEP:Initialize()
end

-- Firemodes
local unavailable = {
	Count = 1,
	Delay = 0.2,
	PostBurstDelay = 0,
}
function SWEP:GetFiremodeTable(cust)
	if !cust and self:Clip1() == 0 then
		return unavailable
	end

	return self.Firemodes[cust or self:GetFiremode()] or unavailable
end

function SWEP:SwitchFiremode(prev)
	-- lol?
	local nextfm = self:GetFiremode() + 1
	if #self.Firemodes < nextfm then
		nextfm = 1
	end
	if self:GetFiremode() != nextfm then
		self:SetFiremode(nextfm)
		self:EmitSound("weapons/smg1/switch_single.wav", 60, 100, 0.5, CHAN_STATIC)
	end
end

-- Globally define the best number
HUToM = 0.0254

--
-- Firing function
--
function SWEP:PrimaryAttack()
	local ammototake = 1

	if self:GetNextPrimaryFire() > CurTime() then
		return false
	end

	if self:GetNextMechFire() > CurTime() then
		return false
	end

	if self:GetReloadingTime() > CurTime() then
		return false
	end

	if self:GetSprintDelta() > 0.2 then
		return false
	end

	if self:GetFiredLastShot() then
		return false
	end

	if self:GetAmmoBank() < ammototake then
		self:SetNextPrimaryFire( CurTime() + self:GetFiremodeTable().Delay )
		self:SetBurstCount( self:GetBurstCount() + 1 )
		self:EmitSound( "Weapon_Pistol.Empty" )
		return false
	end

	self:TakePrimaryAmmo( ammototake )
	self:SetBurstCount( self:GetBurstCount() + 1 )
	self:EmitSound( self.Primary.Sound, self.Primary.SoundLevel )

	self:SendAnim( (self:GetSightDelta() > 0.5 and "fire_ads") or "fire" )

	-- Jane's fix
	local curtime = CurTime()
	local curatt = self:GetNextPrimaryFire()
	local diff = curtime - curatt

	if diff > engine.TickInterval() or diff < 0 then
		curatt = curtime
	end

	self:SetNextPrimaryFire(curatt + self:GetFiremodeTable().Delay)

	-- Bullets
	local bullet = {
		RangeNear = self.RangeNear / HUToM,
		RangeFar = self.RangeFar / HUToM,
		DamageNear = self.DamageNear,
		DamageFar = self.DamageFar,
	}
	self:FireBullet(bullet)

	-- Recoil
	local p = self:GetOwner()
	if !IsValid(p) then p = false end
	if p then
		local fli = self:GetRecoilFlip() and -1 or 1
		local ads = Lerp( self:GetSightDelta(), 1, self.RecoilADSMult )
		if true then
			if CLIENT and IsFirstTimePredicted() then p:SetEyeAngles( p:EyeAngles() + Angle( ads * -self.RecoilUp * (1-self.RecoilUpDrift), ads * fli * self.RecoilSide * (1-self.RecoilSideDrift) ) ) end
			self:SetRecoilP( self:GetRecoilP() + (ads * -self.RecoilUp * self.RecoilUpDrift) )
			self:SetRecoilY( self:GetRecoilY() + (ads * fli * -self.RecoilSide * self.RecoilSideDrift) )
			self:SetRecoil2P( self:GetRecoil2P() + (ads * -self.RecoilUp * self.Recoil2UpDrift) )
			self:SetRecoil2Y( self:GetRecoil2Y() + (ads * fli * -self.RecoilSide * self.Recoil2SideDrift) )
		end
		if util.SharedRandom( "recoilflipinit", 0, 1, CurTime() ) < self.RecoilFlipChance then
			self:SetRecoilFlip( !self:GetRecoilFlip() )
		end
	end
	self:SetDISP_Fire( self:GetDISP_Fire() + self.Dispersion_FireShoot )

	if CLIENT and IsFirstTimePredicted() then
		self.coolshake = CurTime()
	end
	
	return true
end

-- Bullets
function SWEP:FireBullet(bullet)
	local dispersion = self:GetDispersion()
	for i=1, self.Pellets or 1 do
		local dir = self:GetOwner():EyeAngles()
		local shared_rand = CurTime() + (i-1)
		local x = util.SharedRandom(shared_rand, -0.5, 0.5) + util.SharedRandom(shared_rand + 1, -0.5, 0.5)
		local y = util.SharedRandom(shared_rand + 2, -0.5, 0.5) + util.SharedRandom(shared_rand + 3, -0.5, 0.5)
		dir = dir:Forward() + (x * math.rad(dispersion) * dir:Right()) + (y * math.rad(dispersion) * dir:Up())

		bullet.Src = self:GetOwner():GetShootPos()
		bullet.Dir = dir
		bullet.Distance = 32768
		bullet.Force = 1

		bullet.Callback = function( atk, tr, dmg )
			-- Thank you Arctic, very cool
			local ent = tr.Entity

			if self.CustomCallback then self:CustomCallback( atk, tr, dmg ) end

			dmg:SetDamage( bullet.DamageNear )
			dmg:SetDamageType( DMG_BULLET )

			local d = dmg:GetDamage()
			local min, max = bullet.RangeNear, bullet.RangeFar
			local range = atk:GetPos():Distance(tr.HitPos)
			local XD = 0
			if range < min then
				XD = 0
			else
				XD = math.Clamp((range - min) / (max - min), 0, 1)
			end

			dmg:SetDamage( Lerp( 1-XD, bullet.DamageFar, bullet.DamageNear ) )

			self:SetNWString( "TestRange", math.Round( (1-XD)*100 ) .. "% effectiveness, " .. math.Round( dmg:GetDamage() ) .. " dmg" )

			if IsValid(ent) and ent:IsPlayer() then
				local hg = tr.HitGroup
				local gam = LimbCompensation
				local gem = self.BodyDamageMults
				if gem[hg] then dmg:ScaleDamage(gem[hg]) end
				if gam[hg] then dmg:ScaleDamage(gam[hg]) end
			end
			return
		end

		self:GetOwner():FireBullets( bullet )
	end
end

function SWEP:GetHeadshotMultiplier(victim, dmginfo)
	return 1
end

function SWEP:DrawHUD()
	-- draw.SimpleText( self:GetNWString("TestRange", "no data"), "Trebuchet24", ScrW()/2, ScrH()*0.75, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	-- draw.SimpleText( self:GetNWString("TestDisp", "no data"), "Trebuchet24", ScrW()/2, ScrH()*0.8, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
end

-- No secondary
function SWEP:SecondaryAttack()
end

function SWEP:CalcView( ply, pos, ang, fov )
	local ran = (AngleRand()/180) * 0.4

	local tim = math.TimeFraction(-0.007, 0.03, CurTime() - (self.coolshake or 0))
	tim = 1-math.Clamp( tim, 0, 1 )
	ran = ran * (tim) * (Lerp(self:GetSightDelta(), 1, 0.5))
	return pos, ang + ran, fov
end

if CLIENT then
	hook.Add( "GetMotionBlurValues", "GetNewMotionBlurValues", function( horizontal, vertical, forward, rotational )
		local wep = LocalPlayer()
		if IsValid(wep) and IsValid(wep:GetActiveWeapon()) then
			wep = wep:GetActiveWeapon()
		else
			wep = false
		end
		if wep and wep.MFA then
			local tim = math.TimeFraction(-0.007, 0.03, CurTime() - (wep.coolshake or 0))
			tim = 1-math.Clamp( tim, 0, 1 )
			forward = 0.01 * (tim) * (Lerp(wep:GetSightDelta(), 1, 0.5))
			return horizontal, vertical, forward, rotational
		end
	end )
end

--
-- Reloading
--
function SWEP:Reload()
	if self:GetNextPrimaryFire() > CurTime() then
		return false
	end

	if self:GetReloadingTime() > CurTime() then
		return false
	end

	if self:GetOwner():KeyDown(IN_USE) then
		if !self:GetFiremodeDebounce() then
			self:SwitchFiremode()
			self:SetFiremodeDebounce( true )
		end
		return false
	end

	if self:RefillCount() > 0 then
		if self.ShotgunReloading then
			self:SendAnim( "sgreload_start", "reload_start" )
			self:SetShotgunReloading( ATTTSG_START )
		else
			self:SendAnim( (self:Clip1() == 0 and "reload_empty" or "reload"), "reload" )
		end
	end

	return true
end

function SWEP:RefillCount(amount)
	local spent = self:GetMaxClip1() - self:Clip1()
	local refill = math.min( spent, self:Ammo1(), (amount or math.huge), (self.ShotgunReloading and 1 or math.huge) )

	return refill
end

function SWEP:Refill()
	local refill = self:RefillCount()

	--assert( refill > 0, "Refill is lower than 0!" )

	self:GetOwner():SetAmmo( self:Ammo1() - refill, self:GetPrimaryAmmoType() )
	self:SetClip1( self:Clip1() + refill )
end

function SWEP:TakePrimaryAmmo( amount )
	assert( self:Clip1() - amount >= 0, "Trying to reduce ammo below zero!" )

	self:SetClip1( self:Clip1() - 1 )
end

function SWEP:GetAmmoBank()
	return self:Clip1()
end

CreateClientConVar( "ttt_a_toggleads", 0, true, true )

-- Thinking
function SWEP:Think()
	local runoff = self:GetFiremodeTable().Runoff
	if runoff and self:GetBurstCount() != 0 then
		if ( (game.SinglePlayer() and SERVER) or !game.SinglePlayer() ) then
			self:PrimaryAttack()
		end
	end
	if self:GetBurstCount() >= self:GetFiremodeTable().Count then
		self:SetBurstCount( 0 )
		self:SetNextMechFire( CurTime() + (self:GetFiremodeTable().PostBurstDelay or 0) ) -- Can feel uncomfortable.
		self:SetFiredLastShot( true )
	elseif !(runoff or self:GetOwner():KeyDown(IN_ATTACK)) and self:GetBurstCount() != 0 then
		self:SetBurstCount( 0 )
		self:SetNextMechFire( CurTime() + (self:GetFiremodeTable().PostBurstDelay or 0) ) -- Can feel uncomfortable.
	end
	if !self:GetOwner():KeyDown(IN_ATTACK) then
		self:SetFiredLastShot(false)
	end
	if self:GetFiremodeDebounce() and !self:GetOwner():KeyDown(IN_RELOAD) then
		self:SetFiremodeDebounce( false )
	end

	if self:GetOwner():GetInfoNum("mfa_wep_toggleads", 0) == 0 then
		self:SetUserSight( self:GetOwner():KeyDown(IN_ATTACK2) )
	else
		if self:GetReloadingTime() > CurTime() then
			self:SetUserSight( false )
		elseif self:GetOwner():KeyPressed(IN_ATTACK2) then
			self:SetUserSight( !self:GetUserSight() )
		end
	end
	local capableofads = self:GetStopSightTime() <= CurTime() and !self:GetOwner():IsSprinting() and self:GetOwner():OnGround() -- replace with GetReloading
	self:SetSightDelta( math.Approach( self:GetSightDelta(), (capableofads and self:GetUserSight() and 1 or 0), FrameTime() / 0.4 ) )
	self:SetSprintDelta( math.Approach( self:GetSprintDelta(), (self:GetOwner():IsSprinting() and 1 or 0), FrameTime() / 0.4 ) )

	if self:GetLoadIn() > 0 and self:GetLoadIn() <= CurTime() then
		self:Refill(self:Clip1())
		self:SetLoadIn(-1)
	end

	local p = self:GetOwner()
	if !IsValid(p) then p = false end
	if p then
		local rp = self:GetRecoilP()
		local ry = self:GetRecoilY()
		local rp2 = self:GetRecoil2P()
		local ry2 = self:GetRecoil2Y()
		if rp != 0 then
			local remove = rp - math.Approach( rp, 0, FrameTime() * self.RecoilUpDecay )
			if CLIENT and IsFirstTimePredicted() then p:SetEyeAngles( p:EyeAngles() + ( Angle( remove, 0 ) ) ) end
			self:SetRecoilP( rp - remove )
		else
			local remove = rp2 - math.Approach( rp2, 0, FrameTime() * self.Recoil2UpDecay )
			if CLIENT and IsFirstTimePredicted() then p:SetEyeAngles( p:EyeAngles() - ( Angle( remove, 0 ) ) ) end
			self:SetRecoil2P( rp2 - remove )
		end
		if ry != 0 then
			local remove = ry - math.Approach( ry, 0, FrameTime() * self.RecoilSideDecay )
			if CLIENT and IsFirstTimePredicted() then p:SetEyeAngles( p:EyeAngles() - ( Angle( 0, remove ) ) ) end
			self:SetRecoilY( math.Approach( ry, ry - remove, math.huge ) )
		else
			local remove = ry2 - math.Approach( ry2, 0, FrameTime() * self.Recoil2SideDecay )
			if CLIENT and IsFirstTimePredicted() then p:SetEyeAngles( p:EyeAngles() + ( Angle( 0, remove ) ) ) end
			self:SetRecoil2Y( math.Approach( ry2, ry2 - remove, math.huge ) )
		end
		local ht = self.HoldTypeHip
		if self:GetSightDelta() > 0.2 then
			ht = self.HoldTypeSight
		end
		self:SetHoldType( ht )
		self:SetWeaponHoldType( ht )

		local movem = p:GetAbsVelocity():Length2D()
		movem = math.TimeFraction( 100, 200, movem )
		movem = math.Clamp( movem, 0, 1 )
		self:SetDISP_Air( math.Approach( self:GetDISP_Air(), p:OnGround() and 0 or 1, FrameTime() / 0.15 ) )
		self:SetDISP_Move( math.Approach( self:GetDISP_Move(), movem, FrameTime() / 0.15 ) )
		self:SetDISP_Crouch( math.Approach( self:GetDISP_Crouch(), p:Crouching() and 1 or 0, FrameTime() / 0.4 ) )
	end
	self:SetDISP_Fire( math.Approach( self:GetDISP_Fire(), 0, FrameTime() * self.Dispersion_FireDecay ) )

	if p and self:GetShotgunReloading() > 0 and p:KeyDown( IN_ATTACK ) then
		self:SetShotgunReloading( ATTTSG_NO )
		self:SendAnim( "sg_reloadfinish", "reload_finish" )
	end
	if self:GetShotgunReloading() then
		if self:GetShotgunReloading() == ATTTSG_START and self:GetReloadingTime() < CurTime() then
			self:SetShotgunReloading( ATTTSG_INSERT )
		elseif self:GetShotgunReloading() == ATTTSG_INSERT and self:GetReloadingTime() < CurTime() then
			if self:Clip1() >= self:GetMaxClip1() or (self:Ammo1() <= 0) then
				self:SetShotgunReloading( ATTTSG_NO )
				self:SendAnim( "sg_reloadfinish", "reload_finish" )
			else
				self:SendAnim( "reload", "reload" )
			end
		end
	else
		if self:GetIdleIn() > 0 and self:GetIdleIn() <= CurTime() then
			self:SendAnim( "idle", "idle" )
			self:SetPlaybackRate( 1 )
			self:SetIdleIn( -1 )
		end
	end
	
	for i, v in ipairs(self.EventTable) do
		for ed, bz in pairs(v) do
			if ed <= CurTime() then
				self:PlayEvent(bz)
				self.EventTable[i][ed] = nil
				if table.IsEmpty(v) and i != 1 then self.EventTable[i] = nil end
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

-- Animating
local fallback = {
	Mult = 1,
}
function SWEP:SendAnim( act, hold )
	local anim = fallback
	local anim = self.Animations
	if !anim then
		print("No animation table!")
		anim = fallback
		anim.Source = act
		return false
	elseif !anim[act] then
		print("No defined animation!")
		anim = fallback
		anim.Source = act
		return false
	else
		anim = self.Animations[act]
	end
	local mult = anim.Mult or 1
	local seqc = self:LookupSequence( anim.Source )
	local vm = self:GetOwner():GetViewModel()
	vm:SendViewModelMatchingSequence( seqc )
	mult = vm:SequenceDuration() / (anim.Time or vm:SequenceDuration())
	vm:SetPlaybackRate( mult )
	local seqdur = (vm:SequenceDuration() / mult)
	if hold == "idle" then
		hold = false
	else
		self:SetIdleIn( CurTime() + seqdur )
	end

	local stopsight = hold
	local reloadtime = hold
	local loadin = hold == "reload"
	local suppresstime = false

	if anim.StopSightTime then
		stopsight = true
	end
	if anim.ReloadingTime then
		reloadtime = true
	end
	if anim.LoadIn then
		loadin = true
	end
	if anim.SuppressTime then
		suppresstime = true
	end

	if reloadtime then
		self:SetReloadingTime( CurTime() + (anim.ReloadingTime or seqdur) )
	end
	if stopsight then
		self:SetStopSightTime( CurTime() + (anim.StopSightTime or seqdur) )
	end
	if loadin then
		self:SetLoadIn( CurTime() + (anim.LoadIn or seqdur) )
	end
	if suppresstime then
		self:SetSuppressIn( CurTime() + (anim.SuppressTime or seqdur) )
	end

	if anim.Events then table.Empty(self.EventTable) self:PlaySoundTable( anim.Events, 1 / mult ) end
end

-- Aiming
function SWEP:TranslateFOV(fov)
	local mag = 1.1
	if self.IronsightPos and self.IronsightPos.Mag then
		mag = self.IronsightPos.Mag
	end
	return fov / Lerp( math.ease.InOutQuad( self:GetSightDelta() ), 1, mag )
end


function SWEP:AdjustMouseSensitivity()
	local mag = 1.1
	if self.IronsightPos and self.IronsightPos.Mag then
		mag = self.IronsightPos.Mag
	end
	return 1 / Lerp( math.ease.InOutQuad( self:GetSightDelta() ), 1, mag )
end

-- Deploy and holster
function SWEP:Deploy()
	self:SendAnim( "draw", true )
	return true
end

function SWEP:Holster()
	self:SetLoadIn( -1 )
	self:SetSightDelta( 0 )
	return true
end

SWEP.BobScale = 0
SWEP.SwayScale = 0
local savemoove = 0
local cancelsprint = 0


local ox, oy = 0, 0
local LASTAIM

function SWEP:GetViewModelPosition(pos, ang)
	local opos, oang = Vector(), Angle()
	local p = self:GetOwner()

	if IsValid(p) then
	do -- activepos, 'idle'
		local b_pos, b_ang = Vector(), Angle()
		local si = 1-self:GetSightDelta()
		si = math.ease.InOutSine( si )

		b_pos:Add( self.ActivePos.Pos )
		b_ang:Add( self.ActivePos.Ang )
		b_pos:Mul( si )
		b_ang:Mul( si )

		opos:Add( b_pos )
		oang:Add( b_ang )
	end

	do -- sprinting
		local b_pos, b_ang = Vector(), Angle()
		local si = self:GetSprintDelta()

		cancelsprint = math.Approach( cancelsprint, (self:GetStopSightTime() > CurTime() and 0 or 1), FrameTime() / 0.4 )
		si = math.min(si, cancelsprint)

		b_pos:Add( self.RunPose.Pos )
		b_pos:Mul( math.ease.InOutSine( si ) )
		b_ang:Add( self.RunPose.Ang )
		b_ang:Mul( math.ease.InOutSine( si ) )

		opos:Add( b_pos )
		oang:Add( b_ang )
		
		local b_pos, b_ang = Vector(), Angle()
		local xi = si

		if xi >= 0.5 then
			xi = xi - 0.5
			xi = 0.5 - xi
		end
		xi = xi * 2

		b_pos:Add( Vector( -0.5, 2, -1 ) )
		b_pos:Mul( math.ease.InOutSine( xi ) )
		b_ang:Add( Angle( -4, 0, -6 ) )
		b_ang:Mul( math.ease.InOutSine( xi ) )

		opos:Add( b_pos )
		oang:Add( b_ang )
	end

	do -- ironsighting
		local b_pos, b_ang = Vector(), Angle()
		local si = self:GetSightDelta()
		local ss_si = math.ease.InOutSine( si )

		b_pos:Add( self.IronsightPos.Pos )
		b_ang:Add( self.IronsightPos.Ang )
		b_pos:Mul( ss_si )
		b_ang:Mul( ss_si )
		opos:Add( b_pos )
		oang:Add( b_ang )
		
		local b_pos, b_ang = Vector(), Angle()
		local xi = si

		if xi >= 0.5 then
			xi = xi - 0.5
			xi = 0.5 - xi
		end
		xi = xi * 2
		local ss_xi = math.ease.InOutSine( xi )

		b_pos:Add( Vector( -0.5, 2, -0.2 ) )
		b_ang:Add( Angle( -4, 0, -5 ) )
		b_pos:Mul( ss_xi )
		b_ang:Mul( ss_xi )

		opos:Add( b_pos )
		oang:Add( b_ang )
	end

	if true then -- bobbing
		local b_pos, b_ang = Vector(), Angle()
		local speed = 2.5 -- This can't be changed in real time or it'll look juttery.

		local new = p:GetAbsVelocity():Length()/200
		local time = 0.4
		if new < savemoove then
			time = 0.2
		end
		savemoove = math.Approach( savemoove, math.min(new, 2), FrameTime() / time )

		local moove = Lerp( self:GetSightDelta(), savemoove, math.min(savemoove, 0.1) )

		b_pos.x = math.sin( CurTime() * math.pi * speed ) * (0.2 + (self:GetSprintDelta()*0.4))
		b_pos.z = math.cos( CurTime() * math.pi * speed * 2 ) * (-0.07 + (self:GetSprintDelta()*-0.1))

		b_ang.x = math.sin( CurTime() * math.pi * speed * 2 ) * -0.2
		b_ang.y = math.cos( CurTime() * math.pi * speed * 1 ) * 1

		b_pos:Mul( moove )
		b_ang:Mul( moove )

		opos:Add(b_pos)
		oang:Add(b_ang)

		local b_pos, b_ang = Vector(), Angle()
		local EY = p:EyeAngles()
		if !LASTAIM then LASTAIM = EY end
		ox = math.ApproachAngle(ox, ox + (EY.y - LASTAIM.y), math.huge)
		oy = math.ApproachAngle(oy, oy - (EY.p - LASTAIM.p), math.huge)
		ox = math.Approach(ox, ox*0.99, FrameTime()*1000)
		oy = math.Approach(oy, oy*0.99, FrameTime()*1000)
		LASTAIM:Set(p:EyeAngles())

		local sii = self:GetSightDelta()
		b_ang.y = ox*0.05*Lerp(sii, 1, 0.05)
		b_pos.x = ox*0.033*Lerp(sii, 1, 0.05)

		b_ang.x = oy*0.1*Lerp(sii, 1, 0.05)
		b_pos.z = oy*-0.04*Lerp(sii, 1, 0.05)

		b_ang.z = (b_ang.z + (oy*-0.1) + (ox*-0.02))*Lerp(sii, 1, 0.1)

		b_ang:Normalize()

		--b_ang:Mul( moove )

		opos:Add(b_pos)
		oang:Add(b_ang)
	end

	end
	
	ang:RotateAroundAxis( ang:Right(),		oang.x )
	ang:RotateAroundAxis( ang:Up(),			oang.y )
	ang:RotateAroundAxis( ang:Forward(),	oang.z )

	pos:Add( opos.x * ang:Right() )
	pos:Add( opos.y * ang:Forward() )
	pos:Add( opos.z * ang:Up() )

	return pos, ang
end

function SWEP:GetMovespeed()
	local mo = 1
	if self:GetNextPrimaryFire() > CurTime() then
		mo = mo * 0.7
	end

	return mo
end

function SWEP:GetDispersion()
	local disp = self.Dispersion

	disp = disp + ( self:GetDISP_Air() * self.Dispersion_Air )
	disp = disp + ( self:GetDISP_Move() * self.Dispersion_Move )
	disp = disp + ( self:GetDISP_Fire() )

	disp = Lerp( self:GetDISP_Crouch(), disp, disp * self.Dispersion_Crouch )
	disp = Lerp( self:GetSightDelta(), disp, disp * self.Dispersion_Sights )

	self:SetNWString( "TestDisp", math.Round(disp, 1) .. " degrees" )

	return disp
end

--
-- HUD, UI, Crosshair
--

local CHR_F = Color( 255, 242, 151, 255 )
local CHR_B = Color( 0, 0, 0, 100 )
local CHR_S = Color( 255, 255, 255, 255 )
local len = 1.0
local thi = 1.0
local gap = 10
local sd = 1
local reloadclock = 0

function SWEP:DoDrawCrosshair()
	local l = ScreenScale(len)
	local t = ScreenScale(thi)
	local s = sd
	local p = self:GetOwner()

	local dispersion = math.rad(self:GetDispersion())
	cam.Start3D()
		local lool = ( EyePos() + ( EyeAngles():Forward() ) + ( dispersion * EyeAngles():Up() ) ):ToScreen()
	cam.End3D()

	local gau = (ScrH()/2)
	gau = ( gau - lool.y )
	gap = gau

	if true then
		reloadclock = math.Approach( reloadclock, (self:GetReloadingTime() > CurTime()) and 1 or 0, FrameTime() / 0.4 )
		local clock = Lerp( math.max( self:GetSightDelta(), self:GetSprintDelta(), reloadclock ), 1, 0 )
		CHR_F.a = clock * 255
		CHR_B.a = clock * 100
		gap = gap / (clock)
		l = l * clock
	end

	-- bg
	surface.SetDrawColor( CHR_B )
	-- bottom prong
	surface.DrawRect( math.Round(( ScrW() / 2 ) - ( t / 2 ) + s), math.Round(( ScrH() / 2 ) + gap + s), t, l )

	-- top prong
	surface.DrawRect( math.Round(( ScrW() / 2 ) - ( t / 2 ) + s), math.Round(( ScrH() / 2 ) - l - gap + s), t, l )

	-- left prong
	surface.DrawRect( math.Round(( ScrW() / 2 ) - l - gap + s), math.Round(( ScrH() / 2 ) - ( t / 2 ) + s), l, t )

	-- right prong
	surface.DrawRect( math.Round(( ScrW() / 2 ) + gap + s), math.Round(( ScrH() / 2 ) - ( t / 2 ) + s), l, t )

	-- center
	surface.DrawRect( math.Round(( ScrW() / 2 ) - ( t / 2 ) + s), math.Round(( ScrH() / 2 ) - ( t / 2 ) + s), t, t )

	-- fore
	surface.SetDrawColor( CHR_F )
	-- bottom prong
	surface.DrawRect( math.Round(( ScrW() / 2 ) - ( t / 2 )), math.Round(( ScrH() / 2 ) + gap), t, l )

	-- top prong
	surface.DrawRect( math.Round(( ScrW() / 2 ) - ( t / 2 )), math.Round(( ScrH() / 2 ) - l - gap), t, l )

	-- left prong
	surface.DrawRect( math.Round(( ScrW() / 2 ) - l - gap), math.Round(( ScrH() / 2 ) - ( t / 2 )), l, t )

	-- right prong
	surface.DrawRect( math.Round(( ScrW() / 2 ) + gap), math.Round(( ScrH() / 2 ) - ( t / 2 )), l, t )

	-- center
	surface.DrawRect( math.Round(( ScrW() / 2 ) - ( t / 2 )), math.Round(( ScrH() / 2 ) - ( t / 2 )), t, t )
	return true
end