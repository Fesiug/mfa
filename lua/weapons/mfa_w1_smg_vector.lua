
-- Fesiug, 2022

SWEP.Base					= "mfa_base_wep"
SWEP.Spawnable				= true

SWEP.Slot					= 2
SWEP.Category				= "MFA"	
SWEP.PrintName				= "Kross Vertex"
SWEP.Trivia = {
	Category = "Submachine Gun",
	["Real Name"] = "UMP",
}

SWEP.UseHands				= true
SWEP.ViewModel				= "models/mfa/weapons/vector.mdl"
SWEP.WorldModel				= "models/mfa/weapons/vector.mdl"
SWEP.ViewModelFOV			= 70

SWEP.Primary.ClipSize		= 28
SWEP.Primary.Ammo			= "pistol"
SWEP.Sound_Fire				= {
	{
		s = {
			")mfa/dk2/wep/mp7_fire_01.ogg",
			")mfa/dk2/wep/mp7_fire_02.ogg",
			")mfa/dk2/wep/mp7_fire_03.ogg",
			")mfa/dk2/wep/mp7_fire_04.ogg",
		},
		sl = 90,
		v = 1,
		p = 95,
		pm = 105,
		c = CHAN_STATIC,
	},
	{
		s = {
			")mfa/fesiug/sweet/p90.ogg",
		},
		sl = 50,
		v = 0.75,
		p = 95,
		pm = 105,
		c = CHAN_STATIC,
	},
}
SWEP.Sound_Dry = { s = "mfa/wep/dry/smg_high.ogg", sl = 50, v = 0.5, p = 100 }

SWEP.DamageNear				= 26
SWEP.DamageFar				= 17
SWEP.RangeNear				= 20
SWEP.RangeFar				= 40

--
-- Recoil
--
SWEP.RecoilUp							= 1.9 -- degrees punched
SWEP.RecoilUpDecay						= 23 -- how much recoil to remove per second
SWEP.RecoilSide							= 0.7 -- degrees punched, in either direction (-100% to 100%)
SWEP.RecoilSideDecay					= 23 -- how much recoil to remove per second
SWEP.RecoilUpDrift						= 0.7 -- how much will be smooth recoil
SWEP.RecoilSideDrift					= 0.7 -- how much will be smooth recoil
SWEP.RecoilFlipChance					= ( 1 / 6 ) -- chance to flip recoil direction
SWEP.RecoilADSMult						= ( 3 / 4 ) -- multiply shot recoil by this amount when ads'd

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
		Delay = ( 60 / 800 ),
	},
	{
		Count = 2,
		Delay = ( 60 / 1200 ),
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
	Pos = Vector(-2.74, -2, 1.16),
	Ang = Angle(0.2, 0, 0),
}

SWEP.CustomizePose = {
	Pos = Vector(0.3, -1, -0.9),
	Ang = Angle(6, 6, -4),
}

SWEP.Animations = {
	["idle"] = {
		Source = "base_idle",
	},
	["draw"] = {
		Source = "base_draw",
	},
	["holster"] = {
		Source = "base_holster",
	},
	["fire"] = {
		Source = "base_fire",
	},
	["fire_ads"] = {
		Source = "iron_fire",
	},
	["reload"] = {
		Source = "base_reload",
		Time = 2.8,
		LoadIn = 2.0,
		ReloadingTime = 2.6,
		Events = {
			{ t = 0, s = "mfa/zenith/ogg/rattle2.ogg" },
			{ t = 0.1, s = "mfa/zenith/ogg/cloth_soft_2.ogg" },
			{ t = 0.2, s = "mfa/wep/ogg/Reload_1P_MK11_Magout_Wave 0 0 0.ogg" },
			{ t = 0.5, s = "mfa/zenith/ogg/cloth_soft_1.ogg" },
			{ t = 0.9, s = "mfa/zenith/ogg/magpouch_replace_small.ogg" },
			{ t = 1.5, s = "mfa/wep/ogg/Reload_1P_MK11_Magin_Wave 0 0 0.ogg" },
			{ t = 1.8, s = "mfa/zenith/ogg/shoulder.ogg", v = 0.2 },
		}
	},
	["reload_empty"] = {
		Source = "base_reloadempty",
		Time = 3.7,
		LoadIn = 3.1,
		ReloadingTime = 3.4,
		Events = {
			{ t = 0, s = "mfa/zenith/ogg/rattle2.ogg" },
			{ t = 0.1, s = "mfa/zenith/ogg/cloth_soft_2.ogg" },
			{ t = 0.2, s = "mfa/wep/ogg/Reload_1P_MK11_Magout_Wave 0 0 0.ogg" },
			{ t = 0.5, s = "mfa/zenith/ogg/cloth_soft_1.ogg" },
			{ t = 0.9, s = "mfa/zenith/ogg/magpouch_replace_small.ogg" },
			{ t = 1.5, s = "mfa/wep/ogg/Reload_1P_MK11_Magin_Wave 0 0 0.ogg" },
			{ t = 2.25, s = "mfa/wep/ogg/Reload_1P_MK11_Bolt_Wave 0 0 0.ogg", v = 0.5 },
			{ t = 2.7, s = "mfa/zenith/ogg/shoulder.ogg", v = 0.2 },
		}
	}
}