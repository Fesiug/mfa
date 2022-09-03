
-- Fesiug, 2022

SWEP.Base					= "mfa_wep_base"
SWEP.Spawnable				= true

SWEP.Slot					= 2
SWEP.Category				= "MFA"	
SWEP.PrintName				= "Assault Carbine"
SWEP.Trivia = {
	Category = "Rifle",
	["Real Name"] = "G36C",
}

SWEP.UseHands				= true
SWEP.ViewModel				= "models/mfa/weapons/g36c.mdl"
SWEP.WorldModel				= "models/mfa/weapons/g36c.mdl"
SWEP.ViewModelFOV			= 70

SWEP.Primary.ClipSize		= 30
SWEP.Primary.Ammo			= "smg1"
SWEP.Primary.Sound			= ")weapons/iw3/g36c/fire.wav"

SWEP.DamageNear				= 30
SWEP.DamageFar				= 26
SWEP.RangeNear				= 20
SWEP.RangeFar				= 50

--
-- Recoil
--
SWEP.RecoilUp							= 2.5 -- degrees punched
SWEP.RecoilUpDecay						= 25 -- how much recoil to remove per second
SWEP.RecoilSide							= 0.6 -- degrees punched, in either direction (-100% to 100%)
SWEP.RecoilSideDecay					= 25 -- how much recoil to remove per second
SWEP.RecoilUpDrift						= 0.5 -- how much will be smooth recoil
SWEP.RecoilSideDrift					= 0.5 -- how much will be smooth recoil
SWEP.RecoilFlipChance					= ( 1 / 3 ) -- chance to flip recoil direction
SWEP.RecoilADSMult						= ( 3 / 4 ) -- multiply shot recoil by this amount when ads'd


SWEP.Dispersion				= 0.7
SWEP.Dispersion_Move		= 3 -- at 200 hu/s
SWEP.Dispersion_Air			= 4
SWEP.Dispersion_Crouch		= ( 2 / 3 )
SWEP.Dispersion_Sights		= ( 1 / 3 )

SWEP.Dispersion_FireShoot	= 0.4
SWEP.Dispersion_FireDecay	= 3


SWEP.Firemodes = {
	{
		Count = math.huge,
		Delay = 0.085,
	},
	{
		Count = 1,
		Delay = 0.085,
	}
}

SWEP.ActivePos = {
	Pos = Vector(0.2, -1, 0.2),
	Ang = Angle(),
}

SWEP.IronsightPos = {
	Pos = Vector(-2.39, -2, 0.45),
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
	},
	["fire_ads"] = {
		Source = "iron_fire",
	},
	["reload"] = {
		Source = "base_reload",
		Time = 3.5,
		LoadIn = 2.7,
	},
	["reload_empty"] = {
		Source = "base_reloadempty",
		Time = 4.2,
		LoadIn = 3.7,
	}
}