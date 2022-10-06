
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
SWEP.Primary.Ammo						= "none"
SWEP.Sound_Fire							= {}
SWEP.Sound_Dry							= { s = "mfa/wep/dry/rifle.ogg", sl = 50, v = 0.5, p = 100 }

SWEP.HoldTypeHip						= "ar2"
SWEP.HoldTypeSight						= "rpg"
SWEP.HoldTypeSprint						= "passive"

--
-- Recoil
--
SWEP.RecoilUp							= 2 -- degrees punched
SWEP.RecoilSide							= 0.5 -- degrees punched, in either direction (-100% to 100%)
SWEP.RecoilDrift						= 0.5 -- how much will be smooth recoil
SWEP.RecoilDecay						= 30 -- how much recoil to remove per second
SWEP.RecoilADSMult						= ( 1 / 3 ) -- multiply shot recoil by this amount when ads'd

-- after the fact
SWEP.Recoil2Drift						= 0.5 -- how much to return to the original pos
SWEP.Recoil2Decay						= 20 -- how much recoil to remove per second


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

SWEP.ActivePose = {
	Pos = Vector(0, 0, 0),
	Ang = Angle(0, 0, 0),
}

SWEP.IronsightPose = {
	Pos = Vector(0, 0, 0),
	Ang = Angle(0, 0, 0),
}

SWEP.RunPose = {
	Pos = Vector(0, 0, 0),
	Ang = Angle(-12, 12, -12),
}

SWEP.CustomizePose = {
	Pos = Vector(0.5, -2, -0.5),
	Ang = Angle(6, 6, 0),
}

SWEP.CrouchPose = {
	Pos = Vector(-0.2, -0.5, -0.1),
	Ang = Angle(0.5, 1, -2),
}

SWEP.MuzzleEffect						= "muzzleflash_4"
SWEP.QCA_Muzzle							= 1
SWEP.QCA_Case							= 2

SWEP.ShellModel							= "models/shells/shell_556.mdl"
SWEP.ShellScale							= 1

SWEP.ShotgunReloading					= false
SWEP.CycleCount							= 0

SWEP.Movespeed							= 1
SWEP.Movespeed_Firing					= 1
SWEP.Movespeed_ADS						= 1

SWEP.SwayP								= 0.1
SWEP.SwayY								= 0.2

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
SWEP.Primary.DefaultClip				= 0
SWEP.Secondary.ClipSize					= -1
SWEP.Secondary.DefaultClip				= 0
SWEP.Secondary.Automatic				= true
SWEP.Secondary.Ammo						= "none"
SWEP.Secondary.ClipMax					= -1

SWEP.ShellPhysScale						= 1
SWEP.ShellPitch							= 100
SWEP.ShellRotate						= 0
SWEP.ShellMaterial						= nil
SWEP.ShellSounds						= "autocheck"--ArcCW.ShellSoundsTable

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
	--
	self:NetworkVar("Bool", 3, "FiremodeDebounce")
	self:NetworkVar("Bool", 4, "Customizing")

	self:NetworkVar("Int", 0, "BurstCount")
	self:NetworkVar("Int", 1, "Firemode")
	self:NetworkVar("Int", 2, "ShotgunReloading")
	self:NetworkVar("Int", 3, "CycleCount")

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
	self:NetworkVar("Float", 15, "CycleDelayTime")
	self:NetworkVar("Float", 16, "Holster_Time")
	self:NetworkVar("Float", 17, "RecoilFlip")

	self:NetworkVar("Entity", 0, "Holster_Entity")
	
	self:SetFiremode(1)
	self:SetNextMechFire(0)
	self:SetRecoilFlip( math.Rand( -1, 1 ) )
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
function SWEP:GetFiremodeName(cust)
	local ftn = self:GetFiremodeTable(cust or self:GetFiremode())
	if ftn.Name then
		ftn = ftn.Name
	elseif ftn.Count == math.huge then
		ftn = "Automatic"
	elseif ftn.Count == 1 then
		ftn = "Semi-automatic"
	else
		ftn = ftn.Count .. "-round burst"
	end

	return ftn
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

