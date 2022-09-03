
-- Fesiug, 2022

SWEP.Base					= "mfa_wep_base"
SWEP.Spawnable				= true

SWEP.Slot					= 2
SWEP.Category				= "MFA"
SWEP.PrintName				= "Battle Rifle"
SWEP.Trivia = {
	Category = "Rifle",
	["Real Name"] = "G3",
}

SWEP.UseHands				= true
SWEP.ViewModel				= "models/mfa/weapons/g3.mdl"
SWEP.WorldModel				= "models/mfa/weapons/g3.mdl"
SWEP.ViewModelFOV			= 70

SWEP.Primary.ClipSize		= 20
SWEP.Primary.Ammo			= "ar2"
SWEP.Primary.Sound			= ")weapons/iw3/g3/fire.wav"

SWEP.DamageNear				= 34
SWEP.DamageFar				= 30
SWEP.RangeNear				= 20
SWEP.RangeFar				= 80

--
-- Recoil
--
SWEP.RecoilUp							= 1.5 -- degrees punched
SWEP.RecoilUpDecay						= 30 -- how much recoil to remove per second
SWEP.RecoilSide							= 0.5 -- degrees punched, in either direction (-100% to 100%)
SWEP.RecoilSideDecay					= 30 -- how much recoil to remove per second
SWEP.RecoilUpDrift						= 0.5 -- how much will be smooth recoil
SWEP.RecoilSideDrift					= 0.5 -- how much will be smooth recoil
SWEP.RecoilFlipChance					= ( 2 / 3 ) -- chance to flip recoil direction
SWEP.RecoilADSMult						= ( 1 / 3 ) -- multiply shot recoil by this amount when ads'd


SWEP.Dispersion				= 0.3
SWEP.Dispersion_Move		= 4 -- at 200 hu/s
SWEP.Dispersion_Air			= 5
SWEP.Dispersion_Crouch		= ( 2 / 3 )
SWEP.Dispersion_Sights		= ( 1 / 3 )

SWEP.Dispersion_FireShoot	= 1
SWEP.Dispersion_FireDecay	= 5


SWEP.Firemodes = {
	{
		Count = 1,
		Delay = 0.12,
	}
}

SWEP.ActivePos = {
	Pos = Vector(0.2, -1, -0.2),
	Ang = Angle(),
}

SWEP.IronsightPos = {
	Pos = Vector(-2.07, -3, 0.55),
	Ang = Angle(0, 0, 0),
}

SWEP.Animations = {
	["idle"] = {
		Source = "base_idle",
	},
	["draw"] = {
		Source = "base_draw",
		Time = 0.8,
		ReloadingTime = 0.5,
	},
	["holster"] = {
		Source = "base_holster",
	},
	["fire"] = {
		Source = "base_fire",
		Time = 1.5,
	},
	["fire_ads"] = {
		Source = "iron_fire",
	},
	["reload"] = {
		Source = "base_reload",
		Time = 3.9,
		LoadIn = 2.9,
	},
	["reload_empty"] = {
		Source = "base_reloadempty",
		Time = 5.2,
		LoadIn = 3.9,
	}
}