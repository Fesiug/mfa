
AddCSLuaFile()

ENT.Type				= "anim"
ENT.Spawnable			= false
ENT.Category			= "MFA - foodstuffs"
ENT.PrintName			= "forgable material"

ENT.Model				= "models/props_junk/cardboard_box003b.mdl"
ENT.NutValue			= 1 -- LOL

local function quickie(en)
	if istable(en) then
		return table.Random(en)
	else
		return en
	end
end

function ENT:Initialize()
	self:SetModel( quickie( self.Model ) )
	self:PhysicsInit( SOLID_VPHYSICS )
end

function ENT:Use( activator )
	if activator:IsPlayer() then
		local stammy = activator:GetNWFloat( "MFA_Stamina", 1 )
		if stammy < 1 then
			activator:SetNWFloat( "MFA_Stamina", math.Clamp( stammy + self.NutValue, 0, 1 ) )
			activator:EmitSound( "mfa/beta/numnumnum.ogg", 60 )
			activator:ChatPrint( string.format("consumed %s, recovered %.0f%%", self.PrintName, self.NutValue*100 ) )
			self:Remove()
		end
	end
end