CreateConVar("ttt2_dop_steal_role", "1", {FCVAR_ARCHIVE, FCVAR_NOTIFY})
CreateConVar("ttt2_dop_declare_mode", "1", {FCVAR_NOTIFY, FCVAR_ARCHIVE})
CreateConVar("ttt2_dop_steal_delay", "2", {FCVAR_NOTIFY, FCVAR_ARCHIVE, FCVAR_REPLICATED})
CreateConVar("ttt2_dop_replace_role", "1", {FCVAR_NOTIFY, FCVAR_ARCHIVE})
CreateConVar("ttt2_mim_steal_role", "1", {FCVAR_ARCHIVE, FCVAR_NOTIFY})
CreateConVar("ttt2_mim_grace_time", "10", {FCVAR_ARCHIVE, FCVAR_NOTIFY})

CreateConVar("ttt2_dop_marker", "1", {FCVAR_NOTIFY, FCVAR_ARCHIVE})
CreateConVar("ttt2_dop_jester", "1", {FCVAR_NOTIFY, FCVAR_ARCHIVE})
CreateConVar("ttt2_dop_infected", "1", {FCVAR_NOTIFY, FCVAR_ARCHIVE})
CreateConVar("ttt2_dop_beacon", "1", {FCVAR_NOTIFY, FCVAR_ARCHIVE})
CreateConVar("ttt2_dop_grace_time", "10", {FCVAR_ARCHIVE, FCVAR_NOTIFY})

CreateConVar("ttt2_dop_mimic", "1", {FCVAR_NOTIFY, FCVAR_ARCHIVE})
CreateConVar("ttt2_dop_unknown", "1", {FCVAR_NOTIFY, FCVAR_ARCHIVE})
CreateConVar("ttt2_dop_amnesiac", "1", {FCVAR_NOTIFY, FCVAR_ARCHIVE})
CreateConVar("ttt2_dop_pirate", "1", {FCVAR_NOTIFY, FCVAR_ARCHIVE})
CreateConVar("ttt2_dop_bodyguard", "1", {FCVAR_NOTIFY, FCVAR_ARCHIVE})
CreateConVar("ttt2_dop_allow_force_team", "1", {FCVAR_NOTIFY, FCVAR_ARCHIVE})
CreateConVar("ttt2_dop_wrath", "1", {FCVAR_NOTIFY, FCVAR_ARCHIVE})

CreateConVar("ttt2_dop_thrall", "1", {FCVAR_NOTIFY, FCVAR_ARCHIVE})
CreateConVar("ttt2_dop_jackal", "1", {FCVAR_NOTIFY, FCVAR_ARCHIVE})
CreateConVar("ttt2_dop_sidekick", "0", {FCVAR_NOTIFY, FCVAR_ARCHIVE})
CreateConVar("ttt2_dop_corpse_indicator", "1", {FCVAR_NOTIFY, FCVAR_ARCHIVE})

