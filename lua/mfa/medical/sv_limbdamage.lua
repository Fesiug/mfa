util.AddNetworkString("LimbDamage_Message")
util.AddNetworkString("LimbDamage_Sync")
CreateConVar("sv_limbdamage_notify_limbbroke", 0, FCVAR_NOTIFY, "Notify the player in a chat message when their limbs break?", 0, 0)
CreateConVar("sv_limbdamage_notify_limbbrokesound", 1, FCVAR_NOTIFY, "Play a sound when someone's limbs break?", 0, 1)
CreateConVar("sv_limbdamage_notify_limbstatus", 0, FCVAR_NOTIFY, "Notify the player in a chat message when their limbs is bleeding or is fractured?", 0, 1)
CreateConVar("sv_limbdamage_viewpunch", 0.5, FCVAR_NOTIFY, "Multiplier for view punch strength. 0 to disable.", 0, 2)
CreateConVar("sv_limbdamage_amp_base", 1, FCVAR_NONE, "The base multiplier for all incoming torso damage when there are no hurt limbs. Default 1.", 0)
CreateConVar("sv_limbdamage_amp_add", 0.25, FCVAR_NONE, "The additional multiplier per lost limb for incoming torso damage, additive. Default 0.25.", 0)
CreateConVar("sv_limbdamage_amp_generic", 0.334, FCVAR_NONE, "The percentage of health dealt directly to the torso when it is generic (blast, melee, etc); The rest is spread across limbs first. Default 0.334.", 0, 1)
CreateConVar("sv_limbdamage_amp_fall", 3, FCVAR_NONE, "The multiplier for fall damage dealt TO THE LEGS ONLY. Default 3.", 0)
CreateConVar("sv_limbdamage_status_bleed", 1, FCVAR_NOTIFY + FCVAR_REPLICATED, "The multiplier for a chance of bleeding relative to damage taken. Default 1.")
CreateConVar("sv_limbdamage_status_cripple", 0.5, FCVAR_NOTIFY + FCVAR_REPLICATED, "The multiplier for a chance of being crippled relative to damage taken. Default 0.5.")
CreateConVar("sv_limbdamage_status_bleed_pain", 0.03, FCVAR_NOTIFY + FCVAR_REPLICATED, "The chance for a bleeding limb to become painful every 3 seconds. Default 0.03.")
CreateConVar("sv_limbdamage_status_cripple_pain", 0.03, FCVAR_NOTIFY + FCVAR_REPLICATED, "The chance for a bleeding limb to become painful every 3 seconds. Default 0.03.")

function MFA.Medical.Debug(msg)
    if GetConVar("limbdamage_debug"):GetBool() then
        net.Start("LimbDamage_Message")
        net.WriteString(msg)
        net.Broadcast()
    end
end

function MFA.Medical.Message(ply, msg)
    net.Start("LimbDamage_Message")
    net.WriteString(msg)
    net.Send(ply)
end

-- TODO reduce netmessages a bit?
function MFA.Medical.Sync(ply)
    timer.Simple(0, function()
        net.Start("LimbDamage_Sync")
        net.WriteEntity(ply)
        net.WriteTable(ply.LimbHealth)
        net.WriteTable(ply.LimbMaxHealth)
        net.WriteTable(ply.LimbStatus)
        net.WriteInt(ply.LimbPain, 16)
        net.Broadcast()
    end)
end

function MFA.Medical.DamageLimb(ply, limb, dmg)
    if dmg < ply.LimbHealth[limb] then
        ply.LimbHealth[limb] = ply.LimbHealth[limb] - dmg
        MFA.Medical.Debug(ply:GetName() .. "'s " .. limb .. " survived " .. dmg .. " damage (" .. ply.LimbHealth[limb] .. "hp left)")

        return 0
    elseif MFA.Medical.IsDestroyed(ply, limb) then
        return dmg
    else
        dmg = dmg - ply.LimbHealth[limb]
        ply.LimbHealth[limb] = -1
        MFA.Medical.Debug(ply:GetName() .. "'s " .. limb .. " is destroyed! (" .. dmg .. " overflow)")

        if GetConVar("sv_limbdamage_notify_limbbroke"):GetBool() and limb ~= "Head" then
            MFA.Medical.Message(ply, "Your " .. limb .. " broke!")
        end

        if GetConVar("sv_limbdamage_notify_limbbrokesound"):GetBool() then
            if limb == "Head" then
                ply:EmitSound("player/headshot" .. math.random(1, 2) .. ".wav", math.random(90, 110), 90)
            else
                ply:EmitSound("player/damage" .. math.random(1, 3) .. ".wav", math.random(90, 110), 90)
            end
        end

        return dmg
    end
