
-- Fesiug, 2022

SWEP.Base					= "mfa_base_wep"
SWEP.Spawnable				= true

SWEP.Slot					= 2
SWEP.Category				= "MFA"	
SWEP.PrintName				= "Submachine Gun Premium"
SWEP.Trivia = {
	Category = "Submachine Gun",
	["Real Name"] = "UMP",
}

SWEP.UseHands				= true
SWEP.ViewModel				= "models/mfa/weapons/mp5.mdl"
SWEP.WorldModel				= "models/mfa/weapons/mp5.mdl"
SWEP.ViewModelFOV			= 70

SWEP.Primary.ClipSize		= 25
SWEP.Primary.Ammo			= "pistol"
SWEP.Primary.Sound			= ")weapons/iw3/mp5/fire.wav"

SWEP.DamageNear				= 26
SWEP.DamageFar				= 17
SWEP.RangeNear				= 20
SWEP.RangeFar				= 40

--
-- Recoil
--
SWEP.RecoilUp							= 1.9 -- degrees punched
SWEP.RecoilUpDecay						= 23 -- how much recoil to remove per second
SWEP.RecoilSide							= 0.7 -- degrees punched, in either direction (-100% to 100%)
SWEP.RecoilSideDecay					= 23 -- how much recoil to remove per second
SWEP.RecoilUpDrift						= 0.7 -- how much will be smooth recoil
SWEP.RecoilSideDrift					= 0.7 -- how much will be smooth recoil
SWEP.RecoilFlipChance					= ( 1 / 6 ) -- chance to flip recoil direction
SWEP.RecoilADSMult						= ( 3 / 4 ) -- multiply shot recoil by this amount when ads'd

SWEP.Dispersion				= 0.8
SWEP.Dispersion_Move		= 2 -- at 200 hu/s
SWEP.Dispersion_Air			= 2
SWEP.Dispersion_Crouch		= ( 2 / 3 )
SWEP.Dispersion_Sights		= ( 1 / 3 )

SWEP.Dispersion_FireShoot	= 0.4
SWEP.Dispersion_FireDecay	= 3


SWEP.Firemodes = {
	{
		Count = math.huge,
		Delay = ( 60 / 700 ),
	},
	{
		Count = 2,
		Delay = ( 60 / 1200 ),
	},
	{
		Count = 1,
		Delay = ( 60 / 700 ),
	}
}

SWEP.ActivePos = {
	Pos = Vector(-0, 0, -0.4),
	Ang = Angle(),
}

SWEP.IronsightPos = {
	Pos = Vector(-2.31, -2, 0.45),
	Ang = Angle(0, 0, 0),
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
		LoadIn = 2.0,
	},
	["reload_empty"] = {
		Source = "base_reloadempty",
		Time = 3.7,
		LoadIn = 3.1,
	}
}