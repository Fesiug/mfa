
-- Fesiug, 2022

SWEP.Base					= "mfa_base_wep"
SWEP.Spawnable				= true

SWEP.Slot					= 1
SWEP.Category				= "MFA"	
SWEP.PrintName				= "MATArms Rhino"
SWEP.Trivia = {
	Category = "Sidearm",
	["Real Name"] = "Rhino 60DS",
}

SWEP.UseHands				= true
SWEP.ViewModel				= "models/mfa/weapons/rhino.mdl"
SWEP.WorldModel				= "models/mfa/weapons/rhino.mdl"
SWEP.ViewModelFOV			= 70

SWEP.Primary.ClipSize		= 6
SWEP.Primary.Ammo			= "357"
SWEP.Sound_Fire				= {
	{
		s = {
			")mfa/dk2/wep/1911_fire_01.ogg",
			")mfa/dk2/wep/1911_fire_02.ogg",
			")mfa/dk2/wep/1911_fire_03.ogg",
		},
		sl = 90,
		v = 1,
		p = 95,
		pm = 105,
		c = CHAN_STATIC,
	},
	{
		s = {
			")mfa/fesiug/sweet/usp.ogg",
		},
		sl = 50,
		v = 1,
		p = 95,
		pm = 105,
		c = CHAN_STATIC,
	},
}
SWEP.Sound_Dry = { s = "mfa/wep/dry/pistol_high.ogg", sl = 50, v = 0.5, p = 100 }

SWEP.DamageNear				= 36
SWEP.DamageFar				= 20
SWEP.RangeNear				= 25
SWEP.RangeFar				= 50

--
-- Recoil
--
SWEP.RecoilUp							= 7.5 -- degrees punched
SWEP.RecoilSide							= 3.8 -- degrees punched, in either direction (-100% to 100%)
SWEP.RecoilDrift						= 0.4 -- how much will be smooth recoil
SWEP.RecoilDecay						= 42 -- how much recoil to remove per second
SWEP.RecoilADSMult						= ( 3 / 4 ) -- multiply shot recoil by this amount when ads'd

-- after the fact
SWEP.Recoil2Drift						= 0.4 -- how much to return to the original pos
SWEP.Recoil2Decay						= 16 -- how much recoil to remove per second


SWEP.Dispersion				= 0.5
SWEP.Dispersion_Move		= 4 -- at 200 hu/s
SWEP.Dispersion_Air			= 5
SWEP.Dispersion_Crouch		= ( 2 / 3 )
SWEP.Dispersion_Sights		= ( 1 / 3 )

SWEP.Dispersion_FireShoot	= 2
SWEP.Dispersion_FireDecay	= 10

SWEP.Movespeed							= 0.98
SWEP.Movespeed_Firing					= 0.88
SWEP.Movespeed_ADS						= 0.88

SWEP.Firemodes = {
	{
		Count = 1,
		Delay = ( 60 / 350 ),
	}
}

SWEP.ActivePose = {
	Pos = Vector(-0.4, -1, -1.4),
	Ang = Angle(),
}

SWEP.RunPose = {
	Pos = Vector(-0.4, -1, -1.4),
	Ang = Angle(-12, 12, -12),
}

SWEP.IronsightPose = {
	Pos = Vector(-2.7, -4.8, -0.03),
	Ang = Angle(0.1, 0, 0),
}

SWEP.CustomizePose = {
	Pos = Vector(0.9, -2, -0.7),
	Ang = Angle(8, 9, 2),
}

SWEP.MuzzleEffect						= "muzzleflash_3"
SWEP.QCA_Muzzle							= 1
SWEP.QCA_Case							= 3

SWEP.ShellModel							= "models/shells/shell_9mm.mdl"
SWEP.ShellScale							= 1

SWEP.Animations = {
	["idle"] = {
		Source = "base_idle",
	},
	["draw"] = {
		Source = "base_draw",
		Events = {
			{ t = 0, s = "mfa/zenith/ogg/draw.ogg" },
		},
		Time = 0.5,
		ReloadingTime = 0.3,
		StopSightTime = 0.3,
	},
	["holster"] = {
		Source = "base_holster",
		Events = {
			{ t = 0, s = "mfa/zenith/ogg/shoulder.ogg" },
		},
		Time = 0.4,
		HolsterTime = 0.15,
	},
	["fire"] = {
		Source = { "base_fire", "base_fire2" },
		Time = 0.6,
	},
	["reload"] = {
		Source = "base_reload_speed",
		Events = {
			{ t = 0.05, s = "mfa/wep/ogg/Reload_1P_PP2000_Bolt_Wave 0 0 0.ogg", v = 0.5 },
			{ t = 0.6, s = "mfa/wep/ogg/Reload_1P_SV98_Magout_Wave 0 0 0.ogg" },
			{ t = 1.7, s = "mfa/wep/ogg/Reload_1P_SV98_Magin_Wave 0 0 0.ogg" },
			{ t = 2.3, s = "mfa/wep/ogg/Reload_1P_AK5_BoltClose_Wave 1 1 0.ogg", v = 0.5 },
		},
		Time = 3.9,
		ReloadingTime = 0.6,
		LoadIn = 0.2,
	},
}