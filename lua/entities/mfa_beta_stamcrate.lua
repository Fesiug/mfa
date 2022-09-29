
AddCSLuaFile()

ENT.Type				= "anim"
ENT.Spawnable			= true
ENT.Category			= "MFA"
ENT.PrintName			= "beta stamcrate"

function ENT:Initialize()
	self:SetModel( "models/props_junk/cardboard_box003b.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )
end

function ENT:Use( activator )
	if activator:IsPlayer() then 
		activator:SetNWFloat( "MFA_Stamina", 1 )
		activator:EmitSound( "mfa/beta/numnumnum.ogg", 60 )
		self:Remove()
	end
end