
local terminaltest = [[
Cycledroft Corporation (c) 1982-1983. All rights reserved. test test test
Booter [Version 25.12.1983]

SYSTEM TESTING
- 1024 System RAM Ready

- Diskette A
	- not found
- Diskette B
	- not found
- Hard disk C
	- storage 8192
	- Benson Nco Macrocomputing
- Hard disk D
	- not found

- Display
	- 24 rows 18 columns
	- high resolution incapable
	- no high resolution capable graphics device installed

- Keyboard detected

>CHANGEDISK C
>COMMAND.COM
>CLEAR
]]
terminaltest = [[
Cycledroft Corporation (c) 1982-1983. All rights reserved.
Command Interpreter [Version 02.11.1983]
Type HELP for help.

C:/>abcdefghijklmnopqrstuvwxyz_abcdefghijklmnopqrstuvwxyz_abcdefghijklmnopqrstuvwxyz_
]]

CreateClientConVar("mfa_hud_enable", 1)

local hide = {
	["CHudHealth"] = true,
	["CHudBattery"] = true,
	["CHudAmmo"] = true,
	["CHudSecondaryAmmo"] = true,
}

hook.Add( "HUDShouldDraw", "MFA_HUDShouldDraw", function( name )
	if GetConVar("mfa_hud_enable"):GetBool() and ( hide[ name ] ) then
		return false
	end
end)

function MFAS(size)
	local si = (size / ScrH()) * 720
	return si
end

surface.CreateFont("MFA_HUD_96", {
	font = "Carbon Plus Bold",
	size = MFAS(96),
	weight = 200,
})
surface.CreateFont("MFA_HUD_96_Glow", {
	font = "Carbon Plus Bold",
	size = MFAS(96),
	weight = 200,
	scanlines = MFAS(4),
	blursize = MFAS(4),
	additive = true,
})
surface.CreateFont("MFA_HUD_48", {
	font = "Carbon Plus Bold",
	size = MFAS(48),
	weight = 200,
})
surface.CreateFont("MFA_HUD_20", {
	font = "Carbon Plus Bold",
	size = MFAS(30),
	weight = 0,
})
surface.CreateFont("MFA_Terminal", {
	font = "Carbon Plus Bold",
	size = 24,
	weight = 0,
})

local mat_bub = Material( "mfa/hud/bubble.png", "smooth" )
local mat_glow = Material( "mfa/hud/glow.png", "" )
local mat_bub2 = Material( "mfa/hud/shield.png", "" )
local mat_bub4 = Material( "mfa/hud/outl.png", "" )

local mat_bubd_arm_r = Material( "mfa/hud/dmg/arm_r.png", "" )
local mat_bubd_arm_l = Material( "mfa/hud/dmg/arm_l.png", "" )
local mat_bubd_leg_r = Material( "mfa/hud/dmg/leg_r.png", "" )
local mat_bubd_leg_l = Material( "mfa/hud/dmg/leg_l.png", "" )
local mat_bubd_stomach = Material( "mfa/hud/dmg/stomach.png", "" )
local mat_bubd_chest = Material( "mfa/hud/dmg/chest.png", "" )
local mat_bubd_head = Material( "mfa/hud/dmg/head.png", "" )

local CLR_W = Color( 200, 255, 200, 255 )
local CLR_B = Color( 0, 0, 0, 100 )

function ftext( text, font, x, y, c1, c2, b, z )
	local c = MFAS(1)
	local s1, s2 = (c*2), (c*3)
	draw.SimpleText( text, font, x+s1, y+s2, c2, b, z )
	draw.SimpleText( text, font, x, y, c1, b, z )
end

function fbar( x, y, w, h, c1, c2 )
	local c = MFAS(1)
	local s1, s2 = (c*2), (c*3)
	surface.SetDrawColor( c2 )
	surface.DrawRect( x+s1, y+s2, w, h )
	surface.SetDrawColor( c1 )
	surface.DrawRect( x, y, w, h )
end

local tscale = 1
local tscale_last = CurTime()
local lasthealth = 100