local function quickie(en)
	if istable(en) then
		return table.Random(en)
	else
		return en
	end
end

function SWEP:GetSwayAngle()
	local p = self:GetOwner()

	local b_ang = Angle()
	local hunger = math.Clamp( math.TimeFraction( 1, 0, p:GetNWFloat( "MFA_Stamina", 1 ) ), 0, 1 )

	local updown, leftright = (self.SwayP or 0) + (hunger*0.6), (self.SwayY or 0) + (hunger*2)

	b_ang.y = b_ang.y + math.cos( CurTime() * 1 ) * leftright
	b_ang.x = b_ang.x + math.sin( CurTime() * 2 ) * updown

	return b_ang
end

function SWEP:GetFinalShotAngle()
	local p = self:GetOwner()
	local fsa = p:EyeAngles()
	fsa = Angle( fsa.p, fsa.y, 0 )

	fsa:Add(self:GetSwayAngle())

	return fsa
end

--
-- Firing function
--
function SWEP:PrimaryAttack()
	local ammototake = 1

	if IsValid(self:GetHolster_Entity()) then return end
	if self:GetHolster_Time() > 0 then return end

	if self:GetNextPrimaryFire() > CurTime() then
		return false
	end

	if self:GetNextMechFire() > CurTime() then
		return false
	end

	if self:GetReloadingTime() > CurTime() then
		return false
	end

	if self:GetCycleDelayTime() > CurTime() then
		return false
	end

	if self:GetSprintDelta() > 0.2 then
		return false
	end

	if self:GetFiredLastShot() then
		return false
	end

	if self:GetCustomizing() then
		return false
	end

	if self.CycleCount > 0 and self:GetCycleCount() >= self.CycleCount then
		return false
	end

	if self:Clip1() < ammototake then
		self:SetNextPrimaryFire( CurTime() + self:GetFiremodeTable().Delay )
		self:SetBurstCount( self:GetBurstCount() + 1 )
		local volume = self.Sound_Dry
		self:EmitSound( quickie(volume.s), volume.sl, math.Rand( volume.p, volume.pm or volume.p ), volume.v, volume.c )
		self:SendAnimChoose( "dryfire" )
		return false
	end

	self:TakePrimaryAmmo( ammototake )
	self:SetBurstCount( self:GetBurstCount() + 1 )

	if self.Sound_Fire then
		for index, volume in ipairs(self.Sound_Fire) do
			self:EmitSound( quickie(volume.s), volume.sl, math.Rand( volume.p, volume.pm or volume.p ), volume.v, volume.c )
		end
	else
		self:EmitSound( self.Primary.Sound, 140 )
	end

	self:SendAnimChoose( "fire" )

	-- Jane's fix
	local curtime = CurTime()
	local curatt = self:GetNextPrimaryFire()
	local diff = curtime - curatt

	if diff > engine.TickInterval() or diff < 0 then
		curatt = curtime
	end

	self:SetNextPrimaryFire(curatt + self:GetFiremodeTable().Delay)

	if self.CycleCount > 0 then
		self:SetCycleCount( self:GetCycleCount() + 1 )
	end

	-- Bullets
	local bullet = {
		RangeNear = self.RangeNear / HUToM,
		RangeFar = self.RangeFar / HUToM,
		DamageNear = self.DamageNear,
		DamageFar = self.DamageFar,
	}
	self:FireBullet(bullet)
	self:DoEffects()

	-- Recoil
	local p = self:GetOwner()
	if !IsValid(p) then p = false end
	if p then
		local ads = Lerp( self:GetSightDelta(), 1, self.RecoilADSMult )
		self:SetRecoilFlip( math.Rand( -1, 1 ) )
		if true then
			if ((SERVER and game.SinglePlayer()) or (CLIENT and IsFirstTimePredicted())) then p:SetEyeAngles( p:EyeAngles() + Angle( ads * -self.RecoilUp * (1-self.RecoilDrift), ads * self:GetRecoilFlip() * self.RecoilSide * (1-self.RecoilDrift) ) ) end
			self:SetRecoilP( self:GetRecoilP() + (ads * -self.RecoilUp * self.RecoilDrift) )
			self:SetRecoilY( self:GetRecoilY() + (ads * self:GetRecoilFlip() * -self.RecoilSide * self.RecoilDrift) )
			self:SetRecoil2P( self:GetRecoil2P() + (ads * -self.RecoilUp * self.Recoil2Drift) )
			self:SetRecoil2Y( self:GetRecoil2Y() + (ads * self:GetRecoilFlip() * -self.RecoilSide * self.Recoil2Drift) )
		end
	end
	self:SetDISP_Fire( self:GetDISP_Fire() + self.Dispersion_FireShoot )

	if CLIENT and IsFirstTimePredicted() then
		self.coolshake = CurTime()
	end
	
	return true
