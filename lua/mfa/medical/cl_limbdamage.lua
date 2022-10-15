AddCSLuaFile()
local lastUpdate = 0

if CLIENT then
    surface.CreateFont("LD_Med_UI_42", {
        font = "Arial",
        size = 42,
        antialias = true
    })

    surface.CreateFont("LD_Med_UI_24", {
        font = "Arial",
        size = 24,
        antialias = true
    })

    surface.CreateFont("LD_HUD_18", {
        font = "Arial",
        size = 18,
        antialias = true
    })
end

CreateConVar("cl_limbdamage_ui_widthMult", 0, FCVAR_ARCHIVE, "X position of UI in terms of screen width. Default 0.", 0, 1)
CreateConVar("cl_limbdamage_ui_heightMult", 1, FCVAR_ARCHIVE, "Y position of UI in terms of screen height. Default 0.", 0, 1)
CreateConVar("cl_limbdamage_ui_width", 0, FCVAR_ARCHIVE, "X position of UI in terms of pixels. Default 0.")
CreateConVar("cl_limbdamage_ui_height", -450, FCVAR_ARCHIVE, "Y position of UI in terms of pixels. Default -450.")
CreateConVar("cl_limbdamage_ui_fadetime", 3, FCVAR_ARCHIVE, "Amount of time the UI will stay up before disappearing. 0 means always on.", 0)
CreateConVar("cl_limbdamage_ui_textmode", 2, FCVAR_ARCHIVE, "Method of showing limb health in text. 0 - disabled; 1 - on the right; 2 - on the image")
CreateConVar("cl_limbdamage_key_status", KEY_C, FCVAR_ARCHIVE, "The key to hold for showing health. Use KEY_ enums. Default: 13 (C) ")
CreateConVar("cl_limbdamage_hint", 1, FCVAR_ARCHIVE, "Whether hints should show.", 0, 1)

net.Receive("LimbDamage_Message", function()
    chat.AddText(Color(255, 255, 255), "[", Color(255, 155, 155), "LimbDamage", Color(255, 255, 255), "] ", net.ReadString())
end)

net.Receive("LimbDamage_Sync", function()
    local ply = net.ReadEntity()
    ply.LimbHealth = net.ReadTable()
    ply.LimbMaxHealth = net.ReadTable()
    ply.LimbStatus = net.ReadTable()
    ply.LimbPain = net.ReadInt(16)

    if ply == LocalPlayer() then
        lastUpdate = CurTime()
    end
end)

local matBody = Material("limbdamage/body.png")
local matHead = Material("limbdamage/head.png")
local matChest = Material("limbdamage/chest.png")
local matStomach = Material("limbdamage/stomach.png")
local matArmL = Material("limbdamage/leftarm.png")
local matArmR = Material("limbdamage/rightarm.png")
local matLegL = Material("limbdamage/leftleg.png")
local matLegR = Material("limbdamage/rightleg.png")
local iconBleed = Material("limbdamage/icon/bloodloss.png")
local iconFracture = Material("limbdamage/icon/fracture.png")
local iconPain = Material("limbdamage/icon/pain.png")
local iconPainkillers = Material("limbdamage/icon/painkiller.png")
local iconTremor = Material("limbdamage/icon/tremor.png")

local iconTable = {
    [MFA_MED_STATUS_BLEED] = iconBleed,
    [MFA_MED_STATUS_FRACTURE] = iconFracture,
    [MFA_MED_STATUS_PAIN] = iconPain,
    [MFA_MED_STATUS_TREMOR] = iconTremor,
    [MFA_MED_STATUS_PAINKILLERS] = iconPainkillers
}

