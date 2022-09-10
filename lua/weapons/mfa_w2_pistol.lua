
-- Fesiug, 2022

SWEP.Base					= "mfa_base_wep"
SWEP.Spawnable				= true

SWEP.Slot					= 1
SWEP.Category				= "MFA"	
SWEP.PrintName				= "Pistol"
SWEP.Trivia = {
	Category = "Sidearm",
	["Real Name"] = "Browning HP",
}

SWEP.UseHands				= true
SWEP.ViewModel				= "models/mfa/weapons/browninghp.mdl"
SWEP.WorldModel				= "models/mfa/weapons/browninghp.mdl"
SWEP.ViewModelFOV			= 70

SWEP.Primary.ClipSize		= 12
SWEP.Primary.Ammo			= "pistol"
SWEP.Sound_Fire				= {
	{
		s = {
			")mfa/wep/luger/Luger_P08_Shot_Body_FPP-001.ogg",
			")mfa/wep/luger/Luger_P08_Shot_Body_FPP-002.ogg",
			")mfa/wep/luger/Luger_P08_Shot_Body_FPP-003.ogg",
			")mfa/wep/luger/Luger_P08_Shot_Body_FPP-004.ogg",
			")mfa/wep/luger/Luger_P08_Shot_Body_FPP-005.ogg",
			")mfa/wep/luger/Luger_P08_Shot_Body_FPP-006.ogg",
			")mfa/wep/luger/Luger_P08_Shot_Body_FPP-007.ogg",
		},
		sl = 90,
		v = 1,
		p = 90,
		pm = 110,
		c = CHAN_STATIC,
	},
	{
		s = {
			")mfa/wep/colt/M1911_Colt_Shot_CoreBass_FPP-001.ogg",
			")mfa/wep/colt/M1911_Colt_Shot_CoreBass_FPP-002.ogg",
			")mfa/wep/colt/M1911_Colt_Shot_CoreBass_FPP-003.ogg",
			")mfa/wep/colt/M1911_Colt_Shot_CoreBass_FPP-004.ogg",
			")mfa/wep/colt/M1911_Colt_Shot_CoreBass_FPP-005.ogg",
			")mfa/wep/colt/M1911_Colt_Shot_CoreBass_FPP-006.ogg",
		},
		sl = 140,
		v = 1,
		p = 90,
		pm = 110,
		c = CHAN_STATIC,
	},
	{
		s = {
			")mfa/wep/luger/Luger_P08_Shot_HiFi_FPP-001.ogg",
			")mfa/wep/luger/Luger_P08_Shot_HiFi_FPP-002.ogg",
			")mfa/wep/luger/Luger_P08_Shot_HiFi_FPP-003.ogg",
			")mfa/wep/luger/Luger_P08_Shot_HiFi_FPP-004.ogg",
			")mfa/wep/luger/Luger_P08_Shot_HiFi_FPP-005.ogg",
			")mfa/wep/luger/Luger_P08_Shot_HiFi_FPP-006.ogg",
			")mfa/wep/luger/Luger_P08_Shot_HiFi_FPP-007.ogg",
		},
		sl = 70,
		v = 1,
		p = 90,
		pm = 110,
		c = CHAN_STATIC,
	},
}
SWEP.Sound_Dry = { s = "mfa/wep/dry/pistol.ogg", sl = 50, v = 0.5, p = 100 }

SWEP.DamageNear				= 30
SWEP.DamageFar				= 26
SWEP.RangeNear				= 20
SWEP.RangeFar				= 50

--
-- Recoil
--
SWEP.RecoilUp							= 2.5 -- degrees punched
SWEP.RecoilUpDecay						= 30 -- how much recoil to remove per second
SWEP.RecoilSide							= 1.5 -- degrees punched, in either direction (-100% to 100%)
SWEP.RecoilSideDecay					= 30 -- how much recoil to remove per second
SWEP.RecoilUpDrift						= 0.5 -- how much will be smooth recoil
SWEP.RecoilSideDrift					= 0.5 -- how much will be smooth recoil
SWEP.RecoilFlipChance					= ( 2 / 3 ) -- chance to flip recoil direction
SWEP.RecoilADSMult						= ( 3 / 4 ) -- multiply shot recoil by this amount when ads'd

