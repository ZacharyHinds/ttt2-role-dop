CreateConVar("ttt2_doppel_steal_role", "1", {FCVAR_ARCHIVE, FCVAR_NOTIFY})

hook.Add("TTTUlxDynamicRCVars", "ttt2_ulx_doppel_dynamic_convars", function(tbl)
  tbl[ROLE_DOPPELGANGER] = tbl[ROLE_DOPPELGANGER] or {}

  table.insert(tbl[ROLE_DOPPELGANGER], {
      cvar = "ttt2_doppel_steal_role",
      checkbox = true,
      desc = "ttt2_doppel_steal_role"
  })
end)
