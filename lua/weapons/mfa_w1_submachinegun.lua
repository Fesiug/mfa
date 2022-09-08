
-- Fesiug, 2022

SWEP.Base					= "mfa_base_wep"
SWEP.Spawnable				= true

SWEP.Slot					= 2
SWEP.Category				= "MFA"	
SWEP.PrintName				= "Submachine Gun"
SWEP.Trivia = {
	Category = "Submachine Gun",
	["Real Name"] = "MP5",
}

SWEP.UseHands				= true
SWEP.ViewModel				= "models/mfa/weapons/mp5.mdl"
SWEP.WorldModel				= "models/mfa/weapons/mp5.mdl"
SWEP.ViewModelFOV			= 70

SWEP.Primary.ClipSize		= 30
SWEP.Primary.Ammo			= "pistol"
SWEP.Primary.Sound			= ")weapons/iw4/mp5/fire.wav"

SWEP.DamageNear				= 24
SWEP.DamageFar				= 16
SWEP.RangeNear				= 20
SWEP.RangeFar				= 40

--
-- Recoil
--
SWEP.RecoilUp							= 1.7 -- degrees punched
SWEP.RecoilUpDecay						= 25 -- how much recoil to remove per second
SWEP.RecoilSide							= 0.6 -- degrees punched, in either direction (-100% to 100%)
SWEP.RecoilSideDecay					= 25 -- how much recoil to remove per second
SWEP.RecoilUpDrift						= 0.5 -- how much will be smooth recoil
SWEP.RecoilSideDrift					= 0.5 -- how much will be smooth recoil
SWEP.RecoilFlipChance					= ( 2 / 3 ) -- chance to flip recoil direction
SWEP.RecoilADSMult						= ( 3 / 4 ) -- multiply shot recoil by this amount when ads'd

SWEP.Dispersion				= 0.8
SWEP.Dispersion_Move		= 2 -- at 200 hu/s
SWEP.Dispersion_Air			= 2
SWEP.Dispersion_Crouch		= ( 2 / 3 )
SWEP.Dispersion_Sights		= ( 1 / 3 )

SWEP.Dispersion_FireShoot	= 0.4
SWEP.Dispersion_FireDecay	= 3


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

SWEP.ActivePos = {
	Pos = Vector(-0, 0, -0.4),
	Ang = Angle(),
}

SWEP.IronsightPos = {
	Pos = Vector(-2.31, -2, 0.45),
	Ang = Angle(0, 0, 0),
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
		Events = {
			{ t = 0, s = "mfa/zenith/ogg/rattle2.ogg" },
			{ t = 0.3, s = "mfa/wep/ogg/Reload_1P_MK11_Magout_Wave 0 0 0.ogg" },
			{ t = 0.4, s = "mfa/zenith/ogg/cloth_soft_1.ogg" },
			{ t = 0.7, s = "mfa/zenith/ogg/magpouch_replace_small.ogg" },
			{ t = 1.55, s = "mfa/wep/ogg/Reload_1P_MK11_Magin_Wave 0 0 0.ogg" },
			{ t = 2.0, s = "mfa/zenith/ogg/shoulder.ogg", v = 0.2 },
		},
		Time = 2.8,
		LoadIn = 1.8,
	},
	["reload_empty"] = {
		Source = "base_reloadempty",
		Events = {
			{ t = 0, s = "mfa/zenith/ogg/rattle2.ogg" },
			{ t = 0.05, s = "mfa/wep/ogg/Reload_1P_PP2000_Bolt_Wave 0 0 0.ogg" },
			{ t = 0.4, s = "mfa/zenith/ogg/cloth_soft_2.ogg" },
			{ t = 0.9, s = "mfa/wep/ogg/Reload_1P_MK11_Magout_Wave 0 0 0.ogg" },
			{ t = 1.0, s = "mfa/zenith/ogg/cloth_soft_1.ogg" },
			{ t = 1.5, s = "mfa/zenith/ogg/magpouch_replace_small.ogg" },
			{ t = 2.1, s = "mfa/wep/ogg/Reload_1P_MK11_Magin_Wave 0 0 0.ogg" },
			{ t = 2.6, s = "mfa/wep/ogg/Reload_1P_MK11_Bolt_Wave 0 0 0.ogg" },
			{ t = 3.0, s = "mfa/zenith/ogg/shoulder.ogg", v = 0.2 },
		},
		Time = 3.9,
		LoadIn = 3.1,
	}
}