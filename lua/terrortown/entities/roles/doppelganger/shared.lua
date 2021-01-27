AddCSLuaFile()
if SERVER then
  resource.AddFile("materials/vgui/ttt/dynamic/roles/icon_dop.vmt")
  util.AddNetworkString("ttt2_dop_corpse_update")
end

roles.InitCustomTeam(ROLE.name, {
    icon = "vgui/ttt/dynamic/roles/icon_dop.vmt",
    color = Color(132, 50, 191, 255)
})

function ROLE:PreInitialize()
  self.color = Color(132, 50, 191, 255)

  self.abbr = "dop"
  self.surviveBonus = 1
  self.scoreKillsMultiplier = 5
  self.scoreTeamKillsMultiplier = -16

  self.defaultTeam = TEAM_DOPPELGANGER
  self.defaultEquipment = SPECIAL_EQUIPMENT

  self.conVarData = {
    pct = 0.13,
    maximum = 1,
    minPlayers = 7,
    togglable = true,
    random = 20,
  }
end

function ROLE:Initialize()
  roles.SetBaseRole(self, ROLE_MIMIC)
  if SERVER and JESTER then
    self.networkRoles = {JESTER}
  end
end

function CorrectDopPly(ply)
  if not IsValid(ply) or ply:IsSpec() then return end
  if ply:GetSubRole() ~= ROLE_DOPPELGANGER then return end
  if ply:GetTeam() ~= TEAM_NONE then return end

  ply:SetRole(ROLE_DOPPELGANGER, TEAM_DOPPELGANGER)
end

function CorrectDopTeam()
  local GetPlayers = player.GetAll()
  local count = #GetPlayers

  for i = 1, count do
    local ply = GetPlayers[i]
    CorrectDopPly(ply)
  end
end

if SERVER then
  hook.Add("TTTBeginRound", "TTTCorrectDopTeam", CorrectDopTeam)
  hook.Add("TTT2UpdateSubrole", "DoppelRoleChange", function(ply, old, new)
    if new == ROLE_DOPPELGANGER then
      CorrectDopPly(ply)
    end
  end)

  local function PrepareDoppelCorpse(ply)
    if not ply or not IsValid(ply) or not ply:IsPlayer() then return end
    if not ply:HasTeam(TEAM_DOPPELGANGER) then return end
    if not GetConVar("ttt2_dop_corpse_indicator"):GetBool() then return end

    net.Start("ttt2_dop_corpse_update")
    net.WriteEntity(ply)
    net.WriteBool(true)
    net.Broadcast()
  end

  local function ResetDoppelCorpse(ply)
    if not ply or not IsValid(ply) or not ply:IsPlayer() then return end
    net.Start("ttt2_dop_corpse_update")
    net.WriteEntity(ply)
    net.WriteBool(false)
    net.Broadcast()
  end

  hook.Add("PlayerDeath", "ttt2_dop_player_death", PrepareDoppelCorpse)
  hook.Add("PlayerSpawn", "ttt2_dop_player_spawn", ResetDoppelCorpse)
end

if CLIENT then
  net.Receive("ttt2_dop_corpse_update", function()
    local ply = net.ReadEntity()
    if not ply or not IsValid(ply) or not ply:IsPlayer() then return end

    ply.was_doppelganger = net.ReadBool()
  end)

  hook.Add("TTTBodySearchPopulate", "ttt2_doppelganger_corpse_indicator", function(search, raw)
    if not raw.owner then return end
    if not raw.owner.was_doppelganger then return end

    local highest_id = 0
    for _, v in pairs(search) do
      highest_id = math.max(highest_id, v.p)
    end

    search.was_doppelganger = {img = "vgui/ttt/dynamic/roles/icon_dop.vmt", text = LANG.GetTranslation("ttt_dop_was_dop"), p = highest_id + 1}
  end)
end