hook.Add("Think", "LimbDamage_CL", function()
    if not LocalPlayer().LimbHealth then return end -- not initialized?
    if not GetConVar("limbdamage_enabled"):GetBool() then return end
    local ply = LocalPlayer()
    local isACT3 = IsValid(ply:GetActiveWeapon()) and ply:GetActiveWeapon().ACT3Weapon
    local angle = isACT3 and ply:GetActiveWeapon():GetCamAngles() or ply:EyeAngles()
    -- Screen shake from walking while crippled
    local leftCripple = MFA.Medical.IsDestroyed(ply, "Left Leg") or MFA.Medical.LimbStatusHas(ply, "Left Leg", MFA_MED_STATUS_FRACTURE)
    local rightCripple = MFA.Medical.IsDestroyed(ply, "Right Leg") or MFA.Medical.LimbStatusHas(ply, "Right Leg", MFA_MED_STATUS_FRACTURE)
    local leftArmCripple = MFA.Medical.IsDestroyed(ply, "Left Arm") or MFA.Medical.LimbStatusHas(ply, "Left Arm", MFA_MED_STATUS_FRACTURE)
    local rightArmCripple = MFA.Medical.IsDestroyed(ply, "Right Arm") or MFA.Medical.LimbStatusHas(ply, "Right Arm", MFA_MED_STATUS_FRACTURE)

    if leftCripple or rightCripple then
        local walkshake = 0.25

        if leftCripple and rightCripple then
            walkshake = 0.4
        end

        walkshake = walkshake * math.Clamp((ply:GetVelocity() * Vector(1, 1, 0)):Length() / ply:GetWalkSpeed(), 0.1, 1)
        angle = angle + Angle(math.sin(CurTime() * 2.5) * walkshake, math.cos(CurTime() * 2.5) * walkshake / 3, 0)
    end

    -- Screen sway from pain
    local shake = math.Clamp(ply.LimbPain / 2000, 0, 1)

    if leftArmCripple then
        shake = shake + 0.15
    end

    if rightArmCripple then
        shake = shake + 0.15
    end

    shake = shake * (math.random() * 0.1 + 0.1)

    if shake > 0 then
        angle = angle + Angle(math.cos(CurTime()) * shake, math.sin(CurTime()) * shake, 0)
    end

    -- Screen shake from tremor
    if MFA.Medical.LimbStatusHas(ply, "Chest", MFA_MED_STATUS_TREMOR) then
        local fun = math.Clamp(ply.LimbPain / 900, 0, 1) * 0.2
        local mult = 0.3 + fun
        angle = angle + Angle(math.random() * mult - mult / 2, math.random() * mult - mult / 2, 0)
    end

    if isACT3 then
        ply:GetActiveWeapon():SetCamAngles(angle)
    else
        ply:SetEyeAngles(angle)
    end
end)

local function drawDamage(limb, x, y, a)
    if GetConVar("cl_limbdamage_ui_textmode"):GetInt() == 2 and LocalPlayer().LimbHealth[limb] < LocalPlayer().LimbMaxHealth[limb] then
        local str = (math.Round(LocalPlayer().LimbHealth[limb]) .. "/" .. LocalPlayer().LimbMaxHealth[limb])
        if LocalPlayer().LimbHealth[limb] < 0 then
            str = "Broken"
        end
        draw.SimpleTextOutlined(str, "LD_HUD_18", x, y, Color(255, 255, 255, a), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, Color(50, 50, 50, a))
    end
