
	-- mfa - my fucking arsenal
	-- by Fesiug
								 
SWEP.Base						= "mfa_base"
SWEP.Spawnable					= true
SWEP.Category					= "MFA"
SWEP.PrintName					= "Revolver"

SWEP.Slot						= 1
SWEP.SlotPos					= 0

SWEP.ViewModel					= "models/weapons/c_iw4_anaconda.mdl"
SWEP.WorldModel					= "models/weapons/w_iw3_beretta.mdl"

SWEP.Stats = {}
local tpa = { ACT_HL2MP_GESTURE_RELOAD_SMG1, ACT_HL2MP_GESTURE_RANGE_ATTACK_SMG1 }
SWEP.Stats = {
	["Appearance"] = {
		["Sounds"]		= {
			["Fire"]					= "OSII.Pistol_Magnum.Fire",
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
		["Damage"]						= Range( 14, 28 ),
		["Range"]						= Range( 400, 1200 ), -- hammer units
		["Spread"]						= Range( 2, 20 ), -- degrees, min to max
		["Spread acceleration time"]	= Range( 2, 1.5 ), -- How long it takes to accurate
		["Force"]						= 1
	},
	["Magazines"] = {
		["Ammo type"]					= "357",
		["Maximum loaded"]				= 6,
		["Amount reloaded"]				= 6,
	},
	["Animation"] = {
		["fire"] = {
			seq = "fire",
			tpanim = tpa[2],
			rate = 0.8,
		},
		["draw"] = {
			seq = "draw",
			rate = 0.8
		},
		["holster"] = {
			seq = "holster",
			rate = 0.75
		},
		["reload"] = {
			seq = "reload",
			tpanim = tpa[1],
			time_load = 1.5,
			rate = 0.85
		},
	},
}