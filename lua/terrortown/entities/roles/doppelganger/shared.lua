if SERVER then
  AddCSLuaFile()
  resource.AddFile()
end

roles.InitCustomTeam(ROLE.name, {
  icon = "",
  color = Color()
})

function ROLE:PreInitialize()
  self.color = Color()

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

end

if SERVER then
  
end
