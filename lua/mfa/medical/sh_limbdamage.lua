MFA.Medical = MFA.Medical or {}

CreateConVar("limbdamage_enabled", 0, FCVAR_NOTIFY + FCVAR_REPLICATED + FCVAR_ARCHIVE, "Whether to enable limb damage.", 0, 1)
CreateConVar("limbdamage_debug", 0, FCVAR_NOTIFY, "Debug print statements.", 0, 1)
CreateConVar("limbdamage_health_arms", 50, FCVAR_NOTIFY + FCVAR_REPLICATED, "The amount of limb health for arms. Default 50.", 1)
CreateConVar("limbdamage_health_legs", 60, FCVAR_NOTIFY + FCVAR_REPLICATED, "The amount of limb health for legs. Default 60.", 1)
CreateConVar("limbdamage_health_head", 35, FCVAR_NOTIFY + FCVAR_REPLICATED, "The amount of limb health for head. Default 35.", 1)

MFA.Medical.Hitgroup = {
    [0] = "Generic",
    [10] = "Generic",
    [1] = "Head",
    [2] = "Chest",
    [3] = "Stomach",
    [4] = "Left Arm",
    [5] = "Right Arm",
    [6] = "Left Leg",
    [7] = "Right Leg"
}

MFA.Medical.LimbsList = {"Left Arm", "Right Arm", "Left Leg", "Right Leg", "Stomach"}
MFA_MED_STATUS_NONE = 0
MFA_MED_STATUS_BLEED = 1
MFA_MED_STATUS_FRACTURE = 2
MFA_MED_STATUS_PAIN = 4
MFA_MED_STATUS_TREMOR = 8
MFA_MED_STATUS_PAINKILLERS = 16
MFA.Medical.StatusList = {MFA_MED_STATUS_BLEED, MFA_MED_STATUS_FRACTURE, MFA_MED_STATUS_PAIN, MFA_MED_STATUS_TREMOR, MFA_MED_STATUS_PAINKILLERS}

MFA.Medical.StatusName = {
    [0] = "None",
    [1] = "Bleed",
    [2] = "Fracture",
    [4] = "Pain",
    [8] = "Tremor",
    [16] = "Painkillers",
}

function MFA.Medical.LimbHealth(ply, limb)
    if not ply.LimbHealth then return -1 end
    if limb == "Chest" then return ply:Health() end
    return ply.LimbHealth[limb]
end

function MFA.Medical.LimbFraction(ply, limb)
    return MFA.Medical.LimbHealth(ply, limb) / MFA.Medical.GetTrueMaxHealth(ply, limb)
end

function MFA.Medical.IsDestroyed(ply, limb)
    if not ply.LimbHealth[limb] then return nil end

    return ply.LimbHealth[limb] == -1
end

function MFA.Medical.IsDamaged(ply, limb)
    if not ply.LimbHealth[limb] then return nil end

    return ply.LimbHealth[limb] < ply.LimbMaxHealth[limb]
end

function MFA.Medical.GetTrueMaxHealth(ply, limb)
    if limb == "Head" then
        return GetConVar("limbdamage_health_head"):GetInt()
    elseif limb == "Stomach" then
        return 80
    elseif string.find(limb, "Arm") then
        return GetConVar("limbdamage_health_arms"):GetInt()
    elseif string.find(limb, "Leg") then
        return GetConVar("limbdamage_health_legs"):GetInt()
    elseif limb == "Chest" then
        return ply:GetMaxHealth()
    end

    return nil
end

-- Smaller than 'max' max limb health, caused by fixing a broken limb
function MFA.Medical.IsWeakened(ply, limb)
    if not ply.LimbMaxHealth[limb] or not MFA.Medical.GetTrueMaxHealth(ply, limb) then return nil end

    return ply.LimbMaxHealth[limb] < MFA.Medical.GetTrueMaxHealth(ply, limb)
end

function MFA.Medical.GetDamagedLimbs(ply)
    local tbl = {}

    for limb, hp in pairs(ply.LimbHealth) do
        if MFA.Medical.IsDamaged(ply, limb) then
            table.insert(tbl, limb)
        end
    end

    return tbl
end

function MFA.Medical.GetWeakenedLimbs(ply)
    local tbl = {}

    for limb, hp in pairs(ply.LimbHealth) do
        if MFA.Medical.IsWeakened(ply, limb) then
            table.insert(tbl, limb)
        end
    end

    return tbl
end

function MFA.Medical.GetBrokenLimbs(ply)
    local tbl = {}

    for limb, hp in pairs(ply.LimbHealth) do
        if hp < 0 then
            table.insert(tbl, limb)
        end
    end

    return tbl
end

function MFA.Medical.CanTakeDamage(ply, limb, dmg)
    if not ply.LimbHealth[limb] then return nil end

    return ply.LimbHealth[limb] > dmg
end

function MFA.Medical.LimbStatusHas(ply, limb, status)
    return bit.band(ply.LimbStatus[limb], status) == status
end

hook.Add("StartCommand", "LimbDamage", function(ply, cmd)
    if not ply.LimbHealth or not GetConVar("limbdamage_enabled"):GetBool() then return end
    local basespeed = ply:GetWalkSpeed()
    local leftCripple = MFA.Medical.IsDestroyed(ply, "Left Leg") or MFA.Medical.LimbStatusHas(ply, "Left Leg", MFA_MED_STATUS_FRACTURE)
    local rightCripple = MFA.Medical.IsDestroyed(ply, "Right Leg") or MFA.Medical.LimbStatusHas(ply, "Right Leg", MFA_MED_STATUS_FRACTURE)
    local usingItem = IsValid(ply:GetActiveWeapon()) and ply:GetActiveWeapon().IsLDMedItem and ply:GetActiveWeapon().Progress > 0

    if ply:KeyDown(IN_SPEED) then
        if leftCripple or rightCripple or usingItem then
            cmd:RemoveKey(IN_SPEED)
        else
            basespeed = ply:GetRunSpeed()
        end
    end

    if usingItem and ply:GetActiveWeapon().ImmobileWhenUsed then
        basespeed = 0
    end

    local movevec = Vector(cmd:GetForwardMove(), cmd:GetSideMove(), cmd:GetUpMove())
    movevec = movevec:GetNormalized()
    local frac = 1

    if leftCripple then
        frac = frac - 0.4
    end

    if rightCripple then
        frac = frac - 0.4
    end

    if usingItem then
        frac = math.min(0.5, frac)
    end

    movevec = movevec * frac * basespeed
    cmd:SetForwardMove(movevec.x)
    cmd:SetSideMove(movevec.y)
    cmd:SetUpMove(movevec.z)
end)