end

function MFA.Medical.HealLimb(ply, limb, heal, force)
    if ply.LimbHealth[limb] < 0 and not force then return end
    local max = 100

    if limb == "Head" then
        max = GetConVar("limbdamage_health_head"):GetInt()
    elseif limb == "Left Arm" or limb == "Right Arm" then
        max = GetConVar("limbdamage_health_arms"):GetInt()
    elseif limb == "Left Leg" or limb == "Right Leg" then
        max = GetConVar("limbdamage_health_legs"):GetInt()
    end

    ply.LimbHealth[limb] = math.min(ply.LimbHealth[limb] + heal, max)
end

function MFA.Medical.DamageLimbs(ply, limbs, dmg)
    local avgdmg = math.Round(dmg / table.Count(limbs))
    local bleedover = (dmg - avgdmg * table.Count(limbs)) + avgdmg
    MFA.Medical.Debug("Damaging multiple limbs, dmg is " .. dmg .. ", avgdmg is " .. avgdmg)

    for _, limb in pairs(limbs) do
        MFA.Medical.Debug(limb .. " about to take " .. bleedover .. " damage")
        bleedover = MFA.Medical.DamageLimb(ply, limb, bleedover) + avgdmg
    end

    bleedover = bleedover - avgdmg
    MFA.Medical.Debug("final bleedover is " .. bleedover)

    return bleedover
end

function MFA.Medical.GetAmplifier(ply)
    local amp = GetConVar("sv_limbdamage_amp_base"):GetFloat() or 0.75

    for k, v in pairs(ply.LimbHealth) do
        if v == -1 then
            amp = amp + GetConVar("sv_limbdamage_amp_add"):GetFloat() or 0.25
        end
    end
    --MFA.Medical.Debug(ply:GetName() .. " has damage amp of " .. amp)

    return amp
end

function MFA.Medical.LimbStatusAdd(ply, limb, status)
    --[[
	if bit.band(ply.LimbStatus[limb], status) == 0 then
		ply.LimbStatus[limb] = ply.LimbStatus[limb] + status
	end
	]]
    ply.LimbStatus[limb] = bit.bor(ply.LimbStatus[limb], status)
end

function MFA.Medical.LimbStatusRemove(ply, limb, status)
    --[[
	if bit.band(ply.LimbStatus[limb], status) == status then
		ply.LimbStatus[limb] = ply.LimbStatus[limb] - status
	end
	]]
    ply.LimbStatus[limb] = bit.band(ply.LimbStatus[limb], bit.bnot(status))
end

local function init_player(ply)
    local headHealth, armHealth, legHealth = GetConVar("limbdamage_health_head"):GetInt(), GetConVar("limbdamage_health_arms"):GetInt(), GetConVar("limbdamage_health_legs"):GetInt()

    ply.LimbHealth = {
        ["Head"] = headHealth,
        ["Stomach"] = 80,
        ["Left Arm"] = armHealth,
        ["Right Arm"] = armHealth,
        ["Left Leg"] = legHealth,
        ["Right Leg"] = legHealth
    }

    ply.LimbMaxHealth = table.Copy(ply.LimbHealth)

    ply.LimbStatus = {
        ["Head"] = MFA_MED_STATUS_NONE,
        ["Stomach"] = MFA_MED_STATUS_NONE,
        ["Chest"] = MFA_MED_STATUS_NONE,
        ["Left Arm"] = MFA_MED_STATUS_NONE,
        ["Right Arm"] = MFA_MED_STATUS_NONE,
        ["Left Leg"] = MFA_MED_STATUS_NONE,
        ["Right Leg"] = MFA_MED_STATUS_NONE
    }

    ply.LimbPain = 0
    ply.LimbPainkillersEndTime = 0
    MFA.Medical.Sync(ply)