end

local function getdamagefromrange( dmg_near, dmg_far, range_near, range_far, dist )
	local min, max = range_near, range_far
	local range = dist
	local XD = 0
	if range < min then
		XD = 0
	else
		XD = math.Clamp((range - min) / (max - min), 0, 1)
	end

	return math.ceil( Lerp( XD, dmg_near, dmg_far ) )
end

-- Bullets
function SWEP:FireBullet(bullet)
	local dispersion = self:GetDispersion()
	for i=1, self.Pellets or 1 do
		local dir = self:GetFinalShotAngle()
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

			dmg:SetDamage( getdamagefromrange( bullet.DamageNear, bullet.DamageFar, bullet.RangeNear, bullet.RangeFar, atk:GetPos():Distance(tr.HitPos) ) )

			if IsValid(ent) and ent:IsPlayer() then
				local hg = tr.HitGroup
				local gam = LimbCompensation
				local gem = self.BodyDamageMults
				if gem and gem[hg] then dmg:ScaleDamage(gem[hg]) end
				if gam and gam[hg] then dmg:ScaleDamage(gam[hg]) end
			end
			return
		end

		self:GetOwner():FireBullets( bullet )
	end
end

function SWEP:DoEffects(att)
	if !game.SinglePlayer() and !IsFirstTimePredicted() then return end

	local ed = EffectData()
	ed:SetStart(self:GetOwner():GetAimVector())
	ed:SetOrigin(self:GetOwner():GetAimVector())
	ed:SetScale(1)
	ed:SetEntity(self)
	ed:SetAttachment(self.QCA_Muzzle or 1)

	local efov = {}
	efov.eff = "mfa_wep_muzzleeffect"
	efov.fx  = ed

	util.Effect("mfa_wep_muzzleeffect", ed)
end

function SWEP:DoShellEject(atti)
	if !game.SinglePlayer() and !IsFirstTimePredicted() then return end

	local eff = "mfa_wep_shelleffect"

	local owner = self:GetOwner()
	if !IsValid(owner) then return end

	local vm = self

	if !owner:IsNPC() then owner:GetViewModel() end

	local att = vm:GetAttachment(self.QCA_Case or 2)

	if !att then return end

	local pos, ang = att.Pos, att.Ang

	local ed = EffectData()
	ed:SetOrigin(pos)
	ed:SetAngles(ang)
	ed:SetAttachment(self.QCA_Case or 2)
	ed:SetScale(1)
	ed:SetEntity(self)
	ed:SetNormal(ang:Forward())
	ed:SetMagnitude(100)

	local efov = {}
	efov.eff = eff
	efov.fx  = ed

	util.Effect(eff, ed)
end

