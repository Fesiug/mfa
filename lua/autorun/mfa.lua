
AddCSLuaFile()

game.AddParticles( "particles/muzzleflashes_test.pcf" )
game.AddParticles( "particles/muzzleflashes_test_b.pcf" )
PrecacheParticleSystem( "muzzleflash_smg" )
PrecacheParticleSystem( "muzzleflash_smg_bizon" )
PrecacheParticleSystem( "muzzleflash_shotgun" )
PrecacheParticleSystem( "muzzleflash_slug" )
PrecacheParticleSystem( "muzzleflash_slug_flame" )
PrecacheParticleSystem( "muzzleflash_pistol" )
PrecacheParticleSystem( "muzzleflash_pistol_cleric" )
PrecacheParticleSystem( "muzzleflash_pistol_deagle" )
PrecacheParticleSystem( "muzzleflash_suppressed" )
PrecacheParticleSystem( "muzzleflash_mp5" )
PrecacheParticleSystem( "muzzleflash_MINIMI" )
PrecacheParticleSystem( "muzzleflash_m79" )
PrecacheParticleSystem( "muzzleflash_m14" )
PrecacheParticleSystem( "muzzleflash_ak47" )
PrecacheParticleSystem( "muzzleflash_ak74" )
PrecacheParticleSystem( "muzzleflash_m82" )
PrecacheParticleSystem( "muzzleflash_m3" )
PrecacheParticleSystem( "muzzleflash_famas" )
PrecacheParticleSystem( "muzzleflash_g3" )
PrecacheParticleSystem( "muzzleflash_1" )
PrecacheParticleSystem( "muzzleflash_3" )
PrecacheParticleSystem( "muzzleflash_4" )
PrecacheParticleSystem( "muzzleflash_5" )
PrecacheParticleSystem( "muzzleflash_6" )


if SERVER then
	util.AddNetworkString("MFA_Wep_Custmenu")
	net.Receive("MFA_Wep_Custmenu", function( len, ply )
		local w = ply
		if IsValid(w) and IsValid(w:GetActiveWeapon()) and w:GetActiveWeapon().MFA then
			w = w:GetActiveWeapon()
			w:SetCustomizing( net.ReadBool() )
		end
	end)
else
	hook.Add("OnContextMenuOpen", "MFA_OnContextMenuOpen", function()
		local w = LocalPlayer()
		if IsValid(w) and !w:KeyDown(IN_USE) and IsValid(w:GetActiveWeapon()) and w:GetActiveWeapon().MFA then
			w = w:GetActiveWeapon()
			if !w:GetCustomizing() then
				print("openign cmenu!")
				w:SetCustomizing( true )
				net.Start("MFA_Wep_Custmenu")
					net.WriteBool( true )
				net.SendToServer()
			else
				print("closing cmenu!")
				w:SetCustomizing( false )
				net.Start("MFA_Wep_Custmenu")
					net.WriteBool( false )
				net.SendToServer()
			end
		end
	end)
	hook.Add("ContextMenuOpen", "MFA_ContextMenuOpen", function()
		local w = LocalPlayer()
		if IsValid(w) and !w:KeyDown(IN_USE) and IsValid(w:GetActiveWeapon()) and w:GetActiveWeapon().MFA then
			return false
		end
	end)
end


if CLIENT then
	local clr_b = Color(160, 190, 255)
	local clr_r = Color(255, 190, 190)

	concommand.Add("mfa_dev_listvmanims", function()
		local wep = LocalPlayer():GetActiveWeapon()

		if !wep then return end

		local vm = LocalPlayer():GetViewModel()

		if !vm then return end

		local alist = vm:GetSequenceList()

		for i = 0, #alist do
			MsgC(clr_b, i, " --- ")
			MsgC(color_white, "\t", alist[i], "\n     [")
			MsgC(clr_r, "\t", vm:SequenceDuration(i), "\n")
		end
	end)

	concommand.Add("mfa_dev_listvmbones", function()
		local wep = LocalPlayer():GetActiveWeapon()

		if !wep then return end

		local vm = LocalPlayer():GetViewModel()

		if !vm then return end

		for i = 0, (vm:GetBoneCount() - 1) do
			print(i .. " - " .. vm:GetBoneName(i))
		end
	end)

	concommand.Add("mfa_dev_listvmatts", function()
		local wep = LocalPlayer():GetActiveWeapon()

		if !wep then return end

		local vm = LocalPlayer():GetViewModel()

		if !vm then return end

		local alist = vm:GetAttachments()

		for i = 1, #alist do
			MsgC(clr_b, i, " --- ")
			MsgC(color_white, "\tindex : ", alist[i].id, "\n     [")
			MsgC(clr_r, "\tname: ", alist[i].name, "\n")
		end
	end)

	concommand.Add("mfa_dev_listvmbgs", function()
		local wep = LocalPlayer():GetActiveWeapon()

		if !wep then return end

		local vm = LocalPlayer():GetViewModel()

		if !vm then return end

		local alist = vm:GetBodyGroups()

		for i = 1, #alist do
			local alistsm = alist[i].submodels
			local active = vm:GetBodygroup(alist[i].id)
			MsgC(clr_b, i, " --- ")
			MsgC(color_white, "\tid: ", alist[i].id, "\n     [")
			MsgC(clr_r, "\tname: ", alist[i].name, "\n")
			MsgC(clr_r, "\tnum: ", alist[i].num, "\n")
			if alistsm then
				MsgC(clr_r, "\tsubmodels:\n")
				for j = 0, #alistsm do
					MsgC(active == j and color_white or clr_b, "\t" .. j, " --- ")
					MsgC(active == j and color_white or clr_r, alistsm[j], "\n")
				end
			end
		end
	end)
end