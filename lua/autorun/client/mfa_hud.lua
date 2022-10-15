
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

C:/>abcdefghijklmnopqrstuvwxyz_abcdefghijklmnopqrstuvwxyz_abcdefghijklmnopqrstuvwxyz
]]

CreateClientConVar("mfa_hud_enable", 1)
CreateClientConVar("mfa_hud_scale", 1)

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

function MFAS2(size)
	local si = (size / ScrH()) * 720
	si = si * GetConVar("mfa_hud_scale"):GetFloat()
	si = math.Round( si )
	return si
end

function MFA_genfont()
	surface.CreateFont("MFA_HUD_96", {
		font = "Carbon Plus Bold",
		size = MFAS2(96),
		weight = 200,
	})
	surface.CreateFont("MFA_HUD_96_Glow", {
		font = "Carbon Plus Bold",
		size = MFAS2(96),
		weight = 200,
		scanlines = MFAS2(4),
		blursize = MFAS2(4),
		additive = true,
	})
	surface.CreateFont("MFA_HUD_48", {
		font = "Carbon Plus Bold",
		size = MFAS2(48),
		weight = 200,
	})
	surface.CreateFont("MFA_HUD_20", {
		font = "Carbon Plus Bold",
		size = MFAS2(30),
		weight = 0,
	})
	surface.CreateFont("MFA_HUD_5", {
		font = "Carbon Plus Bold",
		size = MFAS2(20),
		weight = 0,
	})
	surface.CreateFont("MFA_Terminal", {
		font = "Carbon Plus Bold",
		size = 24,
		weight = 0,
	})
end
MFA_genfont()

cvars.AddChangeCallback("mfa_hud_scale", function()
	MFA_genfont()
end, "mfa_hudscale")

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
	local dd = MFAS2
	local s1, s2 = dd(2), dd(3)
	draw.SimpleText( text, font, x+s1, y+s2, c2, b, z )
	draw.SimpleText( text, font, x, y, c1, b, z )
end

function fbar( x, y, w, h, c1, c2 )
	local dd = MFAS2
	local s1, s2 = dd(2), dd(3)
	surface.SetDrawColor( c2 )
	surface.DrawRect( x+s1, y+s2, w, h )
	surface.SetDrawColor( c1 )
	surface.DrawRect( x, y, w, h )
end

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
		Limb = "Right Arm",
	},
	{
		Range_Min = 0.34,
		Range_Max = 0.66,
		Mat = mat_bubd_arm_l,
		Limb = "Left Arm",
	},
	{
		Range_Min = 0.63,
		Range_Max = 0.94,
		Mat = mat_bubd_leg_r,
		Limb = "Right Leg",
	},
	{
		Range_Min = 0.63,
		Range_Max = 0.94,
		Mat = mat_bubd_leg_l,
		Limb = "Left Leg",
	},
	{
		Range_Min = 0.5,
		Range_Max = 0.66,
		Mat = mat_bubd_stomach,
		Limb = "Stomach",
	},
	{
		Range_Min = 0.31,
		Range_Max = 0.49,
		Mat = mat_bubd_chest,
		Limb = "Chest",
	},
	{
		Range_Min = 0.05,
		Range_Max = 0.28,
		Mat = mat_bubd_head,
		Limb = "Head",
	},
}

