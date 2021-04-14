local function DoppelMarker(mimic_data)
  if not MARKER then return end
  if not GetConVar("ttt2_dop_marker"):GetBool() then return end
  local ply = mimic_data.ply
  if not IsValid(ply) or ply:IsSpec() or not ply:Alive() then return end
  if ply:GetSubRole() ~= ROLE_DOPPELGANGER and ply:GetSubRole() ~= ROLE_MIMIC then return end
  if mimic_data.role ~= ROLE_MARKER then return end
  mimic_data.did_steal = false

  if AMNESIAC then
    mimic_data.role = ROLE_AMNESIAC
    mimic_data.team = TEAM_NONE
  elseif UNKNOWN then
    mimic_data.role = ROLE_UNKNOWN
    mimic_data.team = TEAM_NONE
  else
    mimic_data.role = ROLE_INNOCENT
    mimic_data.team = TEAM_INNOCENT
  end
  mimic_data.rolestring = roles.GetByIndex(mimic_data.role).name
  if MARKER_DATA then MARKER_DATA:SetMarkedPlayer(ply) end

  ply:SetNWBool("isForceDoppelganger", false)
  return mimic_data
end

local function DoppelJester(mimic_data)
  if not JESTER then return end
  if not GetConVar("ttt2_dop_jester"):GetBool() then return end
  local ply = mimic_data.ply
  if not IsValid(ply) or ply:IsSpec() or not ply:Alive() then return end
  if ply:GetSubRole() ~= ROLE_DOPPELGANGER then return end
  if mimic_data.role ~= ROLE_JESTER then return end
  mimic_data.did_steal = false
  if AMNESIAC then
    mimic_data.role = ROLE_AMNESIAC
    mimic_data.team = TEAM_NONE
  elseif UNKNOWN then
    mimic_data.role = ROLE_UNKNOWN
    mimic_data.team = TEAM_NONE
  else
    mimic_data.role = ROLE_INNOCENT
  end
  mimic_data.rolestring = roles.GetByIndex(mimic_data.role).name

  ply:SetNWBool("isForceDoppelganger", false)
  return mimic_data
end

local function DoppelDoppel(mimic_data)
  if mimic_data.role ~= ROLE_DOPPELGANGER then return end
  mimic_data.abort = true
end

local function DoppelInfected(mimic_data)
  if not INFECTED then return end
  if not GetConVar("ttt2_dop_infected"):GetBool() then return end
  local ply = mimic_data.ply
  if not IsValid(ply) or ply:IsSpec() or not ply:Alive() then return end
  if ply:GetSubRole() ~= ROLE_DOPPELGANGER then return end
  if mimic_data.role ~= ROLE_INFECTED then return end
  mimic_data.did_steal = false
  if UNKNOWN then
    mimic_data.role = ROLE_UNKNOWN
    mimic_data.team = TEAM_NONE
  else
    mimic_data.role = ROLE_INNOCENT
  end
  mimic_data.rolestring = roles.GetByIndex(mimic_data.role).name

  return mimic_data
end

local function DoppelBeacon(mimic_data)
  if not BEACON then return end
  if not GetConVar("ttt2_dop_beacon"):GetBool() then return end
  local ply = mimic_data.ply
  if not IsValid(ply) or ply:IsSpec() or not ply:Alive() then return end
  if ply:GetSubRole() ~= ROLE_DOPPELGANGER then return end
  if mimic_data.role ~= ROLE_BEACON then return end
  -- mimic_data.role = ROLE_INNOCENT
  -- mimic_data.rolestring = roles.GetByIndex(mimic_data.role).name
  ply:SetNWBool("isDormantDoppelganger", true)

  return mimic_data
end

local function DoppelMimic(mimic_data)
  if not MIMIC then return end
  if not GetConVar("ttt2_dop_mimic"):GetBool() then return end
  local ply = mimic_data.ply
  if not IsValid(ply) or ply:IsSpec() or not ply:Alive() then return end
  if ply:GetSubRole() ~= ROLE_DOPPELGANGER then return end
  if mimic_data.role ~= ROLE_MIMIC then return end
  local tgt = mimic_data.tgt
  if not IsValid(tgt) or tgt:IsSpec() or not tgt:Alive() then return end
  tgt:SetRole(ROLE_DOPPELGANGER, TEAM_DOPPELGANGER)
  SendFullStateUpdate()
  tgt:UpdateTeam(TEAM_DOPPELGANGER)
  SendFullStateUpdate()
  mimic_data.abort = true
  mimic_data.role = ROLE_DOPPELGANGER
  return mimic_data
