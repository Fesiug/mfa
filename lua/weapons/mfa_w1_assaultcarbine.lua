
-- Fesiug, 2022

SWEP.Base					= "mfa_base_wep"
SWEP.Spawnable				= true

SWEP.Slot					= 2
SWEP.Category				= "MFA"	
SWEP.PrintName				= "Assault Carbine"
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
SWEP.Primary.Sound			= ")weapons/iw3/g36c/fire.wav"

SWEP.DamageNear				= 30
SWEP.DamageFar				= 26
SWEP.RangeNear				= 20
SWEP.RangeFar				= 50

--
-- Recoil
--
SWEP.RecoilUp							= 2.5 -- degrees punched
SWEP.RecoilUpDecay						= 25 -- how much recoil to remove per second
SWEP.RecoilSide							= 0.6 -- degrees punched, in either direction (-100% to 100%)
SWEP.RecoilSideDecay					= 25 -- how much recoil to remove per second
SWEP.RecoilUpDrift						= 0.5 -- how much will be smooth recoil
SWEP.RecoilSideDrift					= 0.5 -- how much will be smooth recoil
SWEP.RecoilFlipChance					= ( 1 / 3 ) -- chance to flip recoil direction
SWEP.RecoilADSMult						= ( 3 / 4 ) -- multiply shot recoil by this amount when ads'd

-- after the fact
SWEP.Recoil2UpDrift						= 0.1 -- how much to return to the original pos
SWEP.Recoil2SideDrift					= 0.1
SWEP.Recoil2UpDecay						= 23 -- how much recoil to remove per second
SWEP.Recoil2SideDecay					= 23 


SWEP.Dispersion				= 0.7
SWEP.Dispersion_Move		= 3 -- at 200 hu/s
SWEP.Dispersion_Air			= 4
SWEP.Dispersion_Crouch		= ( 2 / 3 )
SWEP.Dispersion_Sights		= ( 1 / 3 )

SWEP.Dispersion_FireShoot	= 0.4
SWEP.Dispersion_FireDecay	= 3


SWEP.Firemodes = {
	{
		Count = math.huge,
		Delay = ( 60 / 750 ),
	},
	{
		Count = 1,
		Delay = ( 60 / 1200 )
	}
}

SWEP.ActivePos = {
	Pos = Vector(0.2, -1, 0.2),
	Ang = Angle(),
}

SWEP.IronsightPos = {
	Pos = Vector(-2.39, -2, 0.45),
	Ang = Angle(0, 0, 0),
}

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
	},
	["fire_ads"] = {
		Source = "iron_fire",
	},
	["reload"] = {
		Source = "base_reload",
		Events = {
			{ t = 0, s = "mfa/zenith/ogg/raise.ogg" },
			{ t = 0.3, s = "mfa/wep/ogg/Reload_1P_SG553_Magout_Wave 0 0 0.ogg" },
			{ t = 1.3, s = "mfa/zenith/ogg/cloth_soft_3.ogg", v = 0.2 },
			{ t = 1.5, s = "mfa/zenith/ogg/magpouch.ogg" },
			{ t = 2.2, s = "mfa/wep/ogg/Reload_1P_SG553_Magin_Wave 0 0 0.ogg" },
			{ t = 2.6, s = "mfa/zenith/ogg/cloth_soft_1.ogg", v = 0.5 },
			{ t = 2.9, s = "mfa/zenith/ogg/magimpact.ogg" },
		},
		Time = 3.5,
		LoadIn = 2.7,
	},
	["reload_empty"] = {
		Source = "base_reloadempty",
		Events = {
			{ t = 0.3, s = "mfa/wep/ogg/Reload_1P_SG553_Magout_Wave 0 0 0.ogg" },
			{ t = 1.3, s = "mfa/zenith/ogg/cloth_soft_3.ogg", v = 0.2 },
			{ t = 1.5, s = "mfa/zenith/ogg/magpouch.ogg" },
			{ t = 2.2, s = "mfa/wep/ogg/Reload_1P_SG553_Magin_Wave 0 0 0.ogg" },
			{ t = 2.6, s = "mfa/wep/ogg/Reload_1P_AEK971_Bolt_Wave 0 0 0.ogg" },
			{ t = 2.8, s = "mfa/zenith/ogg/cloth_soft_1.ogg", v = 0.5 },
			{ t = 3.0, s = "mfa/zenith/ogg/magimpact.ogg" },
		},
		Time = 4.2,
		LoadIn = 3.7,
	}
}