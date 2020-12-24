util.AddNetworkString("ttt2_dop_popup")
local function DoppelChange(ply, key)
  if not DOPPELGANGER then return end
  if not IsValid(ply) or not ply:IsPlayer() then return end
  if ply:GetSubRole() ~= ROLE_MIMIC and ply:GetSubRole() ~= ROLE_DOPPELGANGER then return end

  if key ~= IN_USE then return end

  local trace = ply:GetEyeTrace(MASK_SHOT_HULL)
  local distance = trace.StartPos:Distance(trace.HitPos)
  local tgt = trace.Entity

  if distance > 100 or not IsValid(tgt) or not tgt:IsPlayer() then return end

  local new_role = tgt:GetSubRole()
  local new_team = tgt:GetTeam()
  local did_steal = true

  if ply:GetSubRole() == ROLE_DOPPELGANGER then
    new_team = TEAM_DOPPELGANGER
  end

  ply, new_role, new_team, did_steal = hook.Run("TTT2DoppelgangerRoleChange", ply, new_role, new_team, did_steal) or ply, new_role, new_team, did_steal
  timer.Simple(GetConVar("ttt2_dop_steal_delay"):GetInt(), function()
    ply:SetRole(new_role, new_team)
    SendFullStateUpdate()
    ply:UpdateTeam(new_team)
    SendFullStateUpdate()

    if not did_steal then return end
    local steal_mode = GetConVar("ttt2_dop_steal_role"):GetBool()

    if steal_mode then
      if not IsValid(tgt) or not tgt:Alive() or tgt:IsSpec() then return end
      local steal_role = GetConVar("ttt2_dop_replace_role"):GetInt()
      local replace_role, replace_team = ROLE_INNOCENT, TEAM_INNOCENT
      if steal_role == 1 and AMNESIAC then
        replace_role = ROLE_AMNESIAC
        replace_team = TEAM_NONE
      elseif steal_role == 2 and UNKNOWN then
        replace_role = ROLE_UNKNOWN
        replace_team = TEAM_NONE
      elseif steal_role == 3 and MIMIC then
        replace_role = ROLE_MIMIC
        replace_team = TEAM_NONE
      end
      tgt:SetRole(replace_role, replace_team)
      SendFullStateUpdate()
    end

    local popup_mode = GetConVar("ttt2_dop_declare_mode"):GetInt()

    if popup_mode == 1 or (popup_mode ~= 2 and steal_mode) then
      net.Start("ttt2_dop_popup")
      net.WriteEntity(tgt)
      net.WriteEntity(ply)
      net.WriteBool(steal_mode)
      net.Send(tgt)
    elseif popup_mode == 2 then
      net.Start("ttt2_dop_popup")
      net.WriteEntity(tgt)
      net.WriteEntity(ply)
      net.WriteBool(steal_mode)
      net.Broadcast()
    end
  end)
end
hook.Add("KeyPress", "TTT2DoppelChange", DoppelChange)

hook.Add("TTT2SpecialRoleSyncing", "TTT2RoleDopMod", function(ply, tbl)
  if GetRoundState() == ROUND_POST then return end
  if ply:GetSubRoleData().unknownTeam then return end

  local dopSelected = false

  for dop in pairs(tbl) do
    if dop:IsTerror() and dop:Alive() and dop:GetTeam() == TEAM_DOPPELGANGER and dop:GetSubRole() ~= ROLE_DOPPELGANGER then
      if dop ~= ply then
        tbl[dop] = {dop:GetBaseRole(), dop:GetSubRoleData().defaultTeam}
      else
        tbl[dop] = {dop:GetSubRole(), TEAM_DOPPELGANGER}
      end
      dopSelected = true
    end
  end

  if dopSelected and ply:GetTeam() == TEAM_DOPPELGANGER then
    for teammate in pairs(tbl) do
      if teammate == ply then continue end
      if teammate:GetTeam() == TEAM_DOPPELGANGER then continue end
      if not teammate:IsTerror() or not teammate:Alive() then continue end
      if teammate:HasTeam(ply:GetSubRoleData().defaultTeam) then
        tbl[teammate] = {teammate:GetSubRole(), teammate:GetTeam()}
      end
    end
  end
end)

local function DoppelMarker(ply, new_role, new_team, did_steal)
  if not MARKER then return end
  if not IsValid(ply) or ply:IsSpec() or not ply:Alive() then return end
  if ply:GetSubRole() ~= ROLE_DOPPELGANGER and ply:GetSubRole() ~= ROLE_MIMIC then return end
  if new_role ~= ROLE_MARKER then return end
  did_steal = false

  if AMNESIAC then
    new_role = ROLE_AMNESIAC
    new_team = TEAM_NONE
  elseif UNKNOWN then
    new_role = ROLE_UNKNOWN
    new_team = TEAM_NONE
  else
    new_role = ROLE_INNOCENT
    new_team = TEAM_INNOCENT
  end

  if MARKER_DATA then MARKER_DATA:SetMarkedPlayer(ply) end

  return ply, new_role, new_team, did_steal
end

hook.Add("TTT2DoppelgangerRoleChange", "TTT2DoppelMarker", DoppelMarker)