end

hook.Add("PlayerInitialSpawn", "LimbDamage", function(ply)
    init_player(ply) -- Required for Listen servers, for some reason
end)

hook.Add("PlayerSpawn", "LimbDamage", function(ply)
    init_player(ply)
end)

hook.Add("ScalePlayerDamage", "LimbDamage", function(ply, hitgroup, dmginfo)
    if not GetConVar("limbdamage_enabled"):GetBool() then return end
    if dmginfo:GetDamageType() == DMG_DIRECT then return end -- Direct damage is used by bleeding, also maybe supports other addons
    hitgroup = MFA.Medical.Hitgroup[hitgroup]
    MFA.Medical.Debug("Player " .. ply:GetName() .. " taking " .. math.Round(dmginfo:GetDamage(), 2) .. " dmg at hitgroup " .. hitgroup .. " (" .. (ply.LimbHealth[hitgroup] or "nil") .. ")")
    local punch = dmginfo:GetDamage() * GetConVar("sv_limbdamage_viewpunch"):GetFloat()

    if punch > 0 then
        local angle = Angle(0, 0, 0)

        if hitgroup == "Head" then
            angle = Angle(-1 * (math.random() + 0.5) * punch, (math.random() - 0.5) * punch, (math.random() - 0.5) * punch)
        elseif hitgroup == "Left Arm" or hitgroup == "Right Arm" then
            angle = Angle(-1 * (math.random() * 0.5 + 0.5) * punch, (math.random() - 0.5) * punch, math.random(-5, 5))
        elseif hitgroup == "Left Leg" or hitgroup == "Right Leg" then
            angle = Angle(math.random() * 0.5 * punch, (math.random() - 0.5) * punch, math.random(-5, 5))
        elseif hitgroup == "Chest" then
            angle = Angle(math.random() * punch, (math.random() - 0.5) * punch, math.random(-5, 5))
        end

        ply:ViewPunch(angle)
        ply:SetEyeAngles(ply:EyeAngles() + Angle(angle.p / 2, angle.y / 2, 0))
    end

    if hitgroup == "Generic" then
        local dmg1 = math.Round(dmginfo:GetDamage() * GetConVar("sv_limbdamage_amp_generic"):GetFloat())
        local dmg2 = dmginfo:GetDamage() - dmg1
        dmginfo:SetDamage(dmg1 + MFA.Medical.DamageLimbs(ply, MFA.Medical.LimbsList, dmg2))
    elseif hitgroup ~= "Chest" then
        local bleedChance = dmginfo:GetDamage() / ply.LimbMaxHealth[hitgroup] * GetConVar("sv_limbdamage_status_bleed"):GetFloat()
        local crippleChance = dmginfo:GetDamage() / ply.LimbMaxHealth[hitgroup] * GetConVar("sv_limbdamage_status_cripple"):GetFloat()

        if not MFA.Medical.LimbStatusHas(ply, hitgroup, MFA_MED_STATUS_BLEED) and bleedChance > math.random() then
            MFA.Medical.LimbStatusAdd(ply, hitgroup, MFA_MED_STATUS_BLEED)

            if GetConVar("sv_limbdamage_notify_limbstatus"):GetBool() then
                MFA.Medical.Message(ply, "Your " .. string.lower(hitgroup) .. " is bleeding!")
            end
        end

        if hitgroup ~= "Head" and not MFA.Medical.LimbStatusHas(ply, hitgroup, MFA_MED_STATUS_FRACTURE) and crippleChance > math.random() then
            MFA.Medical.LimbStatusAdd(ply, hitgroup, MFA_MED_STATUS_FRACTURE)

            if GetConVar("sv_limbdamage_notify_limbstatus"):GetBool() then
                MFA.Medical.Message(ply, "Your " .. string.lower(hitgroup) .. " is fractured!")
            end
        end

        dmginfo:SetDamage(MFA.Medical.DamageLimb(ply, hitgroup, math.Round(dmginfo:GetDamage())))
    end

    ply.LastAttacker = dmginfo:GetAttacker()
    ply.LastInflictor = dmginfo:GetInflictor()

    if MFA.Medical.IsDestroyed(ply, "Head") then
        ply:SetHealth(0) -- Bout to be murdered, boy
    end

    dmginfo:SetDamage(math.Round(dmginfo:GetDamage() * MFA.Medical.GetAmplifier(ply)))
    local bleedChance = dmginfo:GetDamage() / ply:GetMaxHealth() * GetConVar("sv_limbdamage_status_bleed"):GetFloat()

    if hitgroup == "Chest" and not MFA.Medical.LimbStatusHas(ply, "Chest", MFA_MED_STATUS_BLEED) and bleedChance > math.random() then
        MFA.Medical.LimbStatusAdd(ply, "Chest", MFA_MED_STATUS_BLEED)

        if GetConVar("sv_limbdamage_notify_limbstatus"):GetBool() then
            MFA.Medical.Message(ply, "Your chest is bleeding!")
        end
    end

    MFA.Medical.Sync(ply)

    return false
end)