local ammolookup = {
	[game.GetAmmoID("pistol")]		= (0.621/30),
	[game.GetAmmoID("buckshot")]	= (3.211/36),
	[game.GetAmmoID("ar2")]			= (0.992/30),
	[game.GetAmmoID("smg1")]		= (0.713/30),
	[game.GetAmmoID("357")]			= (0.889/30),
}

local annoyingshit = {
	{	
		Range_Min = 0.34,
		Range_Max = 0.66,
		Mat = mat_bubd_arm_r,
		Limb = "arm_r",
	},
	{	
		Range_Min = 0.34,
		Range_Max = 0.66,
		Mat = mat_bubd_arm_l,
		Limb = "arm_l",
	},
	{
		Range_Min = 0.63,
		Range_Max = 0.94,
		Mat = mat_bubd_leg_r,
		Limb = "leg_r",
	},
	{
		Range_Min = 0.63,
		Range_Max = 0.94,
		Mat = mat_bubd_leg_l,
		Limb = "leg_l",
	},
	{
		Range_Min = 0.5,
		Range_Max = 0.66,
		Mat = mat_bubd_stomach,
		Limb = "stomach",
	},
	{
		Range_Min = 0.31,
		Range_Max = 0.49,
		Mat = mat_bubd_chest,
		Limb = "chest",
	},
	{
		Range_Min = 0.05,
		Range_Max = 0.28,
		Mat = mat_bubd_head,
		Limb = "head",
	},
}

