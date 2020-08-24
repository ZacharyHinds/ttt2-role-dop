CreateConVar("ttt2_dop_steal_role", "1", {FCVAR_ARCHIVE, FCVAR_NOTIFY})
CreateConVar("ttt2_dop_declare_mode", "1", {FCVAR_NOTIFY, FCVAR_ARCHIVE})

hook.Add("TTTUlxDynamicRCVars", "ttt2_ulx_doppel_dynamic_convars", function(tbl)
  tbl[ROLE_DOPPELGANGER] = tbl[ROLE_DOPPELGANGER] or {}
  tbl[ROLE_MIMIC] = tbl[ROLE_MIMIC] or {}

  table.insert(tbl[ROLE_DOPPELGANGER], {
      cvar = "ttt2_dop_steal_role",
      checkbox = true,
      desc = "ttt2_dop_steal_role"
  })

  table.insert(tbl[ROLE_DOPPELGANGER], {
    cvar = "ttt2_dop_declare_mode",
    combobox = true,
    choices = {
      "Don't declare",
      "Declare to victim",
      "Declare to everyone"
    },
    numStart = 0,
    desc = "ttt2_dop_declare_mode"
  })

  table.insert(tbl[ROLE_MIMIC], {
      cvar = "ttt2_dop_steal_role",
      checkbox = true,
      desc = "ttt2_dop_steal_role"
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
end)
