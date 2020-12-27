local base = "pure_skin_element"

DEFINE_BASECLASS(base)

HUDELEMENT.Base = base


if CLIENT then
  local pad = 7
  local iconSize = 64

  local const_defaults = {
    basepos = {x = 0, y = 0},
    size = {w = 365, h = 32},
    minsize = {w = 225, h = 32}
  }

  function HUDELEMENT:PreInitialize()
    BaseClass.PreInitialize(self)

    local hud = huds.GetStored("pure_skin")
    if not hud then return end

    hud:ForceElement(self.id)
  end

  function HUDELEMENT:Initialize()
    self.scale = 1.0
    self.basecolor = self:GetHUDBasecolor()
    self.pad = pad
    self.iconSize = iconSize

    BaseClass.Initialize(self)
  end

  -- parameter overwrites
  function HUDELEMENT:IsResizable()
    return true, false
  end

  function HUDELEMENT:GetDefaults()
    const_defaults["basepos"] = {
      x = 10 * self.scale,
      y = ScrH() - self.size.h - 146 * self.scale - self.pad - 10 * self.scale
    }
    return const_defaults
  end

  function HUDELEMENT:PerformLayout()
    self.scale = self:GetHUDScale()
    self.basecolor = self:GetHUDBasecolor()
    self.iconSize = iconSize * self.scale
    self.pad = pad * self.scale

    BaseClass.PerformLayout(self)
  end

  function HUDELEMENT:DrawComponent(multiplier, col, text)
    multiplier = multiplier or 1

    local pos = self:GetPos()
    local size = self:GetSize()
    local x, y = pos.x, pos.y
    local w, h = size.w, size.h

    self:DrawBg(x, y, w, h, self.basecolor)

    self:DrawBar(x + pad, y + pad, w - pad * 2, h - pad * 2, col, multiplier, scale, text)

    self:DrawLines(x, y, w, h, self.basecolor.a)
  end

  function HUDELEMENT:ShouldDraw()
    local client = LocalPlayer()

    return IsValid(client)
  end

  function HUDELEMENT:Draw()
    local client = LocalPlayer()
    local multiplier

    local color = MIMIC.color
    if not color then return end

    if not client:IsActive() or not client:Alive() or client:GetBaseRole() ~= ROLE_MIMIC then return end
    local start_time = client:GetNWFloat("ttt2_mim_trans_time", 0)
    local raw_rolestring = client:GetNWString("ttt2_mim_trans_rolestring")
    local rolestring = LANG.TryTranslation(raw_rolestring)
    local delay = GetConVar("ttt2_dop_steal_delay"):GetInt()
    if start_time + delay  > CurTime() then
      multiplier = (CurTime() - start_time) / delay

      local secondColor = MIMIC.bgcolor
      local r = color.r - (color.r - secondColor.r) * multiplier
      local g = color.g - (color.g - secondColor.g) * multiplier
      local b = color.b - (color.b - secondColor.b) * multiplier

      color = Color(r, g, b, 255)
    else
      multiplier = 0
    end

    if HUDEditor.IsEditing then
      self:DrawComponent(1, color)
    elseif multiplier and multiplier > 0 then
      self:DrawComponent(multiplier, color, LANG.GetParamTranslation("ttt2_mim_transform", {role = rolestring}) or nil)
    end
  end
end