-- after the fact
SWEP.Recoil2UpDrift						= 0.6 -- how much to return to the original pos
SWEP.Recoil2SideDrift					= 0.6
SWEP.Recoil2UpDecay						= 15 -- how much recoil to remove per second
SWEP.Recoil2SideDecay					= 15 


SWEP.Dispersion				= 0.3
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
		Delay = 0.15,
	}
}

SWEP.ActivePose = {
	Pos = Vector(0.2, -1, 0.2),
	Ang = Angle(),
}

SWEP.IronsightPose = {
	Pos = Vector(-2.44, -3, 0.89),
	Ang = Angle(0.5, 0, 0),
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
	["idle_empty"] = {
		Source = "empty_idle",
	},
	["draw"] = {
		Source = "base_draw",
		Time = 0.8,
		ReloadingTime = 0.5,
		StopSightTime = 0.3,
	},
	["holster"] = {
		Source = "base_holster",
	},
	["dryfire"] = {
		Source = "base_dryfire",
	},
	["dryfire_ads"] = {
		Source = "iron_dryfire",
	},
	["fire"] = {
		Source = "base_fire2",
		Events = {
			{ t = 0, shell = true }
		},
		Time = 1.5,
	},
	["fire_empty"] = {
		Source = "base_firelast",
		Events = {
			{ t = 0, shell = true }
		},
		Time = 1.5,
	},
	["fire_ads"] = {
		Source = "iron_fire_1",
		Events = {
			{ t = 0, shell = true }
		},
	},
	["fire_ads_empty"] = {
		Source = "iron_firelast",
		Events = {
			{ t = 0, shell = true }
		},
	},
	["reload"] = {
		Source = "base_reload",
		Events = {
			{ t = 0, s = "mfa/zenith/ogg/cloth_sharp_impact_soft_new.ogg" },
			{ t = 0.3, s = "mfa/zenith/ogg/draw.ogg" },
			{ t = 0.4, s = "mfa/wep/ogg/Reload_1P_SV98_Magout_Wave 0 0 0.ogg" },
			{ t = 0.8, s = "mfa/zenith/ogg/rattle_weapon_3.ogg" },
			{ t = 1.1, s = "mfa/zenith/ogg/holster_replace.ogg" },
			{ t = 1.3, s = "mfa/zenith/ogg/rattle_weapon_4.ogg" },
			{ t = 1.6, s = "mfa/zenith/ogg/pistol_rattle_4.ogg" },
			{ t = 1.8, s = "mfa/wep/ogg/Reload_1P_SV98_Magin_Wave 0 0 0.ogg" },
		},
		Time = 3.0,
		LoadIn = 2.1,
		ReloadingTime = 2.8,
		StopSightTime = 2.5,
	},
	["reload_empty"] = {
		Source = "base_reloadempty",
		Events = {
			{ t = 0, s = "mfa/zenith/ogg/cloth_sharp_impact_soft_new.ogg" },
			{ t = 0.1, s = "mfa/zenith/ogg/draw.ogg" },
			{ t = 0.2, s = "mfa/wep/ogg/Reload_1P_SV98_Magout_Wave 0 0 0.ogg" },
			{ t = 0.8, s = "mfa/zenith/ogg/rattle_weapon_3.ogg" },
			{ t = 1.1, s = "mfa/zenith/ogg/holster_replace.ogg" },
			{ t = 1.2, s = "mfa/zenith/ogg/rattle_weapon_4.ogg" },
			{ t = 1.4, s = "mfa/zenith/ogg/pistol_rattle_4.ogg" },
			{ t = 1.6, s = "mfa/wep/ogg/Reload_1P_SV98_Magin_Wave 0 0 0.ogg" },
			{ t = 2.43, s = "mfa/wep/ogg/Reload_1P_MP443_SlideClose_Wave 0 0 0.ogg" },
			{ t = 2.6, s = "mfa/zenith/ogg/rattle.ogg" },
			{ t = 2.7, s = "mfa/zenith/ogg/rattle_weapon_2.ogg" },
			{ t = 3.0, s = "mfa/zenith/ogg/rattle_weapon_1.ogg" },
			{ t = 3.3, s = "mfa/zenith/ogg/rattle_weapon_4.ogg" },
		},
		Time = 3.2,
		LoadIn = 2.3,
		ReloadingTime = 3.0,
		StopSightTime = 2.7,
	}
}