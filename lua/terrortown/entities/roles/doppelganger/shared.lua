AddCSLuaFile()
if SERVER then
  resource.AddFile("materials/vgui/ttt/dynamic/roles/icon_dop.vmt")
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

  ply:UpdateTeam(TEAM_DOPPELGANGER)
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
end
