
-- Fesiug, 2022

SWEP.Base					= "mfa_base_wep"
SWEP.Spawnable				= true

SWEP.Slot					= 2
SWEP.Category				= "MFA"	
SWEP.PrintName				= "Assault Rifle"
SWEP.Trivia = {
	Category = "Rifle",
	["Real Name"] = "M16A4",
}

SWEP.UseHands				= true
SWEP.ViewModel				= "models/mfa/weapons/m16a4.mdl"
SWEP.WorldModel				= "models/mfa/weapons/m16a4.mdl"
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
		Runoff = true,
	},
	{
		Count = 1,
		Delay = 0.07,
	}
}

SWEP.ActivePos = {
	Pos = Vector(0.2, -1, 0.8),
	Ang = Angle(),
}

SWEP.IronsightPos = {
	Pos = Vector(-2.42, -3, 1.04),
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
		Events = {
			{ t = 0, s = "weapons/iw3/m4a1/lift.wav" },
			{ t = 0.5, s = "weapons/iw3/m4a1/out.wav" },
			{ t = 1.8, s = "weapons/iw3/m4a1/in.wav" },
			{ t = 2.4, s = "weapons/iw3/m4a1/hit.wav" },
		},
		Time = 4.0,
		LoadIn = 2.5,
	},
	["reload_empty"] = {
		Source = "base_reloadempty",
		Events = {
			{ t = 0, s = "weapons/iw3/m4a1/lift.wav" },
			{ t = 0.5, s = "weapons/iw3/m4a1/out.wav" },
			{ t = 1.8, s = "weapons/iw3/m4a1/in.wav" },
			{ t = 2.9, s = "weapons/iw3/m4a1/hit.wav" },
		},
		Time = 4.6,
		LoadIn = 3.5,
	}
}