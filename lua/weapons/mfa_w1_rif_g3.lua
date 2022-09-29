
-- Fesiug, 2022

SWEP.Base					= "mfa_base_wep"
SWEP.Spawnable				= true

SWEP.Slot					= 2
SWEP.Category				= "MFA"
SWEP.PrintName				= "K&M AG63"
SWEP.Trivia = {
	Category = "Rifle",
	["Real Name"] = "G3A3",
}
SWEP.MFAsys = {
	Weight = 5,
	Size = "verylarge",
}

SWEP.UseHands				= true
SWEP.ViewModel				= "models/mfa/weapons/g3.mdl"
SWEP.WorldModel				= "models/mfa/weapons/g3.mdl"
SWEP.ViewModelFOV			= 70

SWEP.Primary.ClipSize		= 20
SWEP.Primary.Ammo			= "ar2"
SWEP.Sound_Fire				= {
	{
		s = {
			")mfa/dk2/wep/ak103_fire_01.ogg",
			")mfa/dk2/wep/ak103_fire_02.ogg",
			")mfa/dk2/wep/ak103_fire_03.ogg",
		},
		sl = 90,
		v = 1,
		p = 95,
		pm = 105,
		c = CHAN_STATIC,
	},
	{
		s = {
			")mfa/fesiug/sweet/g3sg1.ogg",
		},
		sl = 50,
		v = 0.5,
		p = 95,
		pm = 105,
		c = CHAN_STATIC,
	},
}
SWEP.Sound_Dry = { s = "mfa/wep/dry/rifle_high.ogg", sl = 50, v = 0.5, p = 100 }


SWEP.DamageNear				= 36
SWEP.DamageFar				= 30
SWEP.RangeNear				= 40
SWEP.RangeFar				= 80

--
-- Recoil
--
SWEP.RecoilUp							= 4.8 -- degrees punched
SWEP.RecoilSide							= 1.9 -- degrees punched, in either direction (-100% to 100%)
SWEP.RecoilDrift						= 0.4 -- how much will be smooth recoil
SWEP.RecoilDecay						= 20 -- how much recoil to remove per second
SWEP.RecoilADSMult						= ( 1 / 3 ) -- multiply shot recoil by this amount when ads'd

-- after the fact
SWEP.Recoil2Drift						= 0.3 -- how much to return to the original pos
SWEP.Recoil2Decay						= 12 -- how much recoil to remove per second


SWEP.Dispersion				= 0.3
SWEP.Dispersion_Move		= 4 -- at 200 hu/s
SWEP.Dispersion_Air			= 5
SWEP.Dispersion_Crouch		= ( 2 / 3 )
SWEP.Dispersion_Sights		= ( 1 / 3 )

SWEP.Dispersion_FireShoot	= 1.3
SWEP.Dispersion_FireDecay	= 7

SWEP.Movespeed							= 0.88
SWEP.Movespeed_Firing					= 0.78
SWEP.Movespeed_ADS						= 0.68

SWEP.Firemodes = {
	{
		Count = math.huge,
		Delay = ( 60 / 500 )
	},
	{
		Count = 1,
		Delay = ( 60 / 500 )
	}
}

SWEP.ActivePose = {
	Pos = Vector(0.2, -1, -0.2),
	Ang = Angle(),
}

SWEP.IronsightPose = {
	Pos = Vector(-2.07, -3, 0.55),
	Ang = Angle(0, 0, 0),
	Mag = 1.3,
}

SWEP.CustomizePose = {
	Pos = Vector(1, -0.3, -0.3),
	Ang = Angle(6, 6, 0),
}

SWEP.MuzzleEffect						= "muzzleflash_3"
SWEP.QCA_Muzzle							= 1
SWEP.QCA_Case							= 3

SWEP.ShellModel							= "models/shells/shell_762nato.mdl"
SWEP.ShellScale							= 1

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
		Events = {
			{ t = 0, shell = true }
		},
		Time = 1.5,
	},
	["fire_ads"] = {
		Source = { "iron_fire", "iron_fire_a", "iron_fire_b", "iron_fire_c", "iron_fire_d", "iron_fire_e", "iron_fire_f" },
		Events = {
			{ t = 0, shell = true }
		},
		Time = 1.5,
	},
	["reload"] = {
		Source = "base_reload",
		Events = {
			{ t = 0, s = "mfa/zenith/ogg/raise.ogg" },
			{ t = 0.2, s = "mfa/wep/ogg/Reload_1P_AK12_Grab_Wave 0 0 0.ogg" },
			{ t = 0.4, s = "mfa/wep/ogg/Reload_1P_AK12_Magout_Wave 0 0 0.ogg" },
			{ t = 2.0, s = "mfa/zenith/ogg/magpouch.ogg" },
			{ t = 2.4, s = "mfa/wep/ogg/Reload_1P_AK12_Magin_Wave 0 0 0.ogg" },
			{ t = 2.7, s = "mfa/zenith/ogg/cloth_soft_1.ogg", v = 0.5 },
		},
		Time = 3.3,
		LoadIn = 2.9,
		StopSightTime = 3.2,
	},
	["reload_empty"] = {
		Source = "base_reloadempty",
		Events = {
			{ t = 0, s = "mfa/zenith/ogg/raise.ogg" },
			{ t = 0.2, s = "mfa/wep/ogg/Reload_1P_CZ805_Bolt_Wave 0 0 0.ogg" },
			{ t = 1.2, s = "mfa/wep/ogg/Reload_1P_AK12_Grab_Wave 0 0 0.ogg" },
			{ t = 1.3, s = "mfa/wep/ogg/Reload_1P_AK12_Magout_Wave 0 0 0.ogg" },
			{ t = 2.7, s = "mfa/zenith/ogg/magpouch.ogg" },
			{ t = 3.0, s = "mfa/wep/ogg/Reload_1P_AK12_Magin_Wave 0 0 0.ogg" },
			{ t = 3.9, s = "mfa/wep/ogg/Reload_1P_AK12_Bolt_Wave 0 0 0.ogg" },
			{ t = 4.5, s = "mfa/zenith/ogg/cloth_soft_1.ogg", v = 0.5 },
		},
		Time = 4.6,
		LoadIn = 3.9,
		StopSightTime = 4.5,
	}
}