hook.Add( "HUDPaint", "MFA_HUDPaint", function()
	if GetConVar("mfa_hud_enable"):GetBool() then
		local p = LocalPlayer()
		local dd = MFAS2
		local s1, s2 = dd(2), dd(3)
		local w, h = ScrW(), ScrH()

		if IsValid(p) and p:Health() > 0 then -- heealth
			surface.SetMaterial( mat_glow )
			surface.SetDrawColor( Color( 0, 0, 0, 255 ) )
			surface.DrawTexturedRect( w - dd(500), h - dd(250), dd(500), dd(250) )
			surface.DrawTexturedRectUV( 0, h - dd(250), dd(500), dd(250), 1, 0, 0, 1 )
			--surface.DrawTexturedRectUV( 0, 0, (c*500), (c*250), 1, 1, 0, 0 )
			--surface.DrawTexturedRectUV( w - (c*500), 0, (c*500), (c*250), 0, 1, 1, 0 )

			do
				local icos = dd(300)
				local pos_x, pos_y = dd(-125), h - dd(680)
				local lool1 = (icos*0.5)
				local lool2 = icos

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
					local effective = MFA.Medical.LimbHealth(p, data.Limb) -- p:GetNWFloat( "MFA_HP_" .. data.Limb, 1 )
					local shithead = 0--math.Clamp( math.Remap( effective, 0, 1, data.Range_Min, data.Range_Max), 0, 1 )

					surface.SetMaterial( data.Mat )

					surface.SetDrawColor( 0, 0, 127, 0 )
					surface.DrawTexturedRect( pos_x + lool1, pos_y + lool2, icos, icos )

					surface.SetDrawColor( 255, 0, 0, 255*(1-effective) ) -- *(1-he) )
					surface.DrawTexturedRectUV( pos_x + lool1, pos_y + lool2 + (icos * (shithead)), icos, icos * (1-shithead), 0, (shithead), 1, 1 )
				end

				surface.SetMaterial( mat_bub )
				surface.SetDrawColor( CLR_B )
				surface.DrawTexturedRect( pos_x+s1 + lool1, pos_y+s2 + lool2, icos, icos )
				surface.SetDrawColor( CLR_W )
				surface.DrawTexturedRect( pos_x + lool1, pos_y + lool2, icos, icos )
			end

			for i = 1, 7 do
				local limb, limb_s
				local posx, posy = 0, 0
				if i == 1 then
					limb = "Head"
					posy = 4
				elseif i == 2 then
					limb = "Chest"
					posy = 77
				elseif i == 3 then
					limb = "Stomach"
					posy = 128
				elseif i == 4 then
					limb = "Left Arm"
					limb_s = "l_arm"
					posx = -98
					posy = 61
				elseif i == 5 then
					limb = "Right Arm"
					limb_s = "r_arm"
					posx = 98
					posy = 61
				elseif i == 6 then
					limb = "Left Leg"
					limb_s = "l_leg"
					posx = -84
					posy = 187
				elseif i == 7 then
					limb = "Right Leg"
					limb_s = "r_leg"
					posx = 84
					posy = 187
				else
					continue
				end

				ftext( string.format( "%s", string.upper(limb_s or limb)), "MFA_HUD_5", dd(175 + posx), h - dd(340 - posy), CLR_W, CLR_B, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
				ftext( string.format( "%.0f%%", MFA.Medical.LimbFraction(p, limb) * 100 ), "MFA_HUD_5", dd(175 + posx), h - dd(340 - 15 - posy), CLR_W, CLR_B, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
			end


			surface.SetDrawColor( CLR_B )
			surface.DrawOutlinedRect( dd(60) + s1, h - dd(30+16) + s2, dd(250), dd(12), dd(3) )

			local he = p:Health() / p:GetMaxHealth()
			local mul = Lerp( he, 0.4, 0.9 )
			surface.SetDrawColor( CLR_W.r * mul, CLR_W.g * mul, CLR_W.b * mul )
			surface.DrawRect( dd(60), h - dd(30+16), dd(250) * he, dd(12) )

			surface.SetDrawColor( CLR_W )
			surface.DrawOutlinedRect( dd(60), h - dd(30+16), dd(250), dd(12), dd(3) )

			surface.SetDrawColor( CLR_B )
			surface.DrawOutlinedRect( dd(30) + s1, h - dd(125+30) - dd(300) + s2, dd(12), dd(100*4), dd(3) )
			local amt = p:GetNWFloat( "MFA_Stamina", 1 )
			for i=1, 4 do
				local e = i-1

				local te = math.Clamp( math.TimeFraction( 0 + (0.25*e), (0.25*i), amt ), 0, 1 )
				local mul = Lerp( i/4, 0.3, 0.85 )
				surface.SetDrawColor( CLR_W.r * mul, CLR_W.g * mul, CLR_W.b * mul )
				surface.DrawRect( dd(30), h - dd(125+30) - dd(100*e) + dd(100*(1-te)), dd(12), dd(100*te) )

				mul = 1.1
				surface.SetDrawColor( CLR_W.r * mul, CLR_W.g * mul, CLR_W.b * mul )
				surface.DrawOutlinedRect( dd(30), h - dd(125+30) - dd(100*e), dd(12), dd(100), dd(2) )
			end

			ftext( p:Nick(), "MFA_HUD_48", dd(76), h - dd(84), CLR_W, CLR_B, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP )

			local anchorX = ScrW() * GetConVar("cl_limbdamage_ui_widthMult"):GetFloat() + GetConVar("cl_limbdamage_ui_width"):GetInt()
			local anchorY = ScrH() * GetConVar("cl_limbdamage_ui_heightMult"):GetFloat() + GetConVar("cl_limbdamage_ui_height"):GetInt()
			local down = 0
			surface.SetDrawColor(255, 255, 255, a)
			for limb, status in pairs(p.LimbStatus) do
				local injured = GetConVar("cl_limbdamage_ui_textmode"):GetInt() == 1 and ((limb ~= "Chest" and p.LimbHealth[limb] < p.LimbMaxHealth[limb]) or (limb == "Chest" and (p:Health() < p:GetMaxHealth())))

				if status ~= 0 then
					local right = 0
					draw.SimpleText(limb .. ": ", "MFA_HUD_5", anchorX + 300, anchorY + 50 + down, CLR_W, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP)

					local str = {}
					for _, s in pairs(MFA.Medical.StatusList) do
						if MFA.Medical.LimbStatusHas(p, limb, s) then
							table.insert(str, MFA.Medical.StatusName[s])
							right = right + 25
						end
					end
					draw.SimpleText(table.concat(str, ","), "MFA_HUD_5", anchorX + 300, anchorY + 50 + down, CLR_W, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)

					down = down + 30
				end
			end
		end


		local wep = p:GetActiveWeapon()
		if !IsValid(wep) then wep = false end
		if wep then -- weap
			--fbar( w - (c*320), h - (c*82), (c*320), (c*6), CLR_W, CLR_B )
			ftext( wep:GetPrintName(), "MFA_HUD_48", w-dd(28), h - dd(62), CLR_W, CLR_B, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP )

			local ftn
			if wep.GetFiremodeName then
				ftext( string.upper(wep:GetFiremodeName()), "MFA_HUD_20", w-dd(30), h - dd(56), CLR_W, CLR_B, TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM )
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
			ftext( "(" .. string.format("%.3f", amiw) .. "kg) " .. ami, "MFA_HUD_20", w-dd(30), h - dd(121), CLR_W, CLR_B, TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM )

			local wa = w - dd(28)
			for i=1, wep:GetMaxClip1() do
				surface.SetDrawColor( CLR_B )
				surface.DrawRect( wa - i * dd(7) + s1, h - dd(122) + s2, dd(5), dd(30) )
			end
			for i=1, wep:Clip1() do
				surface.SetDrawColor( (i > wep:GetMaxClip1() and Color(255, 0, 0)) or CLR_W )
				surface.DrawRect( wa - i * dd(7), h - dd(122), dd(5), dd(30) )
			end

		end
	end
end)

concommand.Add("mfa_cl_show_inventory", function()
	local dd = MFAS2
	local main = vgui.Create("DFrame", nil)
	main:SetSize( dd(400), dd(300) )
	main:Center()
	main:MakePopup()
	main:ShowCloseButton(false)
	main:SetTitle("")
	function main:Paint(w, h)
		local old = DisableClipping(true)
		local b = dd(5)
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
		close:SetSize( dd(30), dd(30) )
		close:SetPos( main:GetSize() - dd(10) - dd(30), dd(10) )
		function close:Paint(w, h)
			local b = dd(5)
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
]]