hook.Add("TTTUlxDynamicRCVars", "ttt2_ulx_doppel_dynamic_convars", function(tbl)
  tbl[ROLE_MIMIC] = tbl[ROLE_MIMIC] or {}
  tbl[ROLE_DOPPELGANGER] = tbl[ROLE_DOPPELGANGER] or {}

  table.insert(tbl[ROLE_MIMIC], {
      cvar = "ttt2_mim_steal_role",
      checkbox = true,
      desc = "ttt2_mim_steal_role"
  })

  table.insert(tbl[ROLE_MIMIC], {
    cvar = "ttt2_dop_declare_mode",
    combobox = true,
    choices = {
      "ttt2_dop_declare_state_0",
      "ttt2_dop_declare_state_1",
      "ttt2_dop_declare_state_2"
    },
    numStart = 0,
    desc = "ttt2_dop_declare_mode"
  })

  table.insert(tbl[ROLE_MIMIC], {
    cvar = "ttt2_dop_replace_role",
    combobox = true,
    choices = {
      "ttt2_dop_replace_role_0",
      "ttt2_dop_replace_role_1",
      "ttt2_dop_replace_role_2",
      "ttt2_dop_replace_role_3"
    },
    numStart = 0,
    desc = "ttt2_dop_replace_role"
  })

  table.insert(tbl[ROLE_MIMIC], {
    cvar = "ttt2_dop_steal_delay",
    slider = true,
    min = 0,
    max = 10,
    desc = "ttt2_dop_steal_delay"
  })

  table.insert(tbl[ROLE_MIMIC], {
    cvar = "ttt2_dop_marker",
    checkbox = true,
    desc = "ttt2_dop_marker"
  })

  table.insert(tbl[ROLE_MIMIC], {
    cvar = "ttt2_mim_grace_time",
    slider = true,
    min = 0,
    max = 120,
    desc = "ttt2_mim_grace_time (def. 10)"
  })

  table.insert(tbl[ROLE_DOPPELGANGER], {
      cvar = "ttt2_dop_steal_role",
      checkbox = true,
      desc = "ttt2_dop_steal_role"
  })

  table.insert(tbl[ROLE_DOPPELGANGER], {
    cvar = "ttt2_dop_grace_time",
    slider = true,
    min = 0,
    max = 120,
    desc = "ttt2_dop_grace_time (def. 10)"
  })

  table.insert(tbl[ROLE_DOPPELGANGER], {
    cvar = "ttt2_dop_corpse_indicator",
    checkbox = true,
    desc = "ttt2_dop_corpse_indicator"
  })

  table.insert(tbl[ROLE_DOPPELGANGER], {
    cvar = "ttt2_dop_jester",
    checkbox = true,
    desc = "ttt2_dop_jester"
  })

  table.insert(tbl[ROLE_DOPPELGANGER], {
    cvar = "ttt2_dop_infected",
    checkbox = true,
    desc = "ttt2_dop_infected"
  })

  table.insert(tbl[ROLE_DOPPELGANGER], {
    cvar = "ttt2_dop_beacon",
    checkbox = true,
    desc = "ttt2_dop_beacon"
  })

  table.insert(tbl[ROLE_DOPPELGANGER], {
    cvar = "ttt2_dop_amnesiac",
    checkbox = true,
    desc = "ttt2_dop_amnesiac"
  })

  table.insert(tbl[ROLE_DOPPELGANGER], {
    cvar = "ttt2_dop_unknown",
    checkbox = true,
    desc = "ttt2_dop_unknown"
  })

  table.insert(tbl[ROLE_DOPPELGANGER], {
    cvar = "ttt2_dop_pirate",
    checkbox = true,
    desc = "ttt2_dop_pirate"
  })

  table.insert(tbl[ROLE_DOPPELGANGER], {
    cvar = "ttt2_dop_bodyguard",
    checkbox = true,
    desc = "ttt2_dop_bodyguard"
  })

  table.insert(tbl[ROLE_DOPPELGANGER], {
    cvar = "ttt2_dop_wrath",
    checkbox = true,
    desc = "ttt2_dop_wrath"
  })

  table.insert(tbl[ROLE_DOPPELGANGER], {
    cvar = "ttt2_dop_thrall",
    checkbox = true,
    desc = "ttt2_dop_thrall"
  })

  table.insert(tbl[ROLE_DOPPELGANGER], {
    cvar = "ttt2_dop_jackal",
    checkbox = true,
    desc = "ttt2_dop_jackal"
  })

  table.insert(tbl[ROLE_DOPPELGANGER], {
    cvar = "ttt2_dop_sidekick",
    checkbox = true,
    desc = "ttt2_dop_sidekick"
  })

  table.insert(tbl[ROLE_DOPPELGANGER], {
    cvar = "ttt2_dop_allow_force_team",
    checkbox = true,
    desc = "ttt2_dop_allow_force_team"
  })

end)