local cool1 = Color(255, 255, 255, 255)
local cool2 = Color(255, 255, 255, 255)
local custperhud = 0
function SWEP:DrawHUD()
	local w = self
	custperhud = math.Approach( custperhud, self:GetCustomizing() and 1 or 0, FrameTime() / 0.1 )
	if (custperhud or 0) > 0 then
		cool1.a = Lerp( custperhud, 0, 255 )
		cool2.a = Lerp( custperhud, 0, 127 )
		local dd = MFAS2
		draw.SimpleText( w:GetPrintName(), "MFA_HUD_96", ScrW() - dd(72), dd(48), cool1, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP)
		
		if w.Trivia["Category"] then
			draw.SimpleText( w.Trivia["Category"], "MFA_HUD_48", ScrW() - dd(72), dd(126), cool1, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP)
		end
		if w.Trivia["Description"] then
			draw.SimpleText( w.Trivia["Description"], "MFA_HUD_20", ScrW() - dd(72), dd(170), cool1, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP)
		end

		if true then
			draw.SimpleText( w.DamageNear .. "dmg at " .. w.RangeNear .. "m, " .. w.DamageFar .. "dmg at " .. w.RangeFar .. "m", "MFA_HUD_20", ScrW() - dd(72), dd(200), cool1, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP)
			draw.SimpleText( w:GetMaxClip1() .. " magazine capacity", "MFA_HUD_20", ScrW() - dd(72), dd((200 + (25*1))), cool1, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP)
		end
	end
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

	if self:GetCustomizing() then
		return false
	end

	if self:GetShotgunReloading() != ATTTSG_NO then
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
			self:SendAnimChoose( "sgreload_start", "reload_start" )
			self:SetShotgunReloading( ATTTSG_START )
		else
			self:SendAnimChoose( "reload", "reload" )
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

	self:GetOwner():SetAmmo( self:Ammo1() - refill, self:GetPrimaryAmmoType() )
	self:SetClip1( self:Clip1() + refill )
end

function SWEP:TakePrimaryAmmo( amount )
	assert( self:Clip1() - amount >= 0, "Trying to reduce ammo below zero!" )

	self:SetClip1( self:Clip1() - 1 )
end

-- sprint check
function SWEP:SprCheck( ent )
	if !ent then ent = self:GetOwner() end

	if !IsValid(ent) then
		return false
	end

	if !ent:IsSprinting() then
		return false
	end

	if ent:GetAbsVelocity():Length2DSqr() < 8000 then
		return false
	end

	return true
end

local lastsighting = nil
local sound_played = true
local adssound = {
	"mfa/zenith/ogg/cloth_inspect_soft_1.ogg",
	"mfa/zenith/ogg/cloth_inspect_soft_2.ogg"
}

