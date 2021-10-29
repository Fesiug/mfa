
	-- mfa - my fucking arsenal
	-- by Fesiug
								 
SWEP.Base						= "mfa_base"
SWEP.Spawnable					= true
SWEP.Category					= "MFA"
SWEP.PrintName					= "Pistol"

SWEP.ViewModel					= "models/weapons/c_iw3_beretta.mdl"
SWEP.WorldModel					= "models/weapons/w_iw3_beretta.mdl"

SWEP.Stats = {}
local tpa = { ACT_HL2MP_GESTURE_RELOAD_SMG1, ACT_HL2MP_GESTURE_RANGE_ATTACK_SMG1 }
SWEP.Stats = {
	["Appearance"] = {
		["Sounds"]		= {
			["Fire"]					= "OSII.Pistol.Fire",
			["Dry"]						= "OSII.Pistol.Dry",
		},
		["Holdtype"] = "smg",
	},
	["Function"] = {
		["Fire delay"]				= (60/400),
		["Fire recovery delay"]			= 0, -- Delay between each burst
		["Ammo used"]			= 1,
		["Ammo required"]		= 1,
		["Shots fired maximum"]			= Range( 1, 1 )
	},
	["Bullet"] = {
		["Count"]						= 1,
		["Damage"]						= Range( 6, 17 ),
		["Range"]						= Range( 400, 1000 ), -- hammer units
		["Spread"]						= Range( 4, 20 ), -- degrees, min to max
		["Spread acceleration time"]	= Range( 2, 1.5 ), -- How long it takes to accurate
		["Force"]						= 1
	},
	["Magazines"] = {
		["Ammo type"]					= "Pistol",
		["Maximum loaded"]				= 16,
		["Amount reloaded"]				= 16,
	},
	["Animation"] = {
		["fire"] = {
			seq = "fire",
			tpanim = tpa[2],
			rate = 0.8,
		},
		["draw"] = {
			seq = "draw",
			rate = 0.3
		},
		["holster"] = {
			seq = "holster",
			rate = 0.75
		},
		["reload_empty"] = {
			seq = "reload_empty",
			tpanim = tpa[1],
			time_load = 1.5,
			rate = 0.85
		},
		["reload_full"] = {
			seq = "reload",
			tpanim = tpa[1],
			time_load = 1.5,
			rate = 0.85
		},
	},
}