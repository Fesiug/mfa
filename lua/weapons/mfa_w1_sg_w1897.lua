
-- Fesiug, 2022

SWEP.Base					= "mfa_base_wep"
SWEP.Spawnable				= true

SWEP.Slot					= 2
SWEP.Category				= "MFA"	
SWEP.PrintName				= "Reinfeld 1897"
SWEP.Trivia = {
	Category = "Shotgun",
	["Real Name"] = "Winchester 1897",
}

SWEP.UseHands				= true
SWEP.ViewModel				= "models/mfa/weapons/w1897.mdl"
SWEP.WorldModel				= "models/mfa/weapons/w1897.mdl"
SWEP.ViewModelFOV			= 70

SWEP.Primary.ClipSize		= 7
SWEP.Primary.Ammo			= "buckshot"
SWEP.Sound_Fire				= {
	{
		s = ")mfa/fesiug/db_fire.wav",
		sl = 90,
		v = 0.75,
		p = 100,
		pm = 100,
		c = CHAN_STATIC,
	},
	{
		s = {
			")mfa/wep/w1897/Winchester_1897_Shot_Core-001.ogg",
			")mfa/wep/w1897/Winchester_1897_Shot_Core-002.ogg",
			")mfa/wep/w1897/Winchester_1897_Shot_Core-003.ogg",
			")mfa/wep/w1897/Winchester_1897_Shot_Core-004.ogg",
			")mfa/wep/w1897/Winchester_1897_Shot_Core-005.ogg",
		},
		sl = 140,
		v = 1,
		p = 90,
		pm = 110,
		c = CHAN_STATIC,
	},
	{
		s = {
			")mfa/wep/w1897/Winchester_1897_Shot_HiFi-001.ogg",
			")mfa/wep/w1897/Winchester_1897_Shot_HiFi-002.ogg",
			")mfa/wep/w1897/Winchester_1897_Shot_HiFi-003.ogg",
			")mfa/wep/w1897/Winchester_1897_Shot_HiFi-004.ogg",
			")mfa/wep/w1897/Winchester_1897_Shot_HiFi-005.ogg",
		},
		sl = 70,
		v = 1,
		p = 90,
		pm = 110,
		c = CHAN_STATIC,
	},
}
SWEP.Sound_Dry = { s = "mfa/wep/dry/shotgun.ogg", sl = 50, v = 0.5, p = 100 }


SWEP.DamageNear = 10
SWEP.DamageFar = 7
SWEP.RangeNear = 10
SWEP.RangeFar = 30

SWEP.Pellets = 10

--
-- Recoil
--
SWEP.RecoilUp							= 8 -- degrees punched
SWEP.RecoilUpDecay						= 30 -- how much recoil to remove per second
SWEP.RecoilSide							= 3.5 -- degrees punched, in either direction (-100% to 100%)
SWEP.RecoilSideDecay					= 22 -- how much recoil to remove per second
SWEP.RecoilUpDrift						= 0.4 -- how much will be smooth recoil
SWEP.RecoilSideDrift					= 0.7 -- how much will be smooth recoil
SWEP.RecoilFlipChance					= ( 3 / 4 ) -- chance to flip recoil direction
SWEP.RecoilADSMult						= ( 3 / 4 ) -- multiply shot recoil by this amount when ads'd

-- after the fact
SWEP.Recoil2UpDrift						= 0.3 -- how much to return to the original pos
SWEP.Recoil2SideDrift					= 0.3
SWEP.Recoil2UpDecay						= 18 -- how much recoil to remove per second
SWEP.Recoil2SideDecay					= 18 

SWEP.Dispersion				= 3
SWEP.Dispersion_Move		= 0.6 -- at 200 hu/s
SWEP.Dispersion_Air			= 1.2
SWEP.Dispersion_Crouch		= ( 3 / 5 )
SWEP.Dispersion_Sights		= ( 3 / 5 )

SWEP.Dispersion_FireShoot	= 6
SWEP.Dispersion_FireDecay	= 10

SWEP.ShotgunReloading		= true
SWEP.CycleCount				= 1

SWEP.Movespeed							= 0.88
SWEP.Movespeed_Firing					= 0.78
SWEP.Movespeed_ADS						= 0.68

SWEP.Firemodes = {
	{
		Name = "Slamfire",
		Count = math.huge,
		Delay = ( 60 / 240 ),
	}
}

SWEP.ActivePose = {
	Pos = Vector(0.5, -2.5, -0.4),
	Ang = Angle(),
}

SWEP.RunPose = {
	Pos = Vector(0, -2.5, 0),
	Ang = Angle(-12, 12, -12),
}