-- Thinking
function SWEP:Think()
	local p = self:GetOwner()
	if !IsValid(p) then p = false end

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
	local capableofads = self:GetStopSightTime() <= CurTime() and !self:SprCheck(self:GetOwner()) and self:GetOwner():OnGround() and !self:GetCustomizing() -- replace with GetReloading

	local sighting = (capableofads and self:GetUserSight() and 1 or 0)
	self:SetSightDelta( math.Approach( self:GetSightDelta(), sighting, FrameTime() / (self.Handling_ADS or 0.5) ) )

	local spgarb = !game.SinglePlayer() or CLIENT
	if spgarb and lastsighting != nil and lastsighting != sighting then
		sound_played = false
	end
	if !sound_played then
		self:EmitSound( quickie( adssound ), 50, sighting and 150 or 50, 1, CHAN_STATIC )
		sound_played = true
	end
	lastsighting = sighting

	self:SetSprintDelta( math.Approach( self:GetSprintDelta(), (self:SprCheck(self:GetOwner()) and 1 or 0), FrameTime() / (self.Handling_Sprint or 0.5) ) )

	if self:GetLoadIn() > 0 and self:GetLoadIn() <= CurTime() then
		self:Refill(self:Clip1())
		self:SetLoadIn(-1)
	end

	if p then
		local fli = self:GetRecoilFlip() or 1
		local recoil_p = self:GetRecoilP()
		local recoil_y = self:GetRecoilY()
		local returncoil_p = self:GetRecoil2P()
		local returncoil_y = self:GetRecoil2Y()
		if recoil_p != 0 or recoil_y != 0 then
			local frigginmath = math.Approach( 0, math.sqrt( math.pow( recoil_p, 2 ) + math.pow( recoil_y, 2 ) ), FrameTime() * self.RecoilDecay )
			if ((SERVER and game.SinglePlayer()) or (CLIENT and IsFirstTimePredicted())) then
				p:SetEyeAngles( p:EyeAngles() - Angle( frigginmath, frigginmath * fli ) )
			end
			self:SetRecoilP( math.Approach( recoil_p, 0, frigginmath ) )
			self:SetRecoilY( math.Approach( recoil_y, 0, frigginmath ) )
		else
			local frigginmath = math.Approach( 0, math.sqrt( math.pow( returncoil_p, 2 ) + math.pow( returncoil_y, 2 ) ), FrameTime() * self.Recoil2Decay )
			if ((SERVER and game.SinglePlayer()) or (CLIENT and IsFirstTimePredicted())) then
				p:SetEyeAngles( p:EyeAngles() + Angle( frigginmath, frigginmath * fli ) )
			end
			self:SetRecoil2P( math.Approach( returncoil_p, 0, frigginmath ) )
			self:SetRecoil2Y( math.Approach( returncoil_y, 0, frigginmath ) )
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
		self:SendAnimChoose( "sgreload_finish", "reload_finish" )
		self:SetLoadIn( 0 )
	end

	if p and !(self:GetFiremodeTable().Count == 1 and p:KeyDown(IN_ATTACK)) and self:GetCycleDelayTime() < CurTime() and self.CycleCount > 0 and self:GetCycleCount() >= self.CycleCount then
		self:SendAnimChoose( "cycle", false )
		self:SetCycleCount( 0 )
	end

	if self:GetShotgunReloading() != ATTTSG_NO then
		if self:GetShotgunReloading() == ATTTSG_START and self:GetReloadingTime() < CurTime() then
			self:SetShotgunReloading( ATTTSG_INSERT )
		elseif self:GetShotgunReloading() == ATTTSG_INSERT and self:GetReloadingTime() < CurTime() then
			if self:Clip1() >= self:GetMaxClip1() or (self:Ammo1() <= 0) then
				self:SetShotgunReloading( ATTTSG_NO )
				self:SendAnimChoose( "sgreload_finish", "reload_finish" )
			else
				self:SendAnimChoose( "reload", "reload" )
			end
		end
	else
		if self:GetIdleIn() > 0 and self:GetIdleIn() <= CurTime() then
			self:SendAnimChoose( "idle", "idle" )
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

	if v.s and ( (game.SinglePlayer() and SERVER) or (!game.SinglePlayer() and CLIENT) ) then
		if v.s_km then
			self:StopSound(v.s)
		end
		self:EmitSound(quickie(v.s), v.l or 50, v.p or 100, v.v or 1, v.c or CHAN_STATIC)
	end
	if v.shell then
		self:DoShellEject()
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
function SWEP:SendAnimChoose( act, hold, send )
	assert( self.Animations, "SendAnimChoose: No animations table?!" )

	local retong = act

	if !self.Animations[act] then
		return false
	end

	if self:GetSightDelta() > 0.5 and self.Animations[act .. "_ads"] then
		retong = retong .. "_ads"
	end

	if self:Clip1() == 0 and self.Animations[act .. "_empty"] then
		retong = retong .. "_empty"
	end

	return ( send and retong ) or self:SendAnim( retong, hold )
