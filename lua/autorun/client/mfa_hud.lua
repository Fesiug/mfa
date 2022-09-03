
CreateClientConVar("mfa_hud", 1)

local hide = {
	["CHudHealth"] = true,
	["CHudBattery"] = true,
	["CHudAmmo"] = true,
	["CHudSecondaryAmmo"] = true,
}

hook.Add( "HUDShouldDraw", "MFA_HUDShouldDraw", function( name )
	if GetConVar("mfa_hud"):GetBool() and ( hide[ name ] ) then
		return false
	end
end)

function MHAS(size)
	local si = (size / ScrH()) * 720
	return si
end

surface.CreateFont("MFA_HUD_48", {
	font = "Carbon Plus Bold",
	size = MHAS(48),
	weight = 200,
})
surface.CreateFont("MFA_HUD_20", {
	font = "Carbon Plus Bold",
	size = MHAS(30),
	weight = 0,
})

local mat_bub = Material( "mfa/hud/bubble.png", "smooth" )
local mat_glow = Material( "mfa/hud/glow.png", "" )
local mat_bubd = Material( "mfa/hud/damage.png", "" )
local mat_bub2 = Material( "mfa/hud/shield.png", "" )
local mat_bub4 = Material( "mfa/hud/outl.png", "" )

local CLR_W = Color( 200, 255, 200, 255 )
local CLR_B = Color( 0, 0, 0, 100 )

function ftext( text, font, x, y, c1, c2, b, z )
	local c = MHAS(1)
	local s1, s2 = (c*2), (c*3)
	draw.SimpleText( text, font, x+s1, y+s2, c2, b, z )
	draw.SimpleText( text, font, x, y, c1, b, z )
end

function fbar( x, y, w, h, c1, c2 )
	local c = MHAS(1)
	local s1, s2 = (c*2), (c*3)
	surface.SetDrawColor( c2 )
	surface.DrawRect( x+s1, y+s2, w, h )
	surface.SetDrawColor( c1 )
	surface.DrawRect( x, y, w, h )
end

local tscale = 1
local tscale_last = CurTime()
local lasthealth = 100

hook.Add( "HUDPaint", "MFA_HUDPaint", function()
	if GetConVar("mfa_hud"):GetBool() then
		local p = LocalPlayer()
		local c = MHAS(1)
		local s1, s2 = (c*2), (c*3)
		local w, h = ScrW(), ScrH()

		if p:Health() > 0 then -- heealth
			surface.SetMaterial( mat_glow )
			surface.SetDrawColor( Color( 0, 0, 0, 255 ) )
			surface.DrawTexturedRect( w - (c*500), h - (c*250), (c*500), (c*250) )
			surface.DrawTexturedRectUV( 0, h - (c*250), (c*500), (c*250), 1, 0, 0, 1 )
			--surface.DrawTexturedRectUV( 0, 0, (c*500), (c*250), 1, 1, 0, 0 )
			--surface.DrawTexturedRectUV( w - (c*500), 0, (c*500), (c*250), 0, 1, 1, 0 )

			if p:Health() != lasthealth then
				lasthealth = p:Health()
				tscale_last = CurTime()
			end
			if tscale_last + 3 > CurTime() then
				tscale = math.Approach( tscale, 1, FrameTime() / 0.3 )
			else
				tscale = math.Approach( tscale, 0, FrameTime() / 0.3 )
			end
			fbar( 0, h - (c*82), (c*320), (c*6), CLR_W, CLR_B )
			ftext( "Fesiug", "MFA_HUD_48", (c*28), h - (c*62), CLR_W, CLR_B, TEXT_ALIGN_TOP, TEXT_ALIGN_TOP )
			ftext( math.Round((p:Health()/p:GetMaxHealth())*100) .. "%", "MFA_HUD_48", (c*28), h - (c*Lerp(1-tscale, 420, 80)), CLR_W, CLR_B, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM )

			local icos = (c*350)
			local lool1 = (1-tscale)*(icos*0.5)
			local lool2 = (1-tscale)*icos

			surface.SetMaterial( mat_bub )
			surface.SetDrawColor( CLR_B )
			surface.DrawTexturedRect( -(c*40)+s1 + lool1, h - (c*430)+s2 + lool2, (c*350)*tscale, (c*350)*tscale )
			surface.SetDrawColor( CLR_W )
			surface.DrawTexturedRect( -(c*40) + lool1, h - (c*430) + lool2, (c*350)*tscale, (c*350)*tscale )
	
			if p:GetNWBool("MHAshield", false) then
				surface.SetMaterial( mat_bub4 )
				surface.SetDrawColor( 255, 255, 255, 100 )
				surface.DrawTexturedRect( -(c*40), h - (c*430), (c*350), (c*350) )
		
				surface.SetMaterial( mat_bub2 )
				surface.SetDrawColor( 255, 255, 255, 50 )
				surface.DrawTexturedRect( -(c*40), h - (c*430), (c*350), (c*350) )
			end
	
			local he = p:Health() / p:GetMaxHealth()
			surface.SetDrawColor( 255, 0, 0, 255*(1-he) )
			surface.SetMaterial( mat_bubd )
			surface.DrawTexturedRect( -(c*40) + lool1, h - (c*430) + lool2, (c*350)*tscale, (c*350)*tscale )
		end

		local wep = p:GetActiveWeapon()
		if !IsValid(wep) then wep = false end
		if wep then -- weap
			--fbar( w - (c*320), h - (c*82), (c*320), (c*6), CLR_W, CLR_B )
			ftext( wep:GetPrintName(), "MFA_HUD_48", w-(c*28), h - (c*62), CLR_W, CLR_B, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP )

			local ftn
			if wep.GetFiremodeTable then
				ftn = wep:GetFiremodeTable(wep:GetFiremode()).Count
				if ftn == math.huge then
					ftn = "AUTOMATIC"
				elseif ftn == 1 then
					ftn = "SEMI-AUTOMATIC"
				else
					ftn = ftn .. "-ROUND BURST"
				end
				ftext( ftn, "MFA_HUD_20", w-(c*30), h - (c*56), CLR_W, CLR_B, TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM )
			end

			local wa = w - (c*28)
			for i=1, wep:GetMaxClip1() do
				surface.SetDrawColor( CLR_B )
				surface.DrawRect( wa - i * math.ceil(c*11) + s1, h - (c*122) + s2, math.Round(c*9), (c*30) )
			end
			for i=1, wep:Clip1() do
				surface.SetDrawColor( (i > wep:GetMaxClip1() and Color(255, 0, 0)) or CLR_W )
				surface.DrawRect( wa - i * math.ceil(c*11), h - (c*122), math.Round(c*9), (c*30) )
			end

		end
	end
end)