SWEP.IronsightPose = {
	Pos = Vector(-1.81, -2, 0.4),
	Ang = Angle(0.7, 0, 0),
}

SWEP.CustomizePose = {
	Pos = Vector(2, -5, -2),
	Ang = Angle(12, 12, 0),
}

SWEP.MuzzleEffect						= "muzzleflash_shotgun"
SWEP.QCA_Muzzle							= 1
SWEP.QCA_Case							= 3

SWEP.ShellModel							= "models/shells/shell_12gauge.mdl"
SWEP.ShellScale							= 1

SWEP.Animations = {
	["idle"] = {
		Source = "base_idle",
	},
	["draw"] = {
		Source = "base_draw",
		Events = {
			{ t = 0, s = "mfa/zenith/ogg/cloth_soft_1.ogg" },
		},
		ReloadingTime = 0.5,
	},
	["holster"] = {
		Source = "base_holster",
		Events = {
			{ t = 0, s = "mfa/zenith/ogg/cloth_soft_3.ogg" },
		},
		HolsterTime = 0.3,
	},
	["fire"] = {
		Source = { "base_fire_1", "base_fire_2"},
		Time = 0.6,
		CycleDelayTime = 0.1,
	},
	["cycle"] = {
		Source = { "base_fire_cock_1" },
		Events = {
			{ t = 0.1, shell = true, },
			{ t = 0, s = "mfa/zenith/ogg/pistol_rattle_2.ogg" },
			{ t = 0, s = "mfa/wep/ogg/Reload_1P_HAWK_BoltAction_Wave 0 0 0.ogg", p = 110 },
		},
		Time = 1.0,
		CycleDelayTime = 0.5,
	},
	["fire_ads"] = {
		Source = { "iron_fire_1", "iron_fire_2"},
		Time = 0.6,
		CycleDelayTime = 0.1,
	},
	["cycle_ads"] = {
		Source = { "iron_fire_cock_1", "iron_fire_cock_2" },
		Events = {
			{ t = 0.1, shell = true, },
			{ t = 0, s = "mfa/zenith/ogg/pistol_rattle_2.ogg" },
			{ t = 0, s = "mfa/wep/ogg/Reload_1P_HAWK_BoltAction_Wave 0 0 0.ogg", p = 110 },
		},
		Time = 1.0,
		CycleDelayTime = 0.5,
	},
	["sgreload_start"] = {
		Source = "base_reload_start",
		Events = {
			{ t = 0, s = "mfa/zenith/ogg/raise.ogg" },
		},
		Time = 0.6,
		ReloadingTime = 0.5,
	},
	["sgreload_start_empty"] = {
		Source = "base_reload_start_empty",
		Events = {
			{ t = 0, s = "mfa/zenith/ogg/pistol_rattle_2.ogg" },
			{ t = 0.1, s = "mfa/wep/ogg/Reload_1P_SPAS12_InsertFirstShell_Wave 0 0 0.ogg", p = 110 },
			--{ t = 1.4, s = "mfa/wep/ogg/Reload_1P_SG553_Bolt_Wave 0 0 0.ogg" },
		},
		Time = 2.2,
		LoadIn = 1.7,
		ReloadingTime = 2.0,
	},
	["reload"] = {
		Source = "base_reload_insert",
		Events = {
			{ t = 0, s = {
				"mfa/zenith/ogg/rattle1.ogg",
				"mfa/zenith/ogg/rattle2.ogg",
				"mfa/zenith/ogg/rattle3.ogg",
			}, v = 0.5 },
			{ t = 0.1, s = {
				"mfa/wep/ogg/Reload_1P_QBS09_InsertShell_Wave 0 0 0.ogg",
				"mfa/wep/ogg/Reload_1P_QBS09_InsertShell_Wave 0 1 0.ogg",
				"mfa/wep/ogg/Reload_1P_QBS09_InsertShell_Wave 0 2 0.ogg",
				"mfa/wep/ogg/Reload_1P_QBS09_InsertShell_Wave 1 0 0.ogg",
			} },
			{ t = 0.3, s = {
				"mfa/zenith/ogg/rattle_weapon_1.ogg",
				"mfa/zenith/ogg/rattle_weapon_2.ogg",
				"mfa/zenith/ogg/rattle_weapon_3.ogg",
				"mfa/zenith/ogg/rattle_weapon_4.ogg",
			} },
		},
		Time = 0.5,
		ReloadingTime = 0.4,
		LoadIn = 0.12,
	},
	["sgreload_finish"] = {
		Source = "base_reload_end_empty",
		Events = {
			{ t = 0, s = "mfa/zenith/ogg/draw.ogg" },
		},
		Time = 0.6,
	},
}