end
local fallback = {
	Mult = 1,
}
function SWEP:SendAnim( act, hold )
	local anim = fallback
	local anim = self.Animations
	assert( anim, "SendAnim: No animations table?!" )
	if !anim then
		-- print("No animation table!")
		return 0
	elseif !anim[act] then
		-- print("No defined animation!")
		return 0
	else
		anim = self.Animations[act]
	end
	local mult = anim.Mult or 1
	local seqc = self:LookupSequence( quickie( anim.Source ) )
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
	local cycledelaytime = hold == "cycle" or hold == "fire"
	local attacktime = false
	local holstertime = hold == "holster"

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
	if anim.CycleDelayTime then
		cycledelaytime = true
	end
	if anim.AttackTime then
		attacktime = true
	end
	if anim.HolsterTime then
		holstertime = true
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
	if cycledelaytime then
		self:SetCycleDelayTime( CurTime() + (anim.CycleDelayTime or seqdur) )
	end
	if attacktime then
		self:SetNextMechFire( CurTime() + (anim.AttackTime or seqdur) )
	end
	if holstertime then
		self:SetHolster_Time( CurTime() + (anim.HolsterTime or seqdur) )
	end

	table.Empty(self.EventTable)
	if anim.Events then self:PlaySoundTable( anim.Events, 1 / mult ) end

	return seqdur
end

-- Aiming
function SWEP:TranslateFOV(fov)
	local mag = 1.1
	if self.IronsightPose and self.IronsightPose.Mag then
		mag = self.IronsightPose.Mag
	end
	return fov / Lerp( math.ease.InOutQuad( self:GetSightDelta() ), 1, mag )
end


function SWEP:AdjustMouseSensitivity()
	local mag = 1.1
	if self.IronsightPose and self.IronsightPose.Mag then
		mag = self.IronsightPose.Mag
	end
	return 1 / Lerp( math.ease.InOutQuad( self:GetSightDelta() ), 1, mag )
end

-- Deploy and holster
local deploydebounce = 0
function SWEP:Deploy(valis)
	self:SetHolster_Time( 0 )
	self:SetHolster_Entity( NULL )

	-- The dirtiest hack of ALL TIME!
	if deploydebounce > CurTime() then return false end
	local original = self:GetNWBool( "readyed", false )
	if (valis == "Unreadyed" or !self:GetNWBool( "readyed", false )) and self:SendAnimChoose( "ready", true ) then
		self:SetNWBool( "readyed", true )
	else
		self:SendAnimChoose( "draw", true )
	end
	self:SetCustomizing( false )
	self:SetLoadIn( -1 )
	self:SetSightDelta( 0 )
	self:SetSprintDelta( 0 )
	self:SetShotgunReloading( 0 )
	timer.Simple(0.09, function() self:CallOnClient("Deploy", (original == false and "Unreadyed")) end)
	deploydebounce = CurTime() + 0.18
	return true
end

function SWEP:Holster( wep )
	self:SetCustomizing( false )
	self:SetLoadIn( -1 )
	self:SetShotgunReloading( 0 )

	if wep == self then return end

	if (self:GetHolster_Time() != 0 and self:GetHolster_Time() <= CurTime()) or !IsValid( wep ) then
		self:SetHolster_Time( 0 )
		self:SetHolster_Entity( NULL )
		self:SetSightDelta( 0 )

		return true
	elseif IsValid(wep) and (game.SinglePlayer() and SERVER or !game.SinglePlayer()) and self:SendAnimChoose( "holster", "holster", true ) then
		self:SendAnimChoose( "holster", "holster" )
		self:SetHolster_Entity( wep )
	else
		self:SetHolster_Time( 0 )
		self:SetHolster_Entity( NULL )
		self:SetSightDelta( 0 )

		return true
	end
end

SWEP.BobScale = 0
SWEP.SwayScale = 0
local savemoove = 0
local cancelsprint = 0
local custper = 0
local crouchper = 0

local ox, oy = 0, 0
local LASTAIM

local ttpos, ttang = Vector(), Angle()

