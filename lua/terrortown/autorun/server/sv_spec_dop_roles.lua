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
    mimic_data.team = TEAM_INNOCENT
  end
  mimic_data.rolestring = roles.GetByIndex(mimic_data.role).name

  return mimic_data
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
    mimic_data.team = TEAM_INNOCENT
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
  mimic_data.role = ROLE_INNOCENT
  mimic_data.team = TEAM_INNOCENT
  mimic_data.rolestring = roles.GetByIndex(mimic_data.role).name

  return mimic_data
end

hook.Add("TTT2DoppelgangerRoleChange", "TTT2DoppelMarker", DoppelMarker)
hook.Add("TTT2DoppelgangerRoleChange", "TTT2DoppelJester", DoppelJester)
hook.Add("TTT2DoppelgangerRoleChange", "TTT2DoppelInfected", DoppelInfected)
hook.Add("TTT2DoppelgangerRoleChange", "TTT2DoppelBeacon", DoppelBeacon)
