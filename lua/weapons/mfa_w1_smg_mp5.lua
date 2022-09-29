
-- Fesiug, 2022

SWEP.Base					= "mfa_base_wep"
SWEP.Spawnable				= true

SWEP.Slot					= 2
SWEP.Category				= "MFA"	
SWEP.PrintName				= "K&M SMG-1"
SWEP.Trivia = {
	Category = "Submachine Gun",
	Description = "",
	["Real Name"] = "MP5A3",
}
SWEP.MFAsys = {
	Weight = 3,
	Size = "large",
}

SWEP.UseHands				= true
SWEP.ViewModel				= "models/mfa/weapons/mp5.mdl"
SWEP.WorldModel				= "models/mfa/weapons/mp5.mdl"
SWEP.ViewModelFOV			= 70

SWEP.Primary.ClipSize		= 30
SWEP.Primary.Ammo			= "pistol"
SWEP.Sound_Fire				= {
	{
		s = {
			")mfa/dk2/wep/mp5a_fire_01.ogg",
			")mfa/dk2/wep/mp5a_fire_02.ogg",
			")mfa/dk2/wep/mp5a_fire_03.ogg",
		},
		sl = 90,
		v = 1,
		p = 95,
		pm = 105,
		c = CHAN_STATIC,
	},
	{
		s = {
			")mfa/fesiug/sweet/mp5.ogg",
		},
		sl = 50,
		v = 0.75,
		p = 95,
		pm = 105,
		c = CHAN_STATIC,
	},
}
SWEP.Sound_Dry = { s = "mfa/wep/dry/smg.ogg", sl = 50, v = 0.5, p = 100 }


SWEP.DamageNear				= 20
SWEP.DamageFar				= 10
SWEP.RangeNear				= 20
SWEP.RangeFar				= 40

--
-- Recoil
--
SWEP.RecoilUp							= 1.7 -- degrees punched
SWEP.RecoilSide							= 0.6 -- degrees punched, in either direction (-100% to 100%)
SWEP.RecoilDrift						= 0.5 -- how much will be smooth recoil
SWEP.RecoilDecay						= 25 -- how much recoil to remove per second
SWEP.RecoilADSMult						= ( 3 / 4 ) -- multiply shot recoil by this amount when ads'd

-- after the fact
SWEP.Recoil2Drift						= 0.5 -- how much to return to the original pos
SWEP.Recoil2Decay						= 20 -- how much recoil to remove per second


SWEP.Dispersion				= 0.8
SWEP.Dispersion_Move		= 2 -- at 200 hu/s
SWEP.Dispersion_Air			= 2
SWEP.Dispersion_Crouch		= ( 2 / 3 )
SWEP.Dispersion_Sights		= ( 1 / 3 )

SWEP.Dispersion_FireShoot	= 0.4
SWEP.Dispersion_FireDecay	= 3

SWEP.Movespeed							= 0.94
SWEP.Movespeed_Firing					= 0.84
SWEP.Movespeed_ADS						= 0.84

SWEP.Firemodes = {
	{
		Count = math.huge,
		Delay = ( 60 / 780 ),
	},
	{
		Count = 1,
		Delay = ( 60 / 1200 ),
	}
}

SWEP.ActivePose = {
	Pos = Vector(-0, 0, -0.4),
	Ang = Angle(),
}

SWEP.IronsightPose = {
	Pos = Vector(-2.31, -2, 0.4),
	Ang = Angle(0.1, 0, 0),
}

SWEP.CustomizePose = {
	Pos = Vector(0.3, -1, -0.9),
	Ang = Angle(6, 6, -4),
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
	["ready"] = {
		Source = "base_ready",
		Events = {
			{ t = 0, s = "mfa/zenith/ogg/cloth_1.ogg" },
			{ t = 0.2, s = "mfa/wep/ogg/Reload_1P_MK11_Bolt_Wave 0 0 0.ogg" },
			{ t = 0.7, s = "mfa/zenith/ogg/shoulder.ogg", v = 0.2 },
		},
	},
	["draw"] = {
		Source = "base_draw",
		Events = {
			{ t = 0, s = "mfa/zenith/ogg/raise.ogg" },
		},
		ReloadingTime = 0.4,
	},
	["holster"] = {
		Source = "base_holster",
		Events = {
			{ t = 0, s = "mfa/zenith/ogg/cloth_3.ogg" },
		},
		HolsterTime = 0.25,
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
			{ t = 0, s = "mfa/zenith/ogg/rattle2.ogg" },
			{ t = 0.3, s = "mfa/wep/ogg/Reload_1P_MK11_Magout_Wave 0 0 0.ogg" },
			{ t = 0.4, s = "mfa/zenith/ogg/cloth_soft_1.ogg" },
			{ t = 0.7, s = "mfa/zenith/ogg/magpouch_replace_small.ogg" },
			{ t = 1.55, s = "mfa/wep/ogg/Reload_1P_MK11_Magin_Wave 0 0 0.ogg" },
			{ t = 2.0, s = "mfa/zenith/ogg/shoulder.ogg", v = 0.2 },
		},
		Time = 2.8,
		LoadIn = 2.1,
	},
	["reload_empty"] = {
		Source = "base_reloadempty",
		Events = {
			{ t = 0, s = "mfa/zenith/ogg/rattle2.ogg" },
			{ t = 0.05, s = "mfa/wep/ogg/Reload_1P_PP2000_Bolt_Wave 0 0 0.ogg", v = 0.5 },
			{ t = 0.4, s = "mfa/zenith/ogg/cloth_soft_2.ogg" },
			{ t = 0.9, s = "mfa/wep/ogg/Reload_1P_MK11_Magout_Wave 0 0 0.ogg" },
			{ t = 1.0, s = "mfa/zenith/ogg/cloth_soft_1.ogg" },
			{ t = 1.5, s = "mfa/zenith/ogg/magpouch_replace_small.ogg" },
			{ t = 2.1, s = "mfa/wep/ogg/Reload_1P_MK11_Magin_Wave 0 0 0.ogg" },
			{ t = 2.6, s = "mfa/wep/ogg/Reload_1P_MK11_Bolt_Wave 0 0 0.ogg", v = 0.5 },
			{ t = 3.0, s = "mfa/zenith/ogg/shoulder.ogg", v = 0.2 },
		},
		Time = 3.9,
		LoadIn = 3.3,
	}
}