function SWEP:GetViewModelPosition(pos, ang)
	local opos, oang = Vector(), Angle()
	local p = self:GetOwner()

	if IsValid(p) then
	do -- ActivePose, 'idle'
		local b_pos, b_ang = Vector(), Angle()
		local si = 1
		si = si * (1-self:GetSightDelta())
		si = si * (1-self:GetSprintDelta())
		si = si * (1-custper)
		si = math.ease.InOutSine( si )

		b_pos:Add( self.ActivePose.Pos )
		b_ang:Add( self.ActivePose.Ang )
		b_pos:Mul( si )
		b_ang:Mul( si )

		opos:Add( b_pos )
		oang:Add( b_ang )
	end

	do -- ActivePose, 'idle'
		local b_pos, b_ang = Vector(), Angle()
		local si = 1
		si = si * (1-self:GetSightDelta())
		si = si * (1-self:GetSprintDelta())
		si = si * (crouchper)
		si = math.ease.InOutSine( si )

		crouchper = math.Approach( crouchper, (p:Crouching() or p:KeyDown(IN_DUCK)) and 1 or 0, FrameTime() / 0.6 )

		b_pos:Add( self.CrouchPose.Pos )
		b_ang:Add( self.CrouchPose.Ang )
		b_pos:Mul( si )
		b_ang:Mul( si )

		opos:Add( b_pos )
		oang:Add( b_ang )
	end

	do -- customizing
		local b_pos, b_ang = Vector(), Angle()
		local si = custper
		si = si * (1-self:GetSightDelta())
		si = si * (1-self:GetSprintDelta())
		if self:GetCustomizing() then
			si = math.ease.OutCubic( si )
		else
			si = math.ease.InSine( si )
		end

		custper = math.Approach( custper, self:GetCustomizing() and 1 or 0, FrameTime() / 0.8 )

		b_pos:Add( self.CustomizePose.Pos )
		b_ang:Add( self.CustomizePose.Ang )
		b_pos:Mul( si )
		b_ang:Mul( si )

		opos:Add( b_pos )
		oang:Add( b_ang )

		local b_pos, b_ang = Vector(), Angle()
		local xi = si

		if xi >= 0.5 then
			xi = xi - 0.5
			xi = 0.5 - xi
		end
		xi = xi * 2

		b_pos:Add( Vector( -0.3, 0, 0.2 ) )
		b_ang:Add( Angle( -0.6, -0.3, -2 ) )
		b_pos:Mul( math.ease.InOutSine( xi ) )
		b_ang:Mul( math.ease.InOutSine( xi ) )

		opos:Add( b_pos )
		oang:Add( b_ang )
	end

	do -- sprinting
		local b_pos, b_ang = Vector(), Angle()
		local si = self:GetSprintDelta()

		--cancelsprint = math.Approach( cancelsprint, (self:GetStopSightTime() > CurTime() and 0 or 1), FrameTime() / 0.4 )
		--si = math.min(si, cancelsprint)

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
		
		if self:GetUserSight() then
			ss_si = math.ease.OutSine( si )
		else
			ss_si = math.ease.InOutSine( si )
		end

		b_pos:Add( self.IronsightPose.Pos )
		b_ang:Add( self.IronsightPose.Ang )
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

	if true then -- bobbing & swaying
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
		ox = math.Approach(ox, ox*(1-(math.min(FrameTime(), (1/4))*4)), math.huge)
		oy = math.Approach(oy, oy*(1-(math.min(FrameTime(), (1/4))*4)), math.huge)
		LASTAIM:Set(p:EyeAngles())

		local sii = self:GetSightDelta()
		b_ang.y = b_ang.y + ox*0.05*Lerp(sii, 1, 0.05)
		b_pos.x = b_pos.x + ox*0.033*Lerp(sii, 1, 0.05)

		b_pos.x = b_pos.x + ox*-0.01*Lerp(sii, 1, 0)

		b_ang.x = b_ang.x + oy*0.1*Lerp(sii, 1, 0.05)
		b_pos.z = b_pos.z + oy*-0.04*Lerp(sii, 1, 0.05)

		b_ang.z = b_ang.z + ((oy*-0.1) + (ox*-0.02))*Lerp(sii, 1, 0.1)

		b_ang.p = b_ang.p - self:GetRecoilP()
		b_ang.y = b_ang.y - self:GetRecoilY()

		b_pos.y = b_pos.y - ( math.sqrt(math.pow(self:GetRecoil2P(),2) + math.pow(self:GetRecoil2Y(),2)) * 0.1 )

		b_ang:Normalize()

		--b_ang:Mul( moove )

		opos:Add(b_pos)
		oang:Add(b_ang)
	end

	if true then -- up/down
		local b_pos, b_ang = Vector(), Angle()

		local l_down	= math.Clamp( math.TimeFraction( 5, 88, p:EyeAngles().x ), 0, 1 )
		local l_up		= math.Clamp( math.TimeFraction( -5, -88, p:EyeAngles().x ), 0, 1 )
		l_down	= math.ease.InSine( l_down )
		l_up	= math.ease.InCubic( l_up )

		b_pos.x = b_pos.x + -1.5 * l_down
		b_pos.z = b_pos.z + -1 * l_down
		b_pos.y = b_pos.y + 0.5 * l_down
		b_ang.z = b_ang.z + -5 * l_down

		b_pos.x = b_pos.x + -1 * l_up
		b_pos.z = b_pos.z + -0.5 * l_up
		b_pos.y = b_pos.y + -1 * l_up
		b_ang.z = b_ang.z + 2 * l_up

		b_pos:Mul( (1-self:GetSightDelta()) )
		b_ang:Mul( (1-self:GetSightDelta()) )

		opos:Add(b_pos)
		oang:Add(b_ang)
	end

	do -- hunger sway
		oang:Add(self:GetSwayAngle())
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
	local mo = (self.Movespeed or 1)
	if self:GetNextPrimaryFire() > CurTime() then
		mo = mo * (self.Movespeed_Firing or 0.85)
	end
	if self:GetSightDelta() > 0.5 then
		mo = mo * (self.Movespeed_ADS or 0.75)
	end

	return mo
