
-- Fesiug, 2022

SWEP.Base					= "mfa_wep_base"
SWEP.Spawnable				= true

SWEP.Slot					= 2
SWEP.Category				= "MFA"	
SWEP.PrintName				= "Assault Rifle"
SWEP.Trivia = {
	Category = "Rifle",
	["Real Name"] = "M16A4",
}

SWEP.UseHands				= true
SWEP.ViewModel				= "models/weapons/c_iw3_m16a4.mdl"
SWEP.WorldModel				= "models/weapons/w_iw3_m16a4.mdl"
SWEP.ViewModelFOV			= 70

SWEP.Primary.ClipSize		= 30
SWEP.Primary.Ammo			= "smg1"
SWEP.Primary.Sound			= ")weapons/iw3/m4a1/fire.wav"

SWEP.DamageNear				= 30
SWEP.DamageFar				= 26
SWEP.RangeNear				= 20
SWEP.RangeFar				= 50

SWEP.Firemodes = {
	{
		Count = 3,
		Delay = 0.07,
		PostBurstDelay = 0.2,
	},
	{
		Count = 1,
		Delay = 0.07,
	}
}

SWEP.ActivePos = {
	Pos = Vector(0.2, -1, 0.2),
	Ang = Angle(),
}

SWEP.IronsightPos = {
	Pos = Vector(-2.535, -3, 0.0),
	Ang = Angle(0.5, 0, 0),
}

SWEP.Animations = {
	["idle"] = {
		Source = "idle",
	},
	["draw"] = {
		Source = "draw",
	},
	["holster"] = {
		Source = "holster",
	},
	["fire"] = {
		Source = "fire",
	},
	["fire_ads"] = {
		Source = "fire_iron",
	},
	["reload"] = {
		Source = "reload",
		Time = 2.9,
		LoadIn = 2.7,
	},
	["reload_empty"] = {
		Source = "reload_empty",
		Time = 4.2,
		LoadIn = 3.7,
	}
}