
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
SWEP.Sound_Fire				= {
	{
		s = {
			")mfa/wep/stg44/STG_Shot_Body_FPP-001.ogg",
			")mfa/wep/stg44/STG_Shot_Body_FPP-002.ogg",
			")mfa/wep/stg44/STG_Shot_Body_FPP-003.ogg",
			")mfa/wep/stg44/STG_Shot_Body_FPP-004.ogg",
			")mfa/wep/stg44/STG_Shot_Body_FPP-005.ogg",
			")mfa/wep/stg44/STG_Shot_Body_FPP-006.ogg",
			")mfa/wep/stg44/STG_Shot_Body_FPP-007.ogg",
			")mfa/wep/stg44/STG_Shot_Body_FPP-008.ogg",
			")mfa/wep/stg44/STG_Shot_Body_FPP-009.ogg",
			")mfa/wep/stg44/STG_Shot_Body_FPP-010.ogg",
		},
		sl = 90,
		v = 1,
		p = 90,
		pm = 110,
		c = CHAN_STATIC,
	},
	{
		s = {
			")mfa/wep/stg44/STG_Shot_Core_FPP-001.ogg",
			")mfa/wep/stg44/STG_Shot_Core_FPP-002.ogg",
			")mfa/wep/stg44/STG_Shot_Core_FPP-003.ogg",
			")mfa/wep/stg44/STG_Shot_Core_FPP-004.ogg",
			")mfa/wep/stg44/STG_Shot_Core_FPP-005.ogg",
			")mfa/wep/stg44/STG_Shot_Core_FPP-006.ogg",
			")mfa/wep/stg44/STG_Shot_Core_FPP-007.ogg",
			")mfa/wep/stg44/STG_Shot_Core_FPP-008.ogg",
			")mfa/wep/stg44/STG_Shot_Core_FPP-009.ogg",
			")mfa/wep/stg44/STG_Shot_Core_FPP-010.ogg",
		},
		sl = 140,
		v = 1,
		p = 90,
		pm = 110,
		c = CHAN_STATIC,
	},
	{
		s = {
			")mfa/wep/stg44/STG_Shot_HiFi_FPP-001.ogg",
			")mfa/wep/stg44/STG_Shot_HiFi_FPP-002.ogg",
			")mfa/wep/stg44/STG_Shot_HiFi_FPP-003.ogg",
			")mfa/wep/stg44/STG_Shot_HiFi_FPP-004.ogg",
			")mfa/wep/stg44/STG_Shot_HiFi_FPP-005.ogg",
			")mfa/wep/stg44/STG_Shot_HiFi_FPP-006.ogg",
			")mfa/wep/stg44/STG_Shot_HiFi_FPP-007.ogg",
			")mfa/wep/stg44/STG_Shot_HiFi_FPP-008.ogg",
			")mfa/wep/stg44/STG_Shot_HiFi_FPP-009.ogg",
			")mfa/wep/stg44/STG_Shot_HiFi_FPP-010.ogg",
		},
		sl = 70,
		v = 1,
		p = 90,
		pm = 110,
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

SWEP.Firemodes = {
	{
		Count = 3,
		Delay = 0.07,
		PostBurstDelay = 0.02,
		Runoff = true,
	},
	{
		Count = 1,
		Delay = ( 60 / 1200 ),
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
		Time = 0.8,
		ReloadingTime = 0.6,
	},
	["holster"] = {
		Source = "base_holster",
	},
	["fire"] = {
		Source = "base_fire",
		Events = {
			{ t = 0, shell = true }
		},
	},
	["fire_ads"] = {
		Source = "iron_fire",
		Events = {
			{ t = 0, shell = true }
		},
	},
	["reload"] = {
		Source = "base_reload",
		Events = {
			{ t = 0, s = "mfa/zenith/ogg/raise.ogg" },
			{ t = 0.5, s = "mfa/wep/ogg/Reload_1P_M16_Magout_Wave 0 0 0.ogg" },
			{ t = 1.1, s = "mfa/zenith/ogg/cloth_soft_3.ogg", v = 0.2 },
			{ t = 1.2, s = "mfa/zenith/ogg/magpouch.ogg" },
			{ t = 1.7, s = "mfa/wep/ogg/Reload_1P_M16_Magin_Wave 0 0 0.ogg" },
			{ t = 2.4, s = "mfa/zenith/ogg/cloth_soft_1.ogg", v = 0.5 },
			{ t = 2.55, s = "mfa/wep/ogg/Reload_1P_M16_Magin_Metal_Wave 0 0 0.ogg" },
			{ t = 3.05, s = "mfa/zenith/ogg/magimpact.ogg" },
		},
		Time = 4.0,
		LoadIn = 2.5,
	},
	["reload_empty"] = {
		Source = "base_reloadempty",
		Events = {
			{ t = 0, s = "mfa/zenith/ogg/raise.ogg" },
			{ t = 0.5, s = "mfa/wep/ogg/Reload_1P_M16_Magout_Wave 1 0 0.ogg" },
			{ t = 1.1, s = "mfa/zenith/ogg/cloth_soft_3.ogg", v = 0.2 },
			{ t = 1.2, s = "mfa/zenith/ogg/magpouch.ogg" },
			{ t = 1.7, s = "mfa/wep/ogg/Reload_1P_M16_Magin_Wave 0 0 0.ogg" },
			{ t = 2.4, s = "mfa/zenith/ogg/cloth_soft_1.ogg", v = 0.5 },
			{ t = 3.12, s = "mfa/wep/ogg/Reload_1P_M16_Bolt_Wave 0 0 0.ogg" },
			{ t = 3.2, s = "mfa/zenith/ogg/rattle.ogg" },
		},
		Time = 4.6,
		LoadIn = 3.5,
	}
}