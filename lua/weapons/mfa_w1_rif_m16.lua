
-- Fesiug, 2022

SWEP.Base					= "mfa_base_wep"
SWEP.Spawnable				= true

SWEP.Slot					= 2
SWEP.Category				= "MFA"	
SWEP.PrintName				= "COBRA Mk. 4"
SWEP.Trivia = {
	Category = "Rifle",
	["Real Name"] = "M16A4",
}

SWEP.UseHands				= true
SWEP.ViewModel				= "models/mfa/weapons/m16a1_1.mdl"
SWEP.WorldModel				= "models/mfa/weapons/m16a1_1.mdl"
SWEP.ViewModelFOV			= 70

SWEP.Primary.ClipSize		= 30
SWEP.Primary.Ammo			= "smg1"
SWEP.Sound_Fire				= {
	{
		s = {
			")mfa/dk2/wep/m16_fire_01.ogg",
			")mfa/dk2/wep/m16_fire_02.ogg",
			")mfa/dk2/wep/m16_fire_03.ogg",
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
		v = 0.55,
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
SWEP.RecoilUp							= 1.5 -- degrees punched
SWEP.RecoilUpDecay						= 25 -- how much recoil to remove per second
SWEP.RecoilSide							= 0.6 -- degrees punched, in either direction (-100% to 100%)
SWEP.RecoilSideDecay					= 25 -- how much recoil to remove per second
SWEP.RecoilUpDrift						= 0.6 -- how much will be smooth recoil
SWEP.RecoilSideDrift					= 0.6 -- how much will be smooth recoil
SWEP.RecoilFlipChance					= ( 1 / 4 ) -- chance to flip recoil direction
SWEP.RecoilADSMult						= ( 3 / 4 ) -- multiply shot recoil by this amount when ads'd

-- after the fact
SWEP.Recoil2UpDrift						= 0.5 -- how much to return to the original pos
SWEP.Recoil2SideDrift					= 0.5
SWEP.Recoil2UpDecay						= 22 -- how much recoil to remove per second
SWEP.Recoil2SideDecay					= 22 


SWEP.Dispersion				= 0.7
SWEP.Dispersion_Move		= 3 -- at 200 hu/s
SWEP.Dispersion_Air			= 4
SWEP.Dispersion_Crouch		= ( 2 / 3 )
SWEP.Dispersion_Sights		= ( 1 / 3 )

SWEP.Dispersion_FireShoot	= 0.4
SWEP.Dispersion_FireDecay	= 3

SWEP.Movespeed							= 0.92
SWEP.Movespeed_Firing					= 0.82
SWEP.Movespeed_ADS						= 0.72

SWEP.Firemodes = {
	{
		Count = math.huge,
		Delay = ( 60 / 700 ),
	},
	{
		Count = 3,
		Delay = ( 60 / 900 ),
		PostBurstDelay = 0.02,
		Runoff = true,
	},
	{
		Count = 1,
		Delay = ( 60 / 1200 ),
	}
}

SWEP.ActivePose = {
	Pos = Vector(0.2, -1, 0.8),
	Ang = Angle(),
}

SWEP.IronsightPose = {
	Pos = Vector(-2.417, -3, 0.89),
	Ang = Angle(0.1, 0, 0),
	Mag = 1.3,
}

SWEP.CustomizePose = {
	Pos = Vector(1, -0.8, 0.5),
	Ang = Angle(6, 6, 0),
}

SWEP.MuzzleEffect						= "muzzleflash_3"
SWEP.QCA_Muzzle							= 1
SWEP.QCA_Case							= 4

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
		HolsterTime = 0.5,
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
			{ t = 0.5, s = "mfa/wep/ogg/Reload_1P_M16_Magout_Wave 0 0 0.ogg", v = 0.75 },
			{ t = 1.1, s = "mfa/zenith/ogg/cloth_soft_3.ogg", v = 0.2 },
			{ t = 1.2, s = "mfa/zenith/ogg/magpouch.ogg" },
			{ t = 1.7, s = "mfa/wep/ogg/Reload_1P_M16_Magin_Wave 0 0 0.ogg", v = 0.75 },
			{ t = 2.4, s = "mfa/zenith/ogg/cloth_soft_1.ogg", v = 0.5 },
			{ t = 2.55, s = "mfa/wep/ogg/Reload_1P_M16_Magin_Metal_Wave 0 0 0.ogg" },
			{ t = 3.05, s = "mfa/zenith/ogg/magimpact.ogg" },
		},
		Time = 4.0,
		ReloadingTime = 3.7,
		LoadIn = 2.5,
	},
	["reload_empty"] = {
		Source = "base_reloadempty",
		Events = {
			{ t = 0, s = "mfa/zenith/ogg/raise.ogg" },
			{ t = 0.5, s = "mfa/wep/ogg/Reload_1P_M16_Magout_Wave 1 0 0.ogg", v = 0.75 },
			{ t = 1.1, s = "mfa/zenith/ogg/cloth_soft_3.ogg", v = 0.2 },
			{ t = 1.2, s = "mfa/zenith/ogg/magpouch.ogg" },
			{ t = 1.7, s = "mfa/wep/ogg/Reload_1P_M16_Magin_Wave 0 0 0.ogg", v = 0.75 },
			{ t = 2.4, s = "mfa/zenith/ogg/cloth_soft_1.ogg", v = 0.5 },
			{ t = 2.92, s = "mfa/wep/ogg/Reload_1P_M16_Bolt_Wave 0 0 0.ogg", v = 0.5 },
			{ t = 3.1, s = "mfa/zenith/ogg/rattle.ogg" },
		},
		Time = 4.6,
		ReloadingTime = 4.3,
		LoadIn = 3.5,
	}
}