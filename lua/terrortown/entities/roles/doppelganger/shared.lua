AddCSLuaFile()
if SERVER then
  resource.AddFile("materials/vgui/ttt/dynamic/roles/icon_dop.vmt")
end

roles.InitCustomTeam(ROLE.name, {
    icon = "materials/vgui/ttt/dynamic/roles/icon_dop.vmt",
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
