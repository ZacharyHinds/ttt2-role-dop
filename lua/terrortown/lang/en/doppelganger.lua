L = LANG.GetLanguageTableReference("en")

-- GENERAL ROLE LANGUAGE STRINGS
L[DOPPELGANGER.name] = "Doppelganger"
L[DOPPELGANGER.defaultTeam] = "Team Doppelganger"
L["info_popup_" .. DOPPELGANGER.name] = [[You are the Doppelganger! You can copy someone's role!]]
L["body_found_" .. DOPPELGANGER.abbr] = "They were a Doppelganger!"
L["search_role_" .. DOPPELGANGER.abbr] = "This person was a Doppelganger!"
L["target_" .. DOPPELGANGER.name] = "Doppelganger"
L["ttt2_desc_" .. DOPPELGANGER.name] = [[The Doppelganger can clone another player's role.]]
L["hilite_win_" .. DOPPELGANGER.defaultTeam] = "THE DOPPELGANGER WON"
L["win_" .. DOPPELGANGER.defaultTeam] = "The Doppelganger won!"
L["hilite_win_doppelgangers"] = "THE DOPPELGANGER WON"

-- OTHER ROLE LANGUAGE STRINGS
L["ttt2_dop_clone_all"] = "The Mimic has copied someone's role!"
L["ttt2_dop_stole_all"] = "The Mimic has stolen someone's role!"
L["ttt2_dop_clone"] = "The Mimic has copied your role!"
L["ttt2_dop_stole"] = "The Mimic has stolen your role!"
L["ttt2_dop_stole_text"] = "You are now a {role}!"
L["ttt2_dop_desc_copy"] = "Press {usekey} to {mode} their role"
L["ttt_dop_was_dop"] = "This person was actually a Doppelganger in disguise!"

-- ULX LANGUAGE STRINGS
-- L["ttt2_dop_declare_state_0"] = "Don't declare"
-- L["ttt2_dop_declare_state_1"] = "Declare to victim"
-- L["ttt2_dop_declare_state_2"] = "Declare to everyone"
-- L["ttt2_dop_replace_role_0"] = "Victim becomes Innocent"
-- L["ttt2_dop_replace_role_1"] = "Victim becomes Amnesiac"
-- L["ttt2_dop_replace_role_2"] = "Victim becomes Unkown"
-- L["ttt2_dop_replace_role_3"] = "Victim becomes Mimic"

--EVENT STRING
L["title_role_steal_dop"] = "A Doppelganger stole a role"
L["desc_role_steal"] = "{nick} stole {victim}'s role."
L["desc_role_copy"] = "{nick} copied {victim}'s role."