end

hook.Add( "Move", "MFA_Movespeed", function( ply, mv )
	if ply and IsValid(ply) and IsValid(ply:GetActiveWeapon()) and ply:GetActiveWeapon().MFA then
		local speed = mv:GetMaxSpeed() * ply:GetActiveWeapon():GetMovespeed()
		mv:SetMaxSpeed( speed )
		mv:SetMaxClientSpeed( speed )
	end
end)

hook.Add( "StartCommand", "MFA_StartCommand", function( ply, ucmd )
	if ply and IsValid(ply) and IsValid(ply:GetActiveWeapon()) and ply:GetActiveWeapon().MFA then
		local wep = ply:GetActiveWeapon()
		if wep:GetHolster_Time() != 0 and wep:GetHolster_Time() <= CurTime() then
			if IsValid(wep:GetHolster_Entity()) then
				wep:SetHolster_Time(-math.huge)
				ucmd:SelectWeapon(wep:GetHolster_Entity())
			end
		end
	end
end)


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
local CHR_F = Color( 166, 255, 255, 255 )
local CHR_B = Color( 0, 0, 0, 100 )
local CHR_S = Color( 255, 255, 255, 255 )
local len = 5.0
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
		local clock = Lerp( math.max( self:GetSightDelta(), self:GetSprintDelta(), reloadclock, (custper or 0) ), 1, 0 )
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

	if dot then
		-- center
		surface.DrawRect( math.Round(( ScrW() / 2 ) - ( t / 2 ) + s), math.Round(( ScrH() / 2 ) - ( t / 2 ) + s), t, t )
	end

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

	if dot then
		-- center
		surface.DrawRect( math.Round(( ScrW() / 2 ) - ( t / 2 )), math.Round(( ScrH() / 2 ) - ( t / 2 )), t, t )
	end
	return true
end