
	-- mfa - my fucking arsenal
	-- by Fesiug
								 -- 8 indents for this stuff pls
								 
SWEP.Base						= "weapon_base"
SWEP.MFA						= true
SWEP.Spawnable					= false
SWEP.Category					= "MFA"
SWEP.PrintName					= "MFA base"

SWEP.Slot						= 0
SWEP.SlotPos					= 0

SWEP.ViewModel					= "models/weapons/c_smg1.mdl"
SWEP.WorldModel					= "models/weapons/w_iw3_mp5.mdl"
SWEP.UseHands					= true
SWEP.ViewModelFOV				= 68

SWEP.Primary.ClipSize			= 0
SWEP.Primary.DefaultClip		= 0
SWEP.Primary.Ammo				= "none"
SWEP.Primary.Automatic			= true

SWEP.Secondary.ClipSize			= 0
SWEP.Secondary.DefaultClip		= 0
SWEP.Secondary.Ammo				= "none"
SWEP.Secondary.Automatic		= true

SWEP.m_WeaponDeploySpeed		= 10
SWEP.BobScale = 0
SWEP.SwayScale = 0

function Range( m, a )
	return { min = m, max = a }
end

SWEP.Stats = {
	["Appearance"] = {
		["Sounds"]		= {
			["Fire"]					= "OSII.SMG.Fire",
			["Dry"]						= "OSII.Pistol.Dry",
		},
		["Holdtype"] = "pistol",
		["VM Offset"] = Vector(0, 0, 0)
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
		["Damage"]						= Range( 11, 19 ),
		["Range"]						= Range( 500, 2000 ), -- hammer units
		["Spread"]						= Range( 1.5, 8 ), -- degrees, min to max
		["Spread acceleration time"]	= Range( 2.5, 0.5 ), -- How long it takes to accurate
		["Force"]						= 1
	},
	["Magazines"] = {
		["Ammo type"]					= "Pistol",
		["Maximum loaded"]				= 30,
		["Amount reloaded"]				= 30,
	},
	["Animation"] = {},
}

sound.Add({
	name = "MFA_Wep.SMG.Fire",
	channel = CHAN_STATIC,
	volume = 1,
	level = 140,
	pitch = pn,
	sound = {
		")mfa/wep/smg/fire1.wav",
		")mfa/wep/smg/fire2.wav",
		")mfa/wep/smg/fire3.wav",
		")mfa/wep/smg/fire4.wav",
	},
})

function SWEP:SetupDataTables()
	self:NetworkVar("Float", 0, "FireDelay")
	self:NetworkVar("Float", 1, "FireRecoveryDelay")
	self:NetworkVar("Float", 2, "ReloadDelay")
	self:NetworkVar("Float", 3, "ReloadLoadDelay")
	self:NetworkVar("Float", 4, "Holster_Time")
	self:NetworkVar("Float", 5, "NextIdle")
	self:NetworkVar("Float", 6, "ADSDelta")
	self:NetworkVar("Float", 7, "AccelInaccuracy")

	self:NetworkVar("Entity", 0, "Holster_Entity")
	
	self:NetworkVar("Int", 0, "BurstCount")

	self:NetworkVar("Bool", 0, "ReloadingState")
	self:NetworkVar("Bool", 1, "Overheated")
end

function SWEP:Initialize()
	if self.Stats["Function"] then
		self.q = self.Stats
		self.qf = self.q["Function"]
		self.qa = self.q["Animation"]
		self.qp = self.q["Appearance"]
		self.qb = self.q["Bullet"]
		self.qm = self.q["Magazines"]

		self.Primary.Ammo = self.qm["Ammo type"]
		self.Primary.ClipSize = self.qm["Maximum loaded"] or 0
	end
end

function SWEP:OnReloaded()
	self:Initialize()
end


-- i take this very ez
local searchdir = "weapons/mfa_base"
local function autoinclude(dir)
	local files, dirs = file.Find(searchdir .. "/*.lua", "LUA")

	for _, filename in pairs(files) do
		if filename == "shared.lua" then continue end
		local luatype = string.sub(filename, 1, 2)

		if luatype == "sv" then
			if SERVER then
				include(dir .. "/" .. filename)
			end
		elseif luatype == "cl" then
			AddCSLuaFile(dir .. "/" .. filename)
			if CLIENT then
				include(dir .. "/" .. filename)
			end
		else
			AddCSLuaFile(dir .. "/" .. filename)
			include(dir .. "/" .. filename)
		end
	end

	for _, path in pairs(dirs) do
		autoinclude(dir .. "/" .. path)
	end
end
autoinclude(searchdir)