hook.Add("EntityTakeDamage", "LimbDamage", function(ply, dmginfo)
    if not GetConVar("limbdamage_enabled"):GetBool() then return end
    if not ply:IsPlayer() then return end

    if dmginfo:IsFallDamage() then
        dmginfo:SetDamage(math.ceil(dmginfo:GetDamage() * GetConVar("sv_limbdamage_amp_fall"):GetFloat())) -- integers pls
        dmginfo:SetDamage(math.Round(MFA.Medical.DamageLimbs(ply, {"Left Leg", "Right Leg"}, dmginfo:GetDamage()) / GetConVar("sv_limbdamage_amp_fall"):GetFloat()))
        local crippleChance = dmginfo:GetDamage() / ply.LimbMaxHealth["Left Leg"] * 2 * GetConVar("sv_limbdamage_status_cripple"):GetFloat()

        if not MFA.Medical.LimbStatusHas(ply, "Left Leg", MFA_MED_STATUS_FRACTURE) and crippleChance > math.random() then
            MFA.Medical.LimbStatusAdd(ply, "Left Leg", MFA_MED_STATUS_FRACTURE)

            if GetConVar("sv_limbdamage_notify_limbstatus"):GetBool() then
                MFA.Medical.Message(ply, "You broke your left leg from the fall!")
            end
        end

        crippleChance = dmginfo:GetDamage() / ply.LimbMaxHealth["Right Leg"] * 2 * GetConVar("sv_limbdamage_status_cripple"):GetFloat()

        if not MFA.Medical.LimbStatusHas(ply, "Right Leg", MFA_MED_STATUS_FRACTURE) and crippleChance > math.random() then
            MFA.Medical.LimbStatusAdd(ply, "Right Leg", MFA_MED_STATUS_FRACTURE)

            if GetConVar("sv_limbdamage_notify_limbstatus"):GetBool() then
                MFA.Medical.Message(ply, "You broke your right leg from the fall!")
            end
        end

        MFA.Medical.Sync(ply)
    end
end)

local nextThink = 0

