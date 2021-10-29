
	-- mfa - my fucking arsenal
	-- by Fesiug
								 
SWEP.Base						= "mfa_base"
SWEP.Spawnable					= true
SWEP.Category					= "MFA"
SWEP.PrintName					= "Bolt-Action Rifle"

SWEP.Slot						= 2
SWEP.SlotPos					= 0

SWEP.ViewModel					= "models/weapons/v_waw_mosin_irons.mdl"
SWEP.WorldModel					= "models/weapons/w_waw_mosin_irons.mdl"

SWEP.Stats = {}
local tpa = { ACT_HL2MP_GESTURE_RELOAD_SMG1, ACT_HL2MP_GESTURE_RANGE_ATTACK_SMG1 }
SWEP.Stats = {
	["Appearance"] = {
		["Sounds"]		= {
			["Fire"]					= "OSII.Pistol_Magnum.Fire",
			["Dry"]						= "OSII.Pistol.Dry",
		},
		["VM Offset"] = Vector(1, 5, 2),
		["Holdtype"] = "smg",
	},
	["Function"] = {
		["Fire delay"]				= 1.8,
		["Fire recovery delay"]			= 0, -- Delay between each burst
		["Ammo used"]			= 1,
		["Ammo required"]		= 1,
		["Shots fired maximum"]			= Range( 0, 0 )
	},
	["Bullet"] = {
		["Count"]						= 1,
		["Damage"]						= Range( 55, 60 ),
		["Range"]						= Range( 2000, 3000 ), -- hammer units
		["Spread"]						= Range( 0.2, 1 ), -- degrees, min to max
		["Spread acceleration time"]	= Range( 1, 1.5 ), -- How long it takes to accurate
		["Force"]						= 1
	},
	["Magazines"] = {
		["Ammo type"]					= "AR2",
		["Maximum loaded"]				= 5,
		["Amount reloaded"]				= 5,
	},
	["Animation"] = {
		["fire"] = {
			seq = "fire",
			tpanim = tpa[2],
			rate = 0.8,
		},
		["draw"] = {
			seq = "draw1",
			rate = 0.8
		},
		["holster"] = {
			seq = "holster",
			rate = 0.6
		},
		["reload"] = {
			seq = "reload_tac",
			tpanim = tpa[1],
			time_load = 1.5,
			rate = 0.7
		},
	},
}