end
--[[]
hook.Add("HUDPaint", "LimbDamage", function()
    if not GetConVar("limbdamage_enabled"):GetBool() then return end
    local ply = LocalPlayer()
    if not ply.LimbHealth or not ply:Alive() then return end -- not initialized?
    local anchorX = ScrW() * GetConVar("cl_limbdamage_ui_widthMult"):GetFloat() + GetConVar("cl_limbdamage_ui_width"):GetInt()
    local anchorY = ScrH() * GetConVar("cl_limbdamage_ui_heightMult"):GetFloat() + GetConVar("cl_limbdamage_ui_height"):GetInt()
    lastUpdate = lastUpdate or CurTime()

    if IsValid(ply:GetActiveWeapon()) and ply:GetActiveWeapon().IsLDMedItem == true or input.IsKeyDown(GetConVar("cl_limbdamage_key_status"):GetInt()) then
        lastUpdate = CurTime()
    end

    local a = 255
    local diffT = CurTime() - lastUpdate

    if GetConVar("cl_limbdamage_ui_fadetime"):GetFloat() > 0 and diffT >= GetConVar("cl_limbdamage_ui_fadetime"):GetFloat() then
        a = 255 - math.min(255, (diffT - GetConVar("cl_limbdamage_ui_fadetime"):GetFloat()) * 255)
    end

    --if a <= 0 then return end
    -- Hand tweaked values by yours truly
    -- Body
    surface.SetDrawColor(255, 255, 255, a)
    surface.SetMaterial(matBody)
    surface.DrawTexturedRect(anchorX, anchorY, 256, 384)

    -- Head
    if ply.LimbHealth["Head"] == -1 then
        surface.SetDrawColor(50, 50, 50, a)
    else
        local col = ply.LimbHealth["Head"] / ply.LimbMaxHealth["Head"] * 255
        surface.SetDrawColor(255, col, col, a)
    end

    surface.SetMaterial(matHead)
    surface.DrawTexturedRect(anchorX + 150, anchorY + 42, 37.5, 43)

    drawDamage("Head", anchorX + 120, anchorY + 65, a)

    -- Chest
    if ply:Health() <= 0 then
        surface.SetDrawColor(50, 50, 50, a)
    else
        local col = ply:Health() / ply:GetMaxHealth() * 255
        surface.SetDrawColor(255, col, col, a)
    end

    surface.SetMaterial(matChest)
    surface.DrawTexturedRect(anchorX + 128, anchorY + 70, 75.5, 81.5)
    -- Stomach
    surface.SetMaterial(matStomach)
    surface.DrawTexturedRect(anchorX + 120, anchorY + 130, 70, 67.5)

    -- Right Arm
    if ply.LimbHealth["Right Arm"] == -1 then
        surface.SetDrawColor(50, 50, 50, a)
    elseif ply.LimbHealth["Right Arm"] >= ply.LimbMaxHealth["Right Arm"] and ply.LimbMaxHealth["Right Arm"] < MFA.Medical.GetTrueMaxHealth(ply, "Right Arm") then
        local col = ply.LimbMaxHealth["Right Arm"] / MFA.Medical.GetTrueMaxHealth(ply, "Right Arm") * 255
        surface.SetDrawColor(col, col, 255, a)
    else
        local col = ply.LimbHealth["Right Arm"] / ply.LimbMaxHealth["Right Arm"] * 255
        surface.SetDrawColor(255, col, col, a)
    end

    surface.SetMaterial(matArmR)
    surface.DrawTexturedRect(anchorX + 90, anchorY + 90, 58.5, 98)

    drawDamage("Right Arm", anchorX + 110, anchorY + 150, a)

    -- Left Arm
    if ply.LimbHealth["Left Arm"] == -1 then
        surface.SetDrawColor(50, 50, 50, a)
    elseif ply.LimbHealth["Left Arm"] >= ply.LimbMaxHealth["Left Arm"] and ply.LimbMaxHealth["Left Arm"] < MFA.Medical.GetTrueMaxHealth(ply, "Left Arm") then
        local col = ply.LimbMaxHealth["Left Arm"] / MFA.Medical.GetTrueMaxHealth(ply, "Left Arm") * 255
        surface.SetDrawColor(col, col, 255, a)
    else
        local col = ply.LimbHealth["Left Arm"] / ply.LimbMaxHealth["Left Arm"] * 255
        surface.SetDrawColor(255, col, col, a)
    end

    surface.SetMaterial(matArmL)
    surface.DrawTexturedRect(anchorX + 187, anchorY + 87, 42.5, 133.5)

    drawDamage("Left Arm", anchorX + 220, anchorY + 165, a)

    -- Right Leg
    if ply.LimbHealth["Right Leg"] == -1 then
        surface.SetDrawColor(50, 50, 50, a)
    elseif ply.LimbHealth["Right Leg"] >= ply.LimbMaxHealth["Right Leg"] and ply.LimbMaxHealth["Right Leg"] < MFA.Medical.GetTrueMaxHealth(ply, "Right Leg") then
        local col = ply.LimbMaxHealth["Right Leg"] / MFA.Medical.GetTrueMaxHealth(ply, "Right Leg") * 255
        surface.SetDrawColor(col, col, 255, a)
    else
        local col = ply.LimbHealth["Right Leg"] / ply.LimbMaxHealth["Right Leg"] * 255
        surface.SetDrawColor(255, col, col, a)
    end

    surface.SetMaterial(matLegR)
    surface.DrawTexturedRect(anchorX + 110, anchorY + 165, 63.5, 174)

    drawDamage("Right Leg", anchorX + 135, anchorY + 240, a)

    -- Left Leg
    if ply.LimbHealth["Left Leg"] == -1 then
        surface.SetDrawColor(50, 50, 50, a)
    elseif ply.LimbHealth["Left Leg"] >= ply.LimbMaxHealth["Left Leg"] and ply.LimbMaxHealth["Left Leg"] < MFA.Medical.GetTrueMaxHealth(ply, "Left Leg") then
        local col = ply.LimbMaxHealth["Left Leg"] / MFA.Medical.GetTrueMaxHealth(ply, "Left Leg") * 105 + 150
        surface.SetDrawColor(col, col, 255, a)
    else
        local col = ply.LimbHealth["Left Leg"] / ply.LimbMaxHealth["Left Leg"] * 255
        surface.SetDrawColor(255, col, col, a)
    end

    surface.SetMaterial(matLegL)
    surface.DrawTexturedRect(anchorX + 145, anchorY + 165, 64, 179)

    drawDamage("Left Leg", anchorX + 190, anchorY + 240, a)

    -- Status effects
    local down = 0
    surface.SetDrawColor(255, 255, 255, a)

    for limb, status in pairs(ply.LimbStatus) do
        local injured = GetConVar("cl_limbdamage_ui_textmode"):GetInt() == 1 and ((limb ~= "Chest" and ply.LimbHealth[limb] < ply.LimbMaxHealth[limb]) or (limb == "Chest" and (ply:Health() < ply:GetMaxHealth())))

        if status ~= 0 or injured then
            local right = 0
            draw.SimpleTextOutlined(limb .. ": ", "LD_HUD_18", anchorX + 300, anchorY + 50 + down, Color(255, 255, 255, a), TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP, 2, Color(50, 50, 50, a))

            if injured then
                local str = limb == "Chest" and (ply:Health() .. "/" .. ply:GetMaxHealth()) or (math.Round(ply.LimbHealth[limb]) .. "/" .. ply.LimbMaxHealth[limb])

                if (limb == "Chest" and ply:Health() <= 0) or (limb ~= "Chest" and ply.LimbHealth[limb] < 0) then
                    str = "Broken"
                end

                draw.SimpleTextOutlined(str, "LD_HUD_18", anchorX + 300, anchorY + 50 + down, Color(255, 255, 255, a), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 2, Color(50, 50, 50, a))
                right = right + 55
            end

            for _, s in pairs(MFA.Medical.StatusList) do
                if MFA.Medical.LimbStatusHas(ply, limb, s) then
                    surface.SetMaterial(iconTable[s])
                    surface.DrawTexturedRect(anchorX + 300 + right, anchorY + 50 + down, 24, 22)
                    right = right + 25
                end
            end

            down = down + 30
        end
    end
end)
]]
print("cl_limbdamage.lua loaded.")