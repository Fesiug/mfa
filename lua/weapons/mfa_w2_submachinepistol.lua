
-- Fesiug, 2022

SWEP.Base					= "mfa_base_wep"
SWEP.Spawnable				= true

SWEP.Slot					= 3
SWEP.Category				= "MFA"	
SWEP.PrintName				= "Submachine Pistol"
SWEP.Trivia = {
	Category = "Submachine Gun",
	["Real Name"] = "MP9",
}

SWEP.UseHands				= true
SWEP.ViewModel				= "models/mfa/weapons/mp9n.mdl"
SWEP.WorldModel				= "models/mfa/weapons/mp9n.mdl"
SWEP.ViewModelFOV			= 70

SWEP.Primary.ClipSize		= 20
SWEP.Primary.Ammo			= "pistol"
SWEP.Primary.Sound			= ")weapons/iw4/tmp/fire.wav"

SWEP.DamageNear				= 24
SWEP.DamageFar				= 16
SWEP.RangeNear				= 20
SWEP.RangeFar				= 40

--
-- Recoil
--
SWEP.RecoilUp							= 1.3 -- degrees punched
SWEP.RecoilUpDecay						= 25 -- how much recoil to remove per second
SWEP.RecoilSide							= 0.8 -- degrees punched, in either direction (-100% to 100%)
SWEP.RecoilSideDecay					= 25 -- how much recoil to remove per second
SWEP.RecoilUpDrift						= 0.5 -- how much will be smooth recoil
SWEP.RecoilSideDrift					= 0.5 -- how much will be smooth recoil
SWEP.RecoilFlipChance					= ( 3 / 4 ) -- chance to flip recoil direction
SWEP.RecoilADSMult						= ( 3 / 4 ) -- multiply shot recoil by this amount when ads'd

SWEP.Dispersion				= 1.1
SWEP.Dispersion_Move		= 2 -- at 200 hu/s
SWEP.Dispersion_Air			= 2
SWEP.Dispersion_Crouch		= ( 2 / 3 )
SWEP.Dispersion_Sights		= ( 1 / 3 )

SWEP.Dispersion_FireShoot	= 0.4
SWEP.Dispersion_FireDecay	= 3


SWEP.Firemodes = {
	{
		Count = math.huge,
		Delay = 0.07,
	},
	{
		Count = 1,
		Delay = 0.07,
	}
}

SWEP.ActivePos = {
	Pos = Vector(0.2, 0, 0.4),
	Ang = Angle(),
}

SWEP.IronsightPos = {
	Pos = Vector(-2.69, -2, 1.91),
	Ang = Angle(0.1, -0.2, 0),
}

SWEP.Animations = {
	["idle"] = {
		Source = "base_idle",
	},
	["draw"] = {
		Source = "base_draw",
	},
	["holster"] = {
		Source = "base_holster",
	},
	["fire"] = {
		Source = "base_fire",
	},
	["fire_ads"] = {
		Source = "iron_fire",
	},
	["reload"] = {
		Source = "base_reload",
		Time = 2.8,
		LoadIn = 1.8,
		StopSightTime = 2.0,
	},
	["reload_empty"] = {
		Source = "base_reloadempty",
		Time = 3.5,
		LoadIn = 2.5,
		StopSightTime = 2.8,
	}
}