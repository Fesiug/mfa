
-- Fesiug, 2022

SWEP.Base					= "mfa_base_wep"
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
		Delay = ( 60 / 500 )
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
		Events = {
			{ t = 0, s = "weapons/iw3/g3/lift.wav" },
			{ t = 0.7, s = "weapons/iw3/g3/out.wav" },
			{ t = 2.8, s = "weapons/iw3/g3/in.wav" },
		},
		Time = 3.7,
		LoadIn = 2.9,
	},
	["reload_empty"] = {
		Source = "base_reloadempty",
		Events = {
			{ t = 0, s = "weapons/iw3/g3/lift.wav" },
			{ t = 0.5, s = "weapons/iw3/g3/chamber.wav" },
			{ t = 1.8, s = "weapons/iw3/g3/out.wav" },
			{ t = 3.4, s = "weapons/iw3/g3/in.wav" },
			{ t = 4.6, s = "weapons/iw3/g3/chamber.wav" },
		},
		Time = 4.9,
		LoadIn = 3.9,
	}
}