hook.Add( "HUDPaint", "MFA_HUDPaint", function()
	if GetConVar("mfa_hud_enable"):GetBool() then
		local p = LocalPlayer()
		local c = MFAS(1)
		local s1, s2 = (c*2), (c*3)
		local w, h = ScrW(), ScrH()

		if IsValid(p) and p:Health() > 0 then -- heealth
			surface.SetMaterial( mat_glow )
			surface.SetDrawColor( Color( 0, 0, 0, 255 ) )
			surface.DrawTexturedRect( w - (c*500), h - (c*250), (c*500), (c*250) )
			surface.DrawTexturedRectUV( 0, h - (c*250), (c*500), (c*250), 1, 0, 0, 1 )
			--surface.DrawTexturedRectUV( 0, 0, (c*500), (c*250), 1, 1, 0, 0 )
			--surface.DrawTexturedRectUV( w - (c*500), 0, (c*500), (c*250), 0, 1, 1, 0 )

			surface.SetDrawColor( CLR_B )
			surface.DrawOutlinedRect( (c*30) + s1, h - (c*30) - (c*40) + s2, (c*250), (c*20), (c*3) )
		
			local he = p:Health() / p:GetMaxHealth()
			local mul = Lerp( he, 0.5, 0.9 )
			surface.SetDrawColor( CLR_W.r * mul, CLR_W.g * mul, CLR_W.b * mul )
			surface.DrawRect( (c*30), h - (c*30) - (c*40), (c*250) * he, (c*20) )

			surface.SetDrawColor( CLR_W )
			surface.DrawOutlinedRect( (c*30), h - (c*30) - (c*40), (c*250), (c*20), (c*3) )

			local amt = p:GetNWFloat( "MFA_Stamina", 1 )
			for i=1, 4 do
				local e = i-1
				
				surface.SetDrawColor( CLR_B )
				surface.DrawOutlinedRect( (c*30) + (c*125*e) + s1, h - (c*30) - (c*20) + s2, (c*125), (c*20), (c*3) )

				local mul = Lerp( i/4, 0.5, 0.9 )
				surface.SetDrawColor( CLR_W.r * mul, CLR_W.g * mul, CLR_W.b * mul )
	
				local te = math.Clamp( math.TimeFraction( 0 + (0.25*e), (0.25*i), amt ), 0, 1 )
				surface.DrawRect( (c*30) + (c*125*e), h - (c*30) - (c*20), (c*125 * te), (c*20) )
				
				surface.SetDrawColor( CLR_W )
				surface.DrawOutlinedRect( (c*30) + (c*125*e), h - (c*30) - (c*20), (c*125), (c*20), (c*3) )
			end

			ftext( p:Nick(), "MFA_HUD_48", (c*41), h - (c*106), CLR_W, CLR_B, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP )

			if false then
				if p:Health() != lasthealth then
					lasthealth = p:Health()
					tscale_last = CurTime()
				end
				if true or tscale_last + 3 > CurTime() then
					tscale = math.Approach( tscale, 1, FrameTime() / 0.3 )
				else
					tscale = math.Approach( tscale, 0, FrameTime() / 0.3 )
				end
				local ss_tscale = math.ease.InCirc( tscale ) -- it looks funnier linear 
				fbar( 0, h - (c*82), (c*320), (c*6), CLR_W, CLR_B )
				ftext( p:Nick(), "MFA_HUD_48", (c*28), h - (c*62), CLR_W, CLR_B, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP )
				ftext( string.format( "%.1f", math.Round((p:Health()/p:GetMaxHealth())*100) ) .. "%", "MFA_HUD_48", (c*28), h - (c*140), CLR_W, CLR_B, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP )
			end

			if false then
				local icos = (c*200)
				local pos_x, pos_y = (c*-16), h - (c*350)
				local lool1 = (1-ss_tscale)*(icos*0.5)
				local lool2 = (1-ss_tscale)*icos
		
				if p:GetNWBool("MFAShield", false) then
					surface.SetMaterial( mat_bub4 )
					surface.SetDrawColor( 255, 255, 255, 100 )
					surface.DrawTexturedRect( pos_x, pos_y, icos, icos )
			
					surface.SetMaterial( mat_bub2 )
					surface.SetDrawColor( 255, 255, 255, 50 )
					surface.DrawTexturedRect( pos_x, pos_y, icos, icos )
				end
		
				local he = p:Health() / p:GetMaxHealth()
				for i, data in ipairs(annoyingshit) do
					if !data.Limb then continue end
					local effective = p:GetNWFloat( "MFA_HP_" .. data.Limb, 1 )
					local shithead = 0--math.Clamp( math.Remap( effective, 0, 1, data.Range_Min, data.Range_Max), 0, 1 )

					surface.SetMaterial( data.Mat )
					
					surface.SetDrawColor( 0, 0, 127, 255 )
					surface.DrawTexturedRect( pos_x + lool1, pos_y + lool2, icos*ss_tscale, icos*ss_tscale )

					surface.SetDrawColor( 255, 0, 0, 255*(1-effective) ) -- *(1-he) )
					surface.DrawTexturedRectUV( pos_x + lool1, pos_y + lool2 + (icos*ss_tscale * (shithead)), icos*ss_tscale, icos*ss_tscale * (1-shithead), 0, (shithead), 1, 1 )
				end

				surface.SetMaterial( mat_bub )
				surface.SetDrawColor( CLR_B )
				surface.DrawTexturedRect( pos_x+s1 + lool1, pos_y+s2 + lool2, icos*ss_tscale, icos*ss_tscale )
				surface.SetDrawColor( CLR_W )
				surface.DrawTexturedRect( pos_x + lool1, pos_y + lool2, icos*ss_tscale, icos*ss_tscale )
			end

			if enableditem == "radiopack" then
			-- radar / terminal / teamhealth
			surface.SetDrawColor( CLR_B )
			surface.DrawRect( (c*20), (c*20), (c*20*24), (c*20*18)+(c*10) )
			surface.SetDrawColor( CLR_W )
			surface.DrawOutlinedRect( (c*20), (c*20), (c*20*24), (c*20*18)+(c*10), (c*4) )
			ftext( "RADIOPACK - 87%", "MFA_HUD_20", (c*20), (c*400), CLR_W, CLR_B, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP )
			ftext( os.date( "%H:%M:%S", Timestamp ) .. " - N:40213 SECURE", "MFA_HUD_20", (c*20), (c*425), CLR_W, CLR_B, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP )
			ftext("", "MFA_HUD_20", (c*20), (c*450), CLR_W, CLR_B, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP )

			local ix = 0
			local tx, ty = (c*30), (c*30)
			ftext( "Welcome to 'af4be9'!" or "Type 'help' for instructions.", "MFA_HUD_20", tx, ty+(c*25*ix), CLR_W, CLR_B, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP ) ix = ix + 1
			ftext( "Last login at 8/27/2022 1100.", "MFA_HUD_20", tx, ty+(c*25*ix), CLR_W, CLR_B, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP ) ix = ix + 1
			ix = ix + 1
			ftext( "C1: Network relay online", "MFA_HUD_20", tx, ty+(c*25*ix), CLR_W, CLR_B, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP ) ix = ix + 1
			ftext( "C2: Network relay online", "MFA_HUD_20", tx, ty+(c*25*ix), CLR_W, CLR_B, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP ) ix = ix + 1
			ftext( "C1: CAM#4 alert at 12:00", "MFA_HUD_20", tx, ty+(c*25*ix), CLR_W, CLR_B, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP ) ix = ix + 1
			ftext( "C2: 'Submachine gun' complete", "MFA_HUD_20", tx, ty+(c*25*ix), CLR_W, CLR_B, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP ) ix = ix + 1
			ftext( "C2: 'Pistol ammo x30' complete", "MFA_HUD_20", tx, ty+(c*25*ix), CLR_W, CLR_B, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP ) ix = ix + 1
			ftext( "C2: 'Pistol ammo x30' complete", "MFA_HUD_20", tx, ty+(c*25*ix), CLR_W, CLR_B, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP ) ix = ix + 1
			ftext( "C2: 'Pistol' complete", "MFA_HUD_20", tx, ty+(c*25*ix), CLR_W, CLR_B, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP ) ix = ix + 1
			ftext( "C1: TUR#2 serious damage - 30%", "MFA_HUD_20", tx, ty+(c*25*ix), CLR_W, CLR_B, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP ) ix = ix + 1
			ftext( "C1: TUR#1 power failure - 2%", "MFA_HUD_20", tx, ty+(c*25*ix), CLR_W, CLR_B, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP ) ix = ix + 1
			ix = ix + 1
			ftext( "TERM> " .. "C1 sudo rm rf /" .. (CurTime() % 1 > 0.5 and "_" or ""), "MFA_HUD_20", tx, ty+(c*25*ix), CLR_W, CLR_B, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP ) ix = ix + 1
			end

			if enableditem == "radiopack2" then

			surface.SetDrawColor( Color(50, 50, 50) )
			surface.DrawRect( 0, 0, 640, 480 )

			local screenbuffer = terminaltest
			local stronk = string.Explode("\n", screenbuffer)
			for i, v in ipairs(stronk) do
				while #stronk < 24 do--for a=1, 24 do
					table.insert(stronk, " ")
				end
			end
			for i, v in ipairs(stronk) do
				for a=1, (64-#v) do
					stronk[i] = stronk[i] .. " "
				end
			end
			--PrintTable(stronk)
			local max_w = 64
			local max_h = 24
			for i, v in ipairs(stronk) do
				--print(i, v)
				local coc = string.Explode("", v)
				for h, x in ipairs(coc) do
					if h > max_w then continue end
					if i > max_h then continue end
					--if h == max_w and (CurTime() % 2 > 1) and x != " " then x = ">" end
					--if i == max_h and (CurTime() % 2 > 1) and x != " " then x = "v" end
					local wh = h - Lerp( h/max_w, 0, 1 )
					local wi = i - Lerp( i/max_h, 0, 1 )
					surface.SetDrawColor( Color(0, 0, 0) )
					surface.DrawRect( Lerp( wh/max_w, 0, 640 ) - (Lerp( 1/max_w, 0, 640 )*0.5), Lerp( wi/max_h, 0, 480 ) - (Lerp( 1/max_h, 0, 480 )*0.5), Lerp( 1/max_w, 0, 640 ), Lerp( 1/max_h, 0, 480 ) )
				end
				for h, x in ipairs(coc) do
					if h > max_w then continue end
					if i > max_h then continue end
					--if h == max_w and (CurTime() % 2 > 1) and x != " " then x = ">" end
					--if i == max_h and (CurTime() % 2 > 1) and x != " " then x = "v" end
					local wh = h - Lerp( h/max_w, 0, 1 )
					local wi = i - Lerp( i/max_h, 0, 1 )
					ftext( x, "MFA_Terminal", Lerp( wh/max_w, 0, 640 ), Lerp( wi/max_h, 0, 480 ), CLR_W, CLR_B, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
				end
			end

		end

		end
		

		local wep = p:GetActiveWeapon()
		if !IsValid(wep) then wep = false end
		if wep then -- weap
			--fbar( w - (c*320), h - (c*82), (c*320), (c*6), CLR_W, CLR_B )
			ftext( wep:GetPrintName(), "MFA_HUD_48", w-(c*28), h - (c*62), CLR_W, CLR_B, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP )

			local ftn
			if wep.GetFiremodeName then
				ftext( string.upper(wep:GetFiremodeName()), "MFA_HUD_20", w-(c*30), h - (c*56), CLR_W, CLR_B, TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM )
			end

			local amit = wep:GetPrimaryAmmoType()
			local ami = wep:GetPrimaryAmmoType()
			if ami > 0 then
				ami = p:GetAmmoCount(ami)
			else
				ami = 0
			end
			local amiw = ami
			if ammolookup[amit] then
				amiw = ami * ammolookup[amit]
			else
				amiw = ami * 1.337
			end
			ftext( "(" .. string.format("%.3f", amiw) .. "kg) " .. ami, "MFA_HUD_20", w-(c*30), h - (c*121), CLR_W, CLR_B, TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM )

			local wa = w - (c*28)
			for i=1, wep:GetMaxClip1() do
				surface.SetDrawColor( CLR_B )
				surface.DrawRect( wa - i * math.ceil(c*7) + s1, h - (c*122) + s2, math.Round(c*5), (c*30) )
			end
			for i=1, wep:Clip1() do
				surface.SetDrawColor( (i > wep:GetMaxClip1() and Color(255, 0, 0)) or CLR_W )
				surface.DrawRect( wa - i * math.ceil(c*7), h - (c*122), math.Round(c*5), (c*30) )
			end

		end
	end
end)

concommand.Add("mfa_cl_show_inventory", function()
	local c = MFAS(1)
	local main = vgui.Create("DFrame", nil)
	main:SetSize( (c*400), (c*300) )
	main:Center()
	main:MakePopup()
	main:ShowCloseButton(false)
	main:SetTitle("")
	function main:Paint(w, h)
		local old = DisableClipping(true)
		local b = (c*5)
		surface.SetDrawColor(CLR_B)
		surface.DrawRect(0, 0, w, h)

		surface.SetDrawColor(CLR_W)
		surface.DrawRect(0, 0, w, b)
		surface.DrawRect(0, h-b, w, b)
		surface.DrawRect(0, 0, b, h)
		surface.DrawRect(w-b, 0, b, h)
		DisableClipping(old)
		return true
	end
	do
		local close = vgui.Create("DButton", main)
		close:SetSize( (c*30), (c*30) )
		close:SetPos( main:GetSize() - (c*10) - (c*30), (c*10) )
		function close:Paint(w, h)
			local b = (c*5)
			surface.SetDrawColor(CLR_W)
			surface.DrawRect(0, 0, w, b)
			surface.DrawRect(0, h-b, w, b)
			surface.DrawRect(0, 0, b, h)
			surface.DrawRect(w-b, 0, b, h)
		return true
		end
		function close:DoClick()
			close:GetParent():Close()
		end
	end
end)

--[[

1 pound = 0.453592 kilo

Caliber			Bullets per lb		lbs per 100		kilo per 100
.22 LR			175					0.57			0.25,854744
9 mm			56					1.77			0.80,285784
.308 Win.		42					2.36			1.07,047712
.223 Rem.		127					0.78			0.35,380176
12 Ga.			18					5.47			2.48,114824
0.45 ACP		30					3.28			1.48,778176

0.38 spec.		53					1.88			0.00
.30-06			46					2.14			0.00
.30-30			41					2.42			0.00
7 mm			38					2.57			0.00
0.40 S&W		42					2.35			0.00

]]