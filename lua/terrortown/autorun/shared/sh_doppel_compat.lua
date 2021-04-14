
if SERVER then
  local function CreateDoppelSync(dop, ply)
    ply = ply or nil
    local doppel_sync = {
      subrole = dop:GetSubRole(),
      team = dop:GetSubRoleData().defaultTeam,
      know_team = not dop:GetSubRoleData().unknownTeam,
      public = false,
      witness = ply
    }
    if dop:GetBaseRole() == ROLE_DETECTIVE then
      doppel_sync.public = true
    end
    doppel_sync = hook.Run("TTT2DoppelSync", doppel_sync) or doppel_sync
    return doppel_sync
  end

  local function DoppelSync(ply, tbl)
    if GetRoundState() == ROUND_POST then return end

    for dop in pairs(tbl) do
      if dop:IsTerror() and dop:Alive() and dop:GetTeam() == TEAM_DOPPELGANGER then
        local doppel_sync = CreateDoppelSync(dop, ply)
        if ply ~= dop and ((not ply:GetSubRoleData().unknownTeam and ply:HasTeam(doppel_sync.team)) or doppel_sync.public) then
          tbl[dop] = {doppel_sync.subrole, doppel_sync.team}
        end
      end
    end

    if not ply:HasTeam(TEAM_DOPPELGANGER) then return end
    local doppel_sync = CreateDoppelSync(ply)
    for teammate in pairs(tbl) do
      if teammate == ply then continue end
      if teammate:HasTeam(TEAM_DOPPELGANGER) then continue end
      if not teammate:IsTerror() or not teammate:Alive() then continue end
      if teammate:HasTeam(doppel_sync.team) and doppel_sync.know_team then
        tbl[teammate] = {teammate:GetSubRole(), teammate:GetTeam()}
      end
    end
  end
  hook.Add("TTT2SpecialRoleSyncing", "TTT2DoppelRoleSyncing", DoppelSync)

  local function CreateDoppelData(ply, old, new)
    local doppel_data = {
      ply = ply,
      allow_force = GetConVar("ttt2_dop_allow_force_team"):GetBool(),
      is_forced = ply:GetNWBool("isForceDoppelganger"),
      is_dormant = ply:GetNWBool("isDormantDoppelganger"),
      resetForced = false,
      resetDormant = true
    }
    doppel_data.old_team = old
    doppel_data.new_team = new
    doppel_data = hook.Run("TTT2DoppelTeamChange", doppel_data) or doppel_data
    if doppel_data.is_forced and doppel_data.allow_force then
      doppel_data.new_team = TEAM_DOPPELGANGER
      if doppel_data.resetForced then
        ply:SetNWBool("isForceDoppelganger", false)
      end
    end

    return doppel_data
  end

  local function DoppelTeamChange(ply, old, new)
    if not ply or not IsValid(ply) then return end
    if not ply:GetNWBool("isForceDoppelganger") or old ~= TEAM_DOPPELGANGER then return end
    local doppel_data = CreateDoppelData(ply, old, new)

    if new ~= doppel_data.new_team then
      ply:UpdateTeam(doppel_data.new_team)
    end

  end

  hook.Add("TTT2UpdateTeam", "TTT2DoppelTeamChange", DoppelTeamChange)

  --Sync Compatibility
  local function DoppelMedicSync(sync_data)
    if not MEDIC then return end
    if sync_data.subrole ~= ROLE_MEDIC then return end
    sync_data.public = true
    return sync_data
  end
  hook.Add("TTT2DoppelSync", "DoppelMedicSync", DoppelMedicSync)

  --Remove force role for TEAM_NONE
  local function NoneTeamException(doppel_data)
    if doppel_data.new_team ~= TEAM_NONE then return end
    if not doppel_data.is_dormant then
      doppel_data.is_forced = false
      doppel_data.ply:SetNWBool("isForceDoppelganger", false)
    elseif doppel_data.resetDormant then
      doppel_data.is_dormant = false
      doppel_data.ply:SetNWBool("isDormantDoppelganger", false)
    end
    return doppel_data
  end
  hook.Add("TTT2DoppelTeamChange", "TTT2NoneTeamException", NoneTeamException)
end
