
-- Fesiug, 2022

SWEP.Base					= "mfa_base_wep"
SWEP.Spawnable				= true

SWEP.Slot					= 2
SWEP.Category				= "MFA"	
SWEP.PrintName				= "K&M NE36"
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
SWEP.Sound_Fire				= {
	{
		s = {
			")mfa/dk2/wep/mk17cqc_fire_01.ogg",
			")mfa/dk2/wep/mk17cqc_fire_02.ogg",
			")mfa/dk2/wep/mk17cqc_fire_03.ogg",
		},
		sl = 90,
		v = 1,
		p = 95,
		pm = 105,
		c = CHAN_STATIC,
	},
	{
		s = {
			")mfa/fesiug/sweet/m4a1.ogg",
		},
		sl = 50,
		v = 0.22,
		p = 105,
		pm = 115,
		c = CHAN_STATIC,
	},
	{
		s = {
			")mfa/fesiug/sweet/galil.ogg",
		},
		sl = 50,
		v = 0.75,
		p = 95,
		pm = 105,
		c = CHAN_STATIC,
	},
}
SWEP.Sound_Dry = { s = "mfa/wep/dry/rifle.ogg", sl = 50, v = 0.5, p = 100 }

SWEP.DamageNear				= 30
SWEP.DamageFar				= 26
SWEP.RangeNear				= 20
SWEP.RangeFar				= 50

--
-- Recoil
--
SWEP.RecoilUp							= 2.5 -- degrees punched
SWEP.RecoilSide							= 0.6 -- degrees punched, in either direction (-100% to 100%)
SWEP.RecoilDrift						= 0.5 -- how much will be smooth recoil
SWEP.RecoilDecay						= 25 -- how much recoil to remove per second
SWEP.RecoilADSMult						= ( 3 / 4 ) -- multiply shot recoil by this amount when ads'd

-- after the fact
SWEP.Recoil2Drift						= 0.1 -- how much to return to the original pos
SWEP.Recoil2Decay						= 23 -- how much recoil to remove per second


SWEP.Dispersion				= 0.7
SWEP.Dispersion_Move		= 3 -- at 200 hu/s
SWEP.Dispersion_Air			= 4
SWEP.Dispersion_Crouch		= ( 2 / 3 )
SWEP.Dispersion_Sights		= ( 1 / 3 )

SWEP.Dispersion_FireShoot	= 0.7
SWEP.Dispersion_FireDecay	= 6

SWEP.Movespeed							= 0.92
SWEP.Movespeed_Firing					= 0.82
SWEP.Movespeed_ADS						= 0.72

SWEP.Firemodes = {
	{
		Count = math.huge,
		Delay = ( 60 / 700 ),
	},
	{
		Count = 1,
		Delay = ( 60 / 1200 )
	}
}

SWEP.ActivePose = {
	Pos = Vector(0.2, -1, 0.2),
	Ang = Angle(),
}

SWEP.IronsightPose = {
	Pos = Vector(-2.39, -2, 0.45),
	Ang = Angle(0, 0, 0),
	Mag = 1.3,
}

SWEP.CustomizePose = {
	Pos = Vector(0.5, -1, -0.5),
	Ang = Angle(12, 6, 0),
}

SWEP.MuzzleEffect						= "muzzleflash_5"
SWEP.QCA_Muzzle							= 1
SWEP.QCA_Case							= 3

SWEP.ShellModel							= "models/shells/shell_556.mdl"
SWEP.ShellScale							= 1

SWEP.Animations = {
	["idle"] = {
		Source = "base_idle",
	},
	["draw"] = {
		Source = "base_draw",
		Events = {
			{ t = 0, s = "mfa/zenith/ogg/cloth_2.ogg" },
			{ t = 0.1, s = "mfa/zenith/ogg/shoulder.ogg" },
		},
		Time = 0.8,
		ReloadingTime = 0.6,
	},
	["holster"] = {
		Source = "base_holster",
		Events = {
			{ t = 0, s = "mfa/zenith/ogg/cloth_1.ogg" },
		},
		HolsterTime = 0.4,
	},
	["fire"] = {
		Source = "base_fire",
		Events = {
			{ t = 0, shell = true }
		},
	},
	["fire_ads"] = {
		Source = { "iron_fire", "iron_fire_a", "iron_fire_b", "iron_fire_c", "iron_fire_d", "iron_fire_e", "iron_fire_f" },
		Events = {
			{ t = 0, shell = true }
		},
	},
	["reload"] = {
		Source = "base_reload",
		Events = {
			{ t = 0, s = "mfa/zenith/ogg/raise.ogg" },
			{ t = 0.3, s = "mfa/wep/ogg/Reload_1P_SG553_Magout_Wave 0 0 0.ogg", v = 0.5 },
			{ t = 1.3, s = "mfa/zenith/ogg/cloth_soft_3.ogg", v = 0.2 },
			{ t = 1.5, s = "mfa/zenith/ogg/magpouch.ogg" },
			{ t = 2.2, s = "mfa/wep/ogg/Reload_1P_SG553_Magin_Wave 0 0 0.ogg", v = 0.5 },
			{ t = 2.6, s = "mfa/zenith/ogg/cloth_soft_1.ogg", v = 0.5 },
			{ t = 2.9, s = "mfa/zenith/ogg/magimpact.ogg" },
		},
		Time = 3.5,
		LoadIn = 2.9,
	},
	["reload_empty"] = {
		Source = "base_reloadempty",
		Events = {
			{ t = 0.3, s = "mfa/wep/ogg/Reload_1P_SG553_Magout_Wave 0 0 0.ogg", v = 0.5 },
			{ t = 1.3, s = "mfa/zenith/ogg/cloth_soft_3.ogg", v = 0.2 },
			{ t = 1.5, s = "mfa/zenith/ogg/magpouch.ogg" },
			{ t = 2.05, s = "mfa/wep/ogg/Reload_1P_SG553_Magin_Wave 0 0 0.ogg", v = 0.5 },
			{ t = 2.6, s = "mfa/wep/ogg/Reload_1P_AEK971_Bolt_Wave 0 0 0.ogg", v = 0.5 },
			{ t = 2.8, s = "mfa/zenith/ogg/cloth_soft_1.ogg", v = 0.5 },
			{ t = 3.0, s = "mfa/zenith/ogg/magimpact.ogg" },
		},
		Time = 4.2,
		LoadIn = 3.7,
	}
}