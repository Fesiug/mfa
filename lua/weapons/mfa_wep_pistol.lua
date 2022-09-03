
-- Fesiug, 2022

SWEP.Base					= "mfa_wep_base"
SWEP.Spawnable				= true

SWEP.Slot					= 1
SWEP.Category				= "MFA"	
SWEP.PrintName				= "Pistol"
SWEP.Trivia = {
	Category = "Sidearm",
	["Real Name"] = "Browning HP",
}

SWEP.UseHands				= true
SWEP.ViewModel				= "models/mfa/weapons/browninghp.mdl"
SWEP.WorldModel				= "models/mfa/weapons/browninghp.mdl"
SWEP.ViewModelFOV			= 70

SWEP.Primary.ClipSize		= 12
SWEP.Primary.Ammo			= "pistol"
SWEP.Primary.Sound			= ")weapons/iw3/beretta/fire.wav"

SWEP.DamageNear				= 30
SWEP.DamageFar				= 26
SWEP.RangeNear				= 20
SWEP.RangeFar				= 50

--
-- Recoil
--
SWEP.RecoilUp							= 2.5 -- degrees punched
SWEP.RecoilUpDecay						= 30 -- how much recoil to remove per second
SWEP.RecoilSide							= 1.5 -- degrees punched, in either direction (-100% to 100%)
SWEP.RecoilSideDecay					= 30 -- how much recoil to remove per second
SWEP.RecoilUpDrift						= 0.5 -- how much will be smooth recoil
SWEP.RecoilSideDrift					= 0.5 -- how much will be smooth recoil
SWEP.RecoilFlipChance					= ( 2 / 3 ) -- chance to flip recoil direction
SWEP.RecoilADSMult						= ( 3 / 4 ) -- multiply shot recoil by this amount when ads'd

-- after the fact
SWEP.Recoil2UpDrift						= 0.6 -- how much to return to the original pos
SWEP.Recoil2SideDrift					= 0.6
SWEP.Recoil2UpDecay						= 15 -- how much recoil to remove per second
SWEP.Recoil2SideDecay					= 15 


SWEP.Dispersion				= 0.3
SWEP.Dispersion_Move		= 4 -- at 200 hu/s
SWEP.Dispersion_Air			= 5
SWEP.Dispersion_Crouch		= ( 2 / 3 )
SWEP.Dispersion_Sights		= ( 1 / 3 )

SWEP.Dispersion_FireShoot	= 2
SWEP.Dispersion_FireDecay	= 10

SWEP.Firemodes = {
	{
		Count = 1,
		Delay = 0.15,
	}
}

SWEP.ActivePos = {
	Pos = Vector(0.2, -1, 0.2),
	Ang = Angle(),
}

SWEP.IronsightPos = {
	Pos = Vector(-2.44, -3, 1.26),
	Ang = Angle(0.5, 0, 0),
}

SWEP.Animations = {
	["idle"] = {
		Source = "base_idle",
	},
	["draw"] = {
		Source = "base_draw",
		Time = 0.8,
		ReloadingTime = 0.5,
		StopSightTime = 0.3,
	},
	["holster"] = {
		Source = "base_holster",
	},
	["fire"] = {
		Source = "base_fire",
		Time = 1.5,
	},
	["fire_ads"] = {
		Source = "iron_fire_1",
	},
	["reload"] = {
		Source = "base_reload",
		Time = 3.2,
		LoadIn = 2.1,
		ReloadingTime = 3.0,
		StopSightTime = 2.5,
	},
	["reload_empty"] = {
		Source = "base_reloadempty",
		Time = 3.4,
		LoadIn = 2.3,
		ReloadingTime = 3.1,
		StopSightTime = 2.7,
	}
}