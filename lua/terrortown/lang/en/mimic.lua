L = LANG.GetLanguageTableReference("en")

-- GENERAL ROLE LANGUAGE STRINGS
L[MIMIC.name] = "Mimic"
L["info_popup_" .. MIMIC.name] = [[You are the Mimic! Copy someone's role and join their team!]]
L["body_found_" .. MIMIC.abbr] = "They were a Mimic!"
L["search_role_" .. MIMIC.abbr] = "This person was a Mimic"
L["target_" .. MIMIC.name] = "Mimic"
L["ttt2_desc_" .. MIMIC.name] = [[The Mimic copies someone's role and joins their team.]]

-- OTHER ROLE LANGUAGE STRINGS
L["ttt2_mim_transform"] = "Transforming into {role}"
