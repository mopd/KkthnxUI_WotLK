local K, C, L, _ = unpack(select(2, ...))
if C["actionbar"].enable ~= true then return end

local _G = _G
local gsub = string.gsub

hooksecurefunc("ActionButton_UpdateHotkeys", function(self)
    local hotkey = _G[self:GetName().."HotKey"]
    local text = hotkey:GetText()
	
	hotkey:ClearAllPoints()
	hotkey:SetPoint("TOPRIGHT", 0, K.Scale(-3))
	hotkey:SetFont(C["font"].action_bars_font, C["font"].action_bars_font_size + 1, C["font"].action_bars_font_style)
	hotkey.ClearAllPoints = K.Dummy
	hotkey.SetPoint = K.Dummy
	hotkey:SetShadowOffset(K.mult, -K.mult)

	if not (C["actionbar"].showhotkeys) == true then
		hotkey:SetText("")
		hotkey:Hide()
		hotkey.Show = K.Dummy
	end

    text = gsub(text, "(s%-)", "S-")
    text = gsub(text, "(a%-)", "A-")
    text = gsub(text, "(c%-)", "C-")
    text = gsub(text, "(st%-)", "C-") -- german control "Steuerung"

    for i = 1, 30 do
        text = gsub(text, _G["KEY_BUTTON"..i], "M"..i)
    end

    for i = 1, 9 do
        text = gsub(text, _G["KEY_NUMPAD"..i], "Nu"..i)
    end

    text = gsub(text, KEY_NUMPADDECIMAL, "Nu.")
    text = gsub(text, KEY_NUMPADDIVIDE, "Nu/")
    text = gsub(text, KEY_NUMPADMINUS, "Nu-")
    text = gsub(text, KEY_NUMPADMULTIPLY, "Nu*")
    text = gsub(text, KEY_NUMPADPLUS, "Nu+")

    text = gsub(text, KEY_MOUSEWHEELUP, "MU")
    text = gsub(text, KEY_MOUSEWHEELDOWN, "MD")
    text = gsub(text, KEY_NUMLOCK, "NuL")
    text = gsub(text, KEY_PAGEUP, "PU")
    text = gsub(text, KEY_PAGEDOWN, "PD")
    text = gsub(text, KEY_SPACE, "_")
    text = gsub(text, KEY_INSERT, "Ins")
    text = gsub(text, KEY_HOME, "Hm")
    text = gsub(text, KEY_DELETE, "Del")

    hotkey:SetText(text)
end)