
-- Fesiug, 2022

SWEP.Base					= "mfa_base_wep"
SWEP.Spawnable				= true

SWEP.Slot					= 1
SWEP.Category				= "MFA"	
SWEP.PrintName				= "Gavel AUTO-50"
SWEP.Trivia = {
	Category = "Sidearm",
	["Real Name"] = "Desert Eagle",
}

SWEP.UseHands				= true
SWEP.ViewModel				= "models/mfa/weapons/deagle.mdl"
SWEP.WorldModel				= "models/mfa/weapons/m1911.mdl"
SWEP.ViewModelFOV			= 70

SWEP.Primary.ClipSize		= 7
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

SWEP.DamageNear				= 44
SWEP.DamageFar				= 26
SWEP.RangeNear				= 20
SWEP.RangeFar				= 50

--
-- Recoil
--
SWEP.RecoilUp							= 7.5 -- degrees punched
SWEP.RecoilUpDecay						= 42 -- how much recoil to remove per second
SWEP.RecoilSide							= 3.8 -- degrees punched, in either direction (-100% to 100%)
SWEP.RecoilSideDecay					= 42 -- how much recoil to remove per second
SWEP.RecoilUpDrift						= 0.4 -- how much will be smooth recoil
SWEP.RecoilSideDrift					= 0.4 -- how much will be smooth recoil
SWEP.RecoilFlipChance					= ( 2 / 3 ) -- chance to flip recoil direction
SWEP.RecoilADSMult						= ( 3 / 4 ) -- multiply shot recoil by this amount when ads'd

-- after the fact
SWEP.Recoil2UpDrift						= 0.4 -- how much to return to the original pos
SWEP.Recoil2SideDrift					= 0.4
SWEP.Recoil2UpDecay						= 16 -- how much recoil to remove per second
SWEP.Recoil2SideDecay					= 16 


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
		Delay = ( 60 / 250 ),
	}
}

SWEP.ActivePose = {
	Pos = Vector(0.2, -4, -0.1),
	Ang = Angle(),
}

SWEP.IronsightPose = {
	Pos = Vector(-1.85, -4.8, 0.26),
	Ang = Angle(0.3, 0, 0),
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
		Source = "base_fire",
		Time = 1.5,
	},
	["fire_ads"] = {
		Source = "iron_fire_1",
	},
	["reload"] = {
		Source = "base_reload",
		Events = {
			{ t = 0, s = "weapons/iw3/de50/lift.wav" },
			{ t = 0.5, s = "weapons/iw3/de50/out.wav" },
			{ t = 2.0, s = "weapons/iw3/de50/in.wav" },
		},
		Time = 3.2,
		LoadIn = 2.1,
		ReloadingTime = 3.0,
		StopSightTime = 2.5,
	},
	["reload_empty"] = {
		Source = "base_reloadempty",
		Events = {
			{ t = 0, s = "weapons/iw3/de50/lift.wav" },
			{ t = 0.5, s = "weapons/iw3/de50/out.wav" },
			{ t = 1.7, s = "weapons/iw3/de50/in.wav" },
			{ t = 2.3, s = "weapons/iw3/de50/slide.wav" },
		},
		Time = 3.4,
		LoadIn = 2.3,
		ReloadingTime = 3.1,
		StopSightTime = 2.7,
	}
}