
	-- mfa - my fucking arsenal
	-- by Fesiug
								 
SWEP.Base						= "mfa_base"
SWEP.Spawnable					= true
SWEP.Category					= "MFA"
SWEP.PrintName					= "Double-Barreled Shotgun"

SWEP.ViewModel					= "models/weapons/v_waw_doublebar_new.mdl"
SWEP.WorldModel					= "models/weapons/w_waw_doublebar_new.mdl"

SWEP.Stats = {}
local tpa = { ACT_HL2MP_GESTURE_RELOAD_SMG1, ACT_HL2MP_GESTURE_RANGE_ATTACK_SMG1 }
SWEP.Stats = {
	["Appearance"] = {
		["Sounds"]		= {
			["Fire"]					= "OSII.Shotgun.Fire",
			["Dry"]						= "OSII.Pistol.Dry",
		},
		["VM Offset"] = Vector(-0.5, 6, 0.5),
		["Holdtype"] = "smg",
	},
	["Function"] = {
		["Fire delay"]				= 0.25,
		["Fire recovery delay"]			= 0, -- Delay between each burst
		["Ammo used"]			= 1,
		["Ammo required"]		= 1,
		["Shots fired maximum"]			= Range( 1, 1 )
	},
	["Bullet"] = {
		["Count"]						= 15,
		["Damage"]						= Range( 3, 1 ),
		["Range"]						= Range( 500, 1500 ), -- hammer units
		["Spread"]						= Range( 8, 8 ), -- degrees, min to max
		["Spread acceleration time"]	= Range( 0, 0 ), -- How long it takes to accurate
		["Force"]						= 1
	},
	["Magazines"] = {
		["Ammo type"]					= "Buckshot",
		["Maximum loaded"]				= 2,
		["Amount reloaded"]				= 2,
	},
	["Animation"] = {
		["fire"] = {
			seq = "fire",
			tpanim = tpa[2],
			rate = 0.6,
		},
		["draw"] = {
			seq = "draw1",
			rate = 0.8
		},
		["holster"] = {
			seq = "holster",
		},
		["reload_empty"] = {
			seq = "reload_empty",
			tpanim = tpa[1],
			time_load = 2,
			rate = 0.9
		},
		["reload_full"] = {
			seq = "reload_tac",
			tpanim = tpa[1],
			time_load = 2,
			rate = 0.9
		},
	},
}