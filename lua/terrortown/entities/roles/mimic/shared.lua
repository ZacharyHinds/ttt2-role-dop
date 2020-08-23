AddCSLuaFile()
if SERVER then
  resource.AddFile("materials/vgui/ttt/dynamic/roles/icon_mim.vmt")
end

function ROLE:PreInitialize()
  self.color = Color(161, 47, 186, 255)

  self.abbr = "mim"
  self.surviveBonus = 1
  self.scoreKillsMultiplier = 5
  self.scoreTeamKillsMultiplier = -16

  self.defaultTeam = TEAM_NONE
  self.defaultEquipment = DEFAULT_LOADOUT

  self.conVarData = {
    pct = 0.13,
    maximum = 1,
    minPlayers = 7,
    togglable = true,
    random = 50,
  }
end

function ROLE:Initialize()

end
