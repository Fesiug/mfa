
-- Fesiug, 2022

SWEP.Base					= "mfa_base_wep"
SWEP.Spawnable				= true

SWEP.Slot					= 2
SWEP.Category				= "MFA"
SWEP.PrintName				= "Battle Rifle"
SWEP.Trivia = {
	Category = "Rifle",
	["Real Name"] = "G3",
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
			")mfa/wep/fg42/FG42_Shot_Body-001.ogg",
			")mfa/wep/fg42/FG42_Shot_Body-002.ogg",
			")mfa/wep/fg42/FG42_Shot_Body-003.ogg",
			")mfa/wep/fg42/FG42_Shot_Body-004.ogg",
			")mfa/wep/fg42/FG42_Shot_Body-005.ogg",
			")mfa/wep/fg42/FG42_Shot_Body-006.ogg",
			")mfa/wep/fg42/FG42_Shot_Body-007.ogg",
			")mfa/wep/fg42/FG42_Shot_Body-008.ogg",
			")mfa/wep/fg42/FG42_Shot_Body-009.ogg",
			")mfa/wep/fg42/FG42_Shot_Body-010.ogg",
		},
		sl = 90,
		v = 1,
		p = 90,
		pm = 110,
		c = CHAN_STATIC,
	},
	{
		s = {
			")mfa/wep/fg42/FG42_Shot_Core-001.ogg",
			")mfa/wep/fg42/FG42_Shot_Core-002.ogg",
			")mfa/wep/fg42/FG42_Shot_Core-003.ogg",
			")mfa/wep/fg42/FG42_Shot_Core-004.ogg",
			")mfa/wep/fg42/FG42_Shot_Core-005.ogg",
			")mfa/wep/fg42/FG42_Shot_Core-006.ogg",
			")mfa/wep/fg42/FG42_Shot_Core-007.ogg",
			")mfa/wep/fg42/FG42_Shot_Core-008.ogg",
			")mfa/wep/fg42/FG42_Shot_Core-009.ogg",
			")mfa/wep/fg42/FG42_Shot_Core-010.ogg",
		},
		sl = 140,
		v = 1,
		p = 90,
		pm = 110,
		c = CHAN_STATIC,
	},
	{
		s = {
			")mfa/wep/fg42/FG42_Shot_HiFi-001.ogg",
			")mfa/wep/fg42/FG42_Shot_HiFi-002.ogg",
			")mfa/wep/fg42/FG42_Shot_HiFi-003.ogg",
			")mfa/wep/fg42/FG42_Shot_HiFi-004.ogg",
			")mfa/wep/fg42/FG42_Shot_HiFi-005.ogg",
			")mfa/wep/fg42/FG42_Shot_HiFi-006.ogg",
			")mfa/wep/fg42/FG42_Shot_HiFi-007.ogg",
			")mfa/wep/fg42/FG42_Shot_HiFi-008.ogg",
			")mfa/wep/fg42/FG42_Shot_HiFi-009.ogg",
			")mfa/wep/fg42/FG42_Shot_HiFi-010.ogg",
		},
		sl = 70,
		v = 1,
		p = 90,
		pm = 110,
		c = CHAN_STATIC,
	},
}
SWEP.Sound_Dry = { s = "mfa/wep/dry/rifle_high.ogg", sl = 50, v = 0.5, p = 100 }

SWEP.DamageNear				= 34
SWEP.DamageFar				= 30
SWEP.RangeNear				= 20
SWEP.RangeFar				= 80

--
-- Recoil
--
SWEP.RecoilUp							= 4.5 -- degrees punched
SWEP.RecoilUpDecay						= 40 -- how much recoil to remove per second
SWEP.RecoilSide							= 0.5 -- degrees punched, in either direction (-100% to 100%)
SWEP.RecoilSideDecay					= 30 -- how much recoil to remove per second
SWEP.RecoilUpDrift						= 0.5 -- how much will be smooth recoil
SWEP.RecoilSideDrift					= 0.5 -- how much will be smooth recoil
SWEP.RecoilFlipChance					= ( 2 / 3 ) -- chance to flip recoil direction
SWEP.RecoilADSMult						= ( 1 / 3 ) -- multiply shot recoil by this amount when ads'd

