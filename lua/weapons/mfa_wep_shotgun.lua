
	-- mfa - my fucking arsenal
	-- by Fesiug
								 
SWEP.Base						= "mfa_base"
SWEP.Spawnable					= true
SWEP.Category					= "MFA"
SWEP.PrintName					= "Shotgun"

SWEP.Slot						= 2
SWEP.SlotPos					= 0

SWEP.ViewModel					= "models/weapons/c_iw3_w1200.mdl"
SWEP.WorldModel					= "models/weapons/w_iw3_w1200.mdl"

SWEP.Stats = {}
local tpa = { ACT_HL2MP_GESTURE_RELOAD_SMG1, ACT_HL2MP_GESTURE_RANGE_ATTACK_SMG1 }
SWEP.Stats = {
	["Appearance"] = {
		["Sounds"]		= {
			["Fire"]					= "OSII.Shotgun.Fire",
			["Dry"]						= "OSII.Pistol.Dry",
		},
		["VM Offset"] = Vector(0, -3, 0),
		["Holdtype"] = "smg",
	},
	["Function"] = {
		["Fire delay"]				= 0.6,
		["Fire recovery delay"]			= 0, -- Delay between each burst
		["Ammo used"]			= 1,
		["Ammo required"]		= 1,
		["Shots fired maximum"]			= Range( 1, 1 )
	},
	["Bullet"] = {
		["Count"]						= 15,
		["Damage"]						= Range( 1, 7 ),
		["Range"]						= Range( 100, 1000 ), -- hammer units
		["Spread"]						= Range( 8, 8 ), -- degrees, min to max
		["Spread acceleration time"]	= Range( 0, 0 ), -- How long it takes to accurate
		["Force"]						= 1
	},
	["Magazines"] = {
		["Ammo type"]					= "Buckshot",
		["Maximum loaded"]				= 6,
		["Amount reloaded"]				= 1,
		["Don't unload"]				= true,
	},
	["Animation"] = {
		["fire"] = {
			seq = "pump",
			tpanim = tpa[2],
			rate = 0.6,
		},
		["draw"] = {
			seq = "draw",
			rate = 0.8
		},
		["holster"] = {
			seq = "holster",
		},
		["reload_enter"] = {
			seq = "reload_start",
			tpanim = tpa[1],
			time_load = 0.2,
			rate = 0.9
		},
		["reload_insert"] = {
			seq = "reload",
			tpanim = tpa[1],
			time_load = 0.5,
			rate = 0.95
		},
		["reload_exit"] = {
			seq = "reload_end",
			rate = 0.9
		},
	},
}