hook.Add("Think", "LimbDamage", function()
    if nextThink > CurTime() then return end
    nextThink = CurTime() + 3

    for _, ply in pairs(player.GetAll()) do
        -- Listen server hosts don't get PlayerSpawn called on first load, this is a workaround
        if not ply.LimbHealth then
            init_player(ply)
        end

        local shouldSync = false

        for limb, status in pairs(ply.LimbStatus) do
            if MFA.Medical.LimbStatusHas(ply, limb, MFA_MED_STATUS_BLEED) then
                -- Chest doesn't have corresponding limb health
                if limb ~= "Chest" and ply.LimbHealth[limb] > 0 then
                    ply.LimbHealth[limb] = math.max(0, ply.LimbHealth[limb] - 3)
                    shouldSync = true
                    ply:ViewPunch(Angle(math.random(-2, -5), math.random(-3, 3), math.random(-3, 3)) * GetConVar("sv_limbdamage_viewpunch"):GetFloat())
                else
                    local dmg = DamageInfo()
                    dmg:SetDamage(2)
                    dmg:SetAttacker(IsValid(ply.LastAttacker) and ply.LastAttacker or ply)
                    dmg:SetInflictor(IsValid(ply.LastInflictor) and ply.LastInflictor or ply)
                    dmg:SetDamageType(DMG_DIRECT)
                    dmg:SetDamageForce(VectorRand())
                    ply:TakeDamageInfo(dmg)
                end

                local painChance = GetConVar("sv_limbdamage_status_bleed_pain"):GetFloat()

                if not MFA.Medical.LimbStatusHas(ply, "Chest", MFA_MED_STATUS_PAINKILLERS) and not MFA.Medical.LimbStatusHas(ply, limb, MFA_MED_STATUS_PAIN) and math.random() <= painChance then
                    MFA.Medical.LimbStatusAdd(ply, limb, MFA_MED_STATUS_PAIN)
                    shouldSync = true

                    if GetConVar("sv_limbdamage_notify_limbstatus"):GetBool() then
                        MFA.Medical.Message(ply, "Your " .. string.lower(limb) .. " feels painful...")
                    end
                end
            end

            if MFA.Medical.LimbStatusHas(ply, limb, MFA_MED_STATUS_FRACTURE) then
                local painChance = GetConVar("sv_limbdamage_status_cripple_pain"):GetFloat()

                if not MFA.Medical.LimbStatusHas(ply, "Chest", MFA_MED_STATUS_PAINKILLERS) and not MFA.Medical.LimbStatusHas(ply, limb, MFA_MED_STATUS_PAIN) and math.random() <= painChance then
                    MFA.Medical.LimbStatusAdd(ply, limb, MFA_MED_STATUS_PAIN)
                    shouldSync = true

                    if GetConVar("sv_limbdamage_notify_limbstatus"):GetBool() then
                        MFA.Medical.Message(ply, "Your " .. string.lower(limb) .. " feels painful...")
                    end
                end
            end

            if MFA.Medical.LimbStatusHas(ply, limb, MFA_MED_STATUS_PAIN) then
                if MFA.Medical.LimbStatusHas(ply, limb, MFA_MED_STATUS_BLEED) then
                    ply.LimbPain = ply.LimbPain + 1
                end

                if MFA.Medical.LimbStatusHas(ply, limb, MFA_MED_STATUS_FRACTURE) then
                    ply.LimbPain = ply.LimbPain + 2
                end

                if ply.LimbStatus[limb] == MFA_MED_STATUS_PAIN and (limb ~= "Chest" and ply.LimbHealth[limb] > 0) then
                    ply.LimbPain = math.max(0, ply.LimbPain - 2)
                    shouldSync = true
                end

                if ply.LimbPain <= 0 then
                    MFA.Medical.LimbStatusRemove(ply, limb, MFA_MED_STATUS_PAIN)
                    shouldSync = true

                    if GetConVar("sv_limbdamage_notify_limbstatus"):GetBool() then
                        MFA.Medical.Message(ply, "You no longer feel pain in your " .. string.lower(limb) .. ".")
                    end
                end
            end
        end

        if MFA.Medical.LimbStatusHas(ply, "Chest", MFA_MED_STATUS_PAINKILLERS) and (ply.LimbPainkillersEndTime or 0) < CurTime() then
            MFA.Medical.LimbStatusRemove(ply, "Chest", MFA_MED_STATUS_PAINKILLERS)
            shouldSync = true

            if GetConVar("sv_limbdamage_notify_limbstatus"):GetBool() then
                MFA.Medical.Message(ply, "Your painkillers wear off.")
            end
        end

        local painLimbs = 0

        for limb, status in pairs(ply.LimbStatus) do
            if MFA.Medical.LimbStatusHas(ply, limb, MFA_MED_STATUS_PAIN) then
                painLimbs = painLimbs + 1
            end
        end

        if not MFA.Medical.LimbStatusHas(ply, "Chest", MFA_MED_STATUS_TREMOR) and ply.LimbPain * painLimbs > 400 then
            MFA.Medical.LimbStatusAdd(ply, "Chest", MFA_MED_STATUS_TREMOR)
            shouldSync = true

            if GetConVar("sv_limbdamage_notify_limbstatus"):GetBool() then
                MFA.Medical.Message(ply, "You are trembling from pain...")
            end
        elseif painLimbs == 0 and MFA.Medical.LimbStatusHas(ply, "Chest", MFA_MED_STATUS_TREMOR) then
            MFA.Medical.LimbStatusRemove(ply, "Chest", MFA_MED_STATUS_TREMOR)
            shouldSync = true

            if GetConVar("sv_limbdamage_notify_limbstatus"):GetBool() then
                MFA.Medical.Message(ply, "You no longer feel tremor.")
            end
        end

        if shouldSync then
            MFA.Medical.Sync(ply)
        end
    end
end)