-- after the fact
SWEP.Recoil2UpDrift						= 0.3 -- how much to return to the original pos
SWEP.Recoil2SideDrift					= 0.3
SWEP.Recoil2UpDecay						= 20 -- how much recoil to remove per second
SWEP.Recoil2SideDecay					= 20 


SWEP.Dispersion				= 0.3
SWEP.Dispersion_Move		= 4 -- at 200 hu/s
SWEP.Dispersion_Air			= 5
SWEP.Dispersion_Crouch		= ( 2 / 3 )
SWEP.Dispersion_Sights		= ( 1 / 3 )

SWEP.Dispersion_FireShoot	= 1
SWEP.Dispersion_FireDecay	= 5

SWEP.Movespeed							= 0.88
SWEP.Movespeed_Firing					= 0.78
SWEP.Movespeed_ADS						= 0.68

SWEP.Firemodes = {
	{
		Count = 1,
		Delay = ( 60 / 500 )
	},
	{
		Count = math.huge,
		Delay = ( 60 / 500 )
	}
}

SWEP.ActivePos = {
	Pos = Vector(0.2, -1, -0.2),
	Ang = Angle(),
}

SWEP.IronsightPos = {
	Pos = Vector(-2.07, -3, 0.55),
	Ang = Angle(0, 0, 0),
	Mag = 1.3,
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
		Source = "iron_fire",
		Events = {
			{ t = 0, shell = true }
		},
		Time = 1.5,
	},
	["reload"] = {
		Source = "base_reload",
		Events = {
			{ t = 0, s = "mfa/zenith/ogg/raise.ogg" },
			{ t = 0.3, s = "mfa/wep/ogg/Reload_1P_AK12_Grab_Wave 0 0 0.ogg" },
			{ t = 0.5, s = "mfa/wep/ogg/Reload_1P_AK12_Magout_Wave 0 0 0.ogg" },
			{ t = 2.0, s = "mfa/zenith/ogg/magpouch.ogg" },
			{ t = 2.7, s = "mfa/wep/ogg/Reload_1P_AK12_Magin_Wave 0 0 0.ogg" },
			{ t = 2.9, s = "mfa/zenith/ogg/cloth_soft_1.ogg", v = 0.5 },
		},
		Time = 3.7,
		LoadIn = 2.9,
		StopSightTime = 3.2,
	},
	["reload_empty"] = {
		Source = "base_reloadempty",
		Events = {
			{ t = 0, s = "mfa/zenith/ogg/raise.ogg" },
			{ t = 0.2, s = "mfa/wep/ogg/Reload_1P_CZ805_Bolt_Wave 0 0 0.ogg" },
			{ t = 1.3, s = "mfa/wep/ogg/Reload_1P_AK12_Grab_Wave 0 0 0.ogg" },
			{ t = 1.5, s = "mfa/wep/ogg/Reload_1P_AK12_Magout_Wave 0 0 0.ogg" },
			{ t = 2.7, s = "mfa/zenith/ogg/magpouch.ogg" },
			{ t = 3.3, s = "mfa/wep/ogg/Reload_1P_AK12_Magin_Wave 0 0 0.ogg" },
			{ t = 4.5, s = "mfa/wep/ogg/Reload_1P_AK12_Bolt_Wave 0 0 0.ogg" },
			{ t = 4.7, s = "mfa/zenith/ogg/cloth_soft_1.ogg", v = 0.5 },
		},
		Time = 4.9,
		LoadIn = 3.9,
		StopSightTime = 4.5,
	}
}