
-- Fesiug, 2022

SWEP.Base					= "mfa_base_wep"
SWEP.Spawnable				= true

SWEP.Slot					= 2
SWEP.Category				= "MFA"	
SWEP.PrintName				= "Rosertinn 800C"
SWEP.Trivia = {
	Category = "Shotgun",
	Description = "A compact shotgun with no stock and pistol grip enhances mobility in CQB situations.",
	["Real Name"] = "Mossberg 500",
}

SWEP.UseHands				= true
SWEP.ViewModel				= "models/mfa/weapons/m500.mdl"
SWEP.WorldModel				= "models/mfa/weapons/m500.mdl"
SWEP.ViewModelFOV			= 70

SWEP.Primary.ClipSize		= 6
SWEP.Primary.Ammo			= "buckshot"
SWEP.Sound_Fire				= {
	{
		s = ")mfa/fesiug/m3_fire.wav",
		sl = 90,
		v = 0.75,
		p = 90,
		pm = 100,
		c = CHAN_STATIC,
	},
	{
		s = ")mfa/dk2/wep/shotgun_fire_01.wav",
		s = ")mfa/dk2/wep/shotgun_fire_02.wav",
		s = ")mfa/dk2/wep/shotgun_fire_03.wav",
		sl = 90,
		v = 1.0,
		p = 90,
		pm = 100,
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

SWEP.Dispersion				= 4
SWEP.Dispersion_Move		= 0.6 -- at 200 hu/s
SWEP.Dispersion_Air			= 1.2
SWEP.Dispersion_Crouch		= ( 3 / 5 )
SWEP.Dispersion_Sights		= ( 3 / 5 )

SWEP.Dispersion_FireShoot	= 4
SWEP.Dispersion_FireDecay	= 12

SWEP.ShotgunReloading		= true
SWEP.CycleCount				= 1

SWEP.Movespeed							= 0.88
SWEP.Movespeed_Firing					= 0.78
SWEP.Movespeed_ADS						= 0.68

SWEP.Firemodes = {
	{
		Name = "Pump-action",
		Count = 1,
		Delay = ( 60 / 240 ),
	}
}

SWEP.ActivePose = {
	Pos = Vector(0.5, -5.5, -0.2),
	Ang = Angle(),
}

SWEP.RunPose = {
	Pos = Vector(0, -6.5, 0),
	Ang = Angle(-12, 12, -12),
}

SWEP.IronsightPose = {
	Pos = Vector(-2.01, -7, 0.8),
	Ang = Angle(1.2, 0, 0),
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
		CycleDelayTime = 0.2,
		StopSightTime = -math.huge,
	},
	["cycle"] = {
		Source = { "base_fire_cock_1", "base_fire_cock_2" },
		Events = {
			{ t = 0.1, shell = true, },
			{ t = 0, s = "mfa/zenith/ogg/pistol_rattle_2.ogg" },
			{ t = 0, s = "mfa/wep/ogg/Reload_1P_A91_Bolt_Wave 0 0 0.ogg" },
		},
		Time = 1.0,
		CycleDelayTime = 0.4,
	},
	["fire_ads"] = {
		Source = { "iron_fire_1", "iron_fire_2"},
		Time = 0.6,
		CycleDelayTime = 0.2,
		StopSightTime = -math.huge,
	},
	["cycle_ads"] = {
		Source = { "iron_fire_cock_1", "iron_fire_cock_2" },
		Events = {
			{ t = 0.1, shell = true, },
			{ t = 0, s = "mfa/zenith/ogg/pistol_rattle_2.ogg" },
			{ t = 0, s = "mfa/wep/ogg/Reload_1P_A91_Bolt_Wave 0 0 0.ogg" },
		},
		Time = 0.7,
		CycleDelayTime = 0.4,
	},
	["sgreload_start"] = {
		Source = "base_reload_start",
		Events = {
			{ t = 0, s = "mfa/zenith/ogg/raise.ogg" },
		},
		Time = 0.8,
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
		ReloadingTime = 0.46,
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