if JMOD_CONFIG then
    hook.Add("JMod_MedkitHeal", "LimbDamage_JMod", function(ply, ent, kit)
        if not GetConVar("limbdamage_enabled"):GetBool() then return end

        if ent:IsPlayer() and ent:Health() >= ent:GetMaxHealth() then
            local limb = MFA.Medical.GetDamagedLimbs(ent)[1]

            if limb and ent.LimbHealth[limb] >= 0 then
                ent.LimbHealth[limb] = math.min(ent.LimbHealth[limb] + 3, ent.LimbMaxHealth[limb])
                kit:SetSupplies(kit:GetSupplies() - 1)
                kit:HealEffect()
                MFA.Medical.Sync(ply)

                return false
            end
        end
    end)

    hook.Add("JMod_CanFieldHospitalStart", "LimbDamage_JMod", function(ent, ply)
        if not GetConVar("limbdamage_enabled"):GetBool() then return end
        if #MFA.Medical.GetDamagedLimbs(ply) > 0 or #MFA.Medical.GetWeakenedLimbs(ply) > 0 then return true end
    end)

    hook.Add("JMod_FieldHospitalHeal", "LimbDamage_JMod", function(ent, ply)
        if not GetConVar("limbdamage_enabled"):GetBool() then return end

        if ply:Health() >= ply:GetMaxHealth() then
            local limb = MFA.Medical.GetBrokenLimbs(ply)[1]

            if limb then
                ply.LimbHealth[limb] = 1
                ent:ConsumeElectricity(2)
                ent:SetSupplies(ent:GetSupplies() - 1)
                ent:HealEffect()
                MFA.Medical.Sync(ply)

                return false
            end

            limb = MFA.Medical.GetDamagedLimbs(ply)[1]

            if limb and ply.LimbHealth[limb] >= 0 then
                ply.LimbHealth[limb] = math.min(ply.LimbHealth[limb] + math.ceil(6 * ent.HealEfficiency), ply.LimbMaxHealth[limb])
                ent:ConsumeElectricity(2)
                ent:SetSupplies(ent:GetSupplies() - 1)
                ent:HealEffect()
                MFA.Medical.Sync(ply)

                return false
            end

            limb = MFA.Medical.GetWeakenedLimbs(ply)[1]

            if limb then
                ply.LimbMaxHealth[limb] = math.min(ply.LimbMaxHealth[limb] + math.ceil(3 * ent.HealEfficiency), MFA.Medical.GetTrueMaxHealth(ply, limb))
                ply.LimbHealth[limb] = math.min(ply.LimbHealth[limb] + math.ceil(3 * ent.HealEfficiency), ply.LimbMaxHealth[limb])
                ent:ConsumeElectricity(2)
                ent:SetSupplies(ent:GetSupplies() - 1)
                ent:HealEffect()
                MFA.Medical.Sync(ply)

                return false
            end
        end
    end)

    print("Loaded JMod hooks")
end