end

local function DoppelUnknown(mimic_data)
  if not UNKNOWN then return end
  if not GetConVar("ttt2_dop_unknown"):GetBool() then return end
  local ply = mimic_data.ply
  local tgt = mimic_data.tgt
  if not IsValid(ply) or not IsValid(tgt) or not ply:Alive() or not tgt:Alive() or ply:IsSpec() or tgt:IsSpec() then return end
  if mimic_data.role ~= ROLE_UNKNOWN then return end
  if ply:GetSubRole() ~= ROLE_DOPPELGANGER then return end
  mimic_data.did_steal = false
  ply:SetNWBool("isDormantDoppelganger", true)

  return mimic_data
end

local function DoppelAmnesiac(mimic_data)
  if not AMNESIAC then return end
  if not GetConVar("ttt2_dop_amnesiac"):GetBool() then return end
  local ply = mimic_data.ply
  local tgt = mimic_data.tgt
  if not IsValid(ply) or not IsValid(tgt) or not ply:Alive() or not tgt:Alive() or ply:IsSpec() or tgt:IsSpec() then return end
  if mimic_data.role ~= ROLE_AMNESIAC then return end
  if ply:GetSubRole() ~= ROLE_DOPPELGANGER then return end
  mimic_data.did_steal = false
  ply:SetNWBool("isDormantDoppelganger", true)

  return mimic_data
end

local function DoppelBodyguard(mimic_data)
  if not BODYGUARD then return end
  if not GetConVar("ttt2_dop_bodyguard"):GetBool() then return end
  local ply = mimic_data.ply
  local tgt = mimic_data.tgt
  if not IsValid(ply) or not IsValid(tgt) or not ply:Alive() or not tgt:Alive() or ply:IsSpec() or tgt:IsSpec() then return end
  if mimic_data.role ~= ROLE_BODYGUARD then return end
  if ply:GetSubRole() ~= ROLE_DOPPELGANGER then return end
  mimic_data.did_steal = false
  mimic_data.abort = true
  tgt:SetRole(ROLE_DOPPELGANGER, TEAM_DOPPELGANGER)
  ply:SetRole(ROLE_BODYGUARD, TEAM_DOPPELGANGER)
  SendFullStateUpdate()
  timer.Simple(0.1, function() BODYGRD_DATA:SetNewGuard(ply, tgt) end)
  return mimic_data
end

local function DoppelWrath(mimic_data)
  if not WRATH then return end
  if not GetConVar("ttt2_dop_wrath"):GetBool() then return end
  local ply = mimic_data.ply
  if not IsValid(ply) or not ply:Alive() or ply:IsSpec() then return end
  ply:SetNWBool("isDormantDoppelganger", true)
end

local function isExceptedRole(ply)
  local role = ply:GetSubRole()
  if role == ROLE_THRALL and not GetConVar("ttt2_dop_thrall"):GetBool() then return true end
  if role == ROLE_SIDEKICK and not GetConVar("ttt2_dop_sidekick"):GetBool() then return true end
end

local function ForceDoppelgangerTeam(ply, old, new)
  if not ply or not IsValid(ply) then return end
  if not GetConVar("ttt2_dop_allow_force_team"):GetBool() then return end
  if old ~= TEAM_DOPPELGANGER or new == TEAM_DOPPELGANGER then return end
  if not ply:GetNWBool("isForceDoppelganger") then return end
  if isExceptedRole(ply) then return end
  ply:UpdateTeam(TEAM_DOPPELGANGER)
  ply:SetNWBool("isForceDoppelganger", false)
end

local function ResetForceDoppelTeam()
  local plys = player.GetAll()
  for i = 1, #plys do
    plys[i]:SetNWBool("isForceDoppelganger", false)
    plys[i]:SetNWBool("DopJackalSidekick", false)
  end
end

local function PirateDoppelTeam(ply, old, new)
  if not ply or not IsValid(ply) then return end
  if not GetConVar("ttt2_dop_pirate"):GetBool() then return end
  if old ~= TEAM_DOPPELGANGER or new == TEAM_DOPPELGANGER then return end
  if ply:GetSubRole() ~= ROLE_PIRATE and ply:GetSubRole() ~= ROLE_PIRATE_CAPTAIN then return end
  ply:UpdateTeam(TEAM_DOPPELGANGER)
end

local function BodyguardDoppelTeam(ply, old, new)
  if not ply or not IsValid(ply) then return end
  if not GetConVar("ttt2_dop_bodyguard"):GetBool() then return end
  if old ~= TEAM_DOPPELGANGER or new == TEAM_DOPPELGANGER then return end
  if ply:GetSubRole() ~= ROLE_BODYGUARD then return end
  ply:UpdateTeam(TEAM_DOPPELGANGER)
end

local function IsJackalDoppel()
  if not DOPPELGANGER or not JACKAL then return end
  local plys = util.GetAlivePlayers()
  for i = 1, #plys do
    local ply = plys[i]
    if ply:GetSubRole() == ROLE_JACKAL and ply:GetTeam() == TEAM_DOPPELGANGER then
      return true
    end
  end
end

local function JackalSidekickDoppel(ply, old, new)
  if not ply or not IsValid(ply) then return end
  if not DOPPELGANGER or not JACKAL or not SIDEKICK then return end
  if new ~= TEAM_JACKAL then return end
  if not IsJackalDoppel() then return end

  ply:UpdateTeam(TEAM_DOPPELGANGER)
end

local function ThrallDoppelTeam(ply, old, new)
  if not ply or not IsValid(ply) then return end
  if not MESMERIST or not THRALL or not DOPPELGANGER then return end
  if new ~= TEAM_TRAITOR then return end
  if old ~= TEAM_DOPPELGANGER then return end
  if not GetConVar("ttt2_dop_thrall"):GetBool() then return end
  if ply:GetSubRole() ~= ROLE_THRALL then return end
  ply:UpdateTeam(TEAM_DOPPELGANGER)
end

hook.Add("TTT2DoppelgangerRoleChange", "TTT2DoppelMarker", DoppelMarker)
hook.Add("TTT2DoppelgangerRoleChange", "TTT2DoppelJester", DoppelJester)
hook.Add("TTT2DoppelgangerRoleChange", "TTT2DoppelInfected", DoppelInfected)
hook.Add("TTT2DoppelgangerRoleChange", "TTT2DoppelBeacon", DoppelBeacon)
hook.Add("TTT2DoppelgangerRoleChange", "TTT2DoppelMimic", DoppelMimic)
hook.Add("TTT2DoppelgangerRoleChange", "TTT2DoppelUnknown", DoppelUnknown)
hook.Add("TTT2DoppelgangerRoleChange", "TTT2DoppelAmnesiac", DoppelAmnesiac)
hook.Add("TTT2DoppelgangerRoleChange", "TTT2DoppelBodyguard", DoppelBodyguard)
hook.Add("TTT2DoppelgangerRoleChange", "TTT2DoppelDoppel", DoppelDoppel)
hook.Add("TTT2DoppelgangerRoleChange", "TTT2DoppelWrath", DoppelWrath)

-- hook.Add("TTTBeginRound", "ResetForceDoppelTeam", ResetForceDoppelTeam)
-- hook.Add("TTTPrepareRound", "ResetForceDoppelTeam", ResetForceDoppelTeam)
-- hook.Add("TTTEndRound", "ResetForceDoppelTeam", ResetForceDoppelTeam)
--
-- hook.Add("TTT2UpdateTeam", "ForceDoppelgangerTeam", ForceDoppelgangerTeam)
-- hook.Add("TTT2UpdateTeam", "PirateDoppelTeam", PirateDoppelTeam)
-- hook.Add("TTT2UpdateTeam", "BodyguardDoppelTeam", BodyguardDoppelTeam)
-- hook.Add("TTT2UpdateTeam", "JackalSidekickDoppel", JackalSidekickDoppel)
-- hook.Add("TTT2UpdateTeam", "ThrallDoppelTeam", ThrallDoppelTeam)
-- hook.Add("TTT2UpdateTeam", "SidekickDoppelTeam", SidekickDoppelTeam)
