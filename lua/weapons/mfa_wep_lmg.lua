
	-- mfa - my fucking arsenal
	-- by Fesiug
								 
SWEP.Base						= "mfa_base"
SWEP.Spawnable					= true
SWEP.Category					= "MFA"
SWEP.PrintName					= "Squad Automatic Weapon"

SWEP.ViewModel					= "models/weapons/c_iw3_m249.mdl"
SWEP.WorldModel					= "models/weapons/w_iw3_m249.mdl"

SWEP.Stats = {}
local tpa = { ACT_HL2MP_GESTURE_RELOAD_SMG1, ACT_HL2MP_GESTURE_RANGE_ATTACK_SMG1 }
SWEP.Stats = {
	["Appearance"] = {
		["Sounds"]		= {
			["Fire"]					= "OSII.AssaultRifle.Fire",
			["Dry"]						= "OSII.Pistol.Dry",
		},
		["VM Offset"] = Vector(-0.3, -1, 0.7),
		["Holdtype"] = "smg",
	},
	["Function"] = {
		["Fire delay"]				= (60/700),
		["Fire recovery delay"]			= 0, -- Delay between each burst
		["Ammo used"]			= 1,
		["Ammo required"]		= 1,
		["Shots fired maximum"]			= Range( 0, 0 )
	},
	["Bullet"] = {
		["Count"]						= 1,
		["Damage"]						= Range( 11, 22 ),
		["Range"]						= Range( 500, 1500 ), -- hammer units
		["Spread"]						= Range( 4, 20 ), -- degrees, min to max
		["Spread acceleration time"]	= Range( 3, 1.5 ), -- How long it takes to accurate
		["Force"]						= 1
	},
	["Magazines"] = {
		["Ammo type"]					= "SMG1",
		["Maximum loaded"]				= 100,
		["Amount reloaded"]				= 100,
	},
	["Animation"] = {
		["fire"] = {
			seq = "fire",
			tpanim = tpa[2],
			rate = 1.2,
		},
		["draw"] = {
			seq = "draw",
			rate = 0.8
		},
		["holster"] = {
			seq = "holster",
		},
		["reload"] = {
			seq = "reload",
			tpanim = tpa[1],
			time_load = 1.5,
			rate = 0.8
		},
	},
}