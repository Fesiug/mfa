
	-- mfa - my fucking arsenal
	-- by Fesiug
								 
SWEP.Base						= "mfa_base"
SWEP.Spawnable					= true
SWEP.Category					= "MFA"
SWEP.PrintName					= "Sub-Machine Gun"

SWEP.Slot						= 2
SWEP.SlotPos					= 0

SWEP.ViewModel					= "models/weapons/c_iw3_mp5.mdl"
SWEP.WorldModel					= "models/weapons/w_iw3_mp5.mdl"

SWEP.Stats = {}
local tpa = { ACT_HL2MP_GESTURE_RELOAD_SMG1, ACT_HL2MP_GESTURE_RANGE_ATTACK_SMG1 }
SWEP.Stats = {
	["Appearance"] = {
		["Sounds"]		= {
			["Fire"]					= "OSII.SMG.Fire",
			["Dry"]						= "OSII.Pistol.Dry",
		},
		["VM Offset"] = Vector(0.25, 1, 0),
		["Holdtype"] = "smg",
	},
	["Function"] = {
		["Fire delay"]				= (60/800),
		["Fire recovery delay"]			= 0, -- Delay between each burst
		["Ammo used"]			= 1,
		["Ammo required"]		= 1,
		["Shots fired maximum"]			= Range( 0, 0 )
	},
	["Bullet"] = {
		["Count"]						= 1,
		["Damage"]						= Range( 11, 22 ),
		["Range"]						= Range( 500, 1500 ), -- hammer units
		["Spread"]						= Range( 3, 20 ), -- degrees, min to max
		["Spread acceleration time"]	= Range( 2.5, 1.5 ), -- How long it takes to accurate
		["Force"]						= 1
	},
	["Magazines"] = {
		["Ammo type"]					= "Pistol",
		["Maximum loaded"]				= 30,
		["Amount reloaded"]				= 30,
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
		["reload_empty"] = {
			seq = "reload_empty",
			tpanim = tpa[1],
			time_load = 1.5,
			rate = 0.9
		},
		["reload_full"] = {
			seq = "reload",
			tpanim = tpa[1],
			time_load = 1.5,
			rate = 0.9
		},
	},
}