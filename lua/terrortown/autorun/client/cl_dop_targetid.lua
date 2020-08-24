local function DopMimTargetID(tData)
  if not DOPPELGANGER and MIMIC then return end

  local client = LocalPlayer()
  if client:GetSubRole() ~= ROLE_DOPPELGANGER and client:GetSubRole() ~= ROLE_MIMIC then return end

  local ent = tData:GetEntity()
  if not ent:IsPlayer() or not IsValid(ent) then return end

  if tData:GetEntityDistance() > 100 then return end

  local params = {}

  if GetConVar("ttt2_dop_steal_role"):GetBool() then
    params = {
      usekey = Key("+use", "USE"),
      mode = "steal"
    }
  else
    params = {
      usekey = Key("+use", "USE"),
      mode = "copy"
    }
  end

  local color = Color(255, 255, 255, 255)

  if client:GetSubRole() == ROLE_MIMIC then
    color = MIMIC.ltcolor
  else
    color = DOPPELGANGER.ltcolor
  end

  if tData:GetAmountDescriptionLines() > 0 then
    tData:AddDescriptionLine()
  end

  tData:AddDescriptionLine(
    LANG.GetParamTranslation("ttt2_dop_desc_copy", params),
    color
  )
end

hook.Add("TTTRenderEntityInfo", "TTT2DopMimTargetID", DopMimTargetID)

local function DopMimPopup()
  local targetply = net.ReadEntity()
  local mimicply = net.ReadEntity()
  local steal_mode = net.ReadBool()

  local client = LocalPlayer()
  if mimicply:SteamID() == client:SteamID() then return end

  if steal_mode then
    if client:SteamID() == targetply:SteamID() then
      EPOP:AddMessage({
        text = LANG.TryTranslation("ttt2_dop_stole"),
        color = MIMIC.ltcolor
      },
      LANG.TryTranslation("ttt2_dop_stole_text")
    )
    else
      EPOP:AddMessage({
        text = LANG.TryTranslation("ttt2_dop_stole_all"),
        color = MIMIC.ltcolor
      })
    end
  else
    if client:SteamID() == targetply:SteamID() then
      EPOP:AddMessage({
        text = LANG.TryTranslation("ttt2_dop_clone"),
        color = MIMIC.ltcolor
      })
    else
      EPOP:AddMessage({
        text = LANG.TryTranslation("ttt2_dop_clone_all"),
        color = MIMIC.ltcolor
      })
    end
  end
end

net.Receive("ttt2_dop_popup", DopMimPopup)
