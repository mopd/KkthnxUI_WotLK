local K, C, L, _ = select(2, ...):unpack()
if C["ActionBar"].Enable ~= true then return end

-- By Tukz
local _G = _G
local match = string.match
local gsub = string.gsub
local ipairs = ipairs
local tostring = tostring
local hooksecurefunc = hooksecurefunc

local function StyleNormalButton(self)
	local name = self:GetName()
	if name:match("MultiCast") then return end
	local button = self
	local icon = _G[name.."Icon"]
	local count = _G[name.."Count"]
	local flash = _G[name.."Flash"]
	local hotkey = _G[name.."HotKey"]
	local border = _G[name.."Border"]
	local macroName = _G[name.."Name"]
	local normal = _G[name.."NormalTexture"]
	local float = _G[name.."FloatingBG"]

	flash:SetTexture("")
	button:SetNormalTexture("")

	if float then
		float:Kill()
	end

	if border then
		border:SetTexture("Interface\\Buttons\\UI-ActionButton-Border")
		border:SetBlendMode("ADD")
		border:SetAlpha(0.8)
		border:SetSize(68, 68)
		border:SetPoint("CENTER", button)
	end

	count:ClearAllPoints()
	count:SetPoint("BOTTOMRIGHT", 0, 2)
	count:SetFont(C["Media"].Font, C["Media"].Font_Size, C["Media"].Font_Style)

	if macroName then
		if C["ActionBar"].Macro == true then
			macroName:SetFont(C["Media"].Font, C["Media"].Font_Size, C["Media"].Font_Style)
			macroName:ClearAllPoints()
			macroName:SetPoint("BOTTOM", 1, 1)
			macroName:SetVertexColor(1, 0.82, 0, 1)
		else
			macroName:SetText("")
			macroName:Kill()
		end
	end

	if hotkey then
		if C["ActionBar"].Hotkey == true then
			hotkey:SetFont(C["Media"].Font, C["Media"].Font_Size, C["Media"].Font_Style)
		else
			hotkey:SetText("")
			hotkey:Kill()
		end
	end

	if not button.isSkinned then
		if self:GetHeight() ~= C["ActionBar"].Button_Size and not InCombatLockdown() then
			self:SetSize(C["ActionBar"].Button_Size, C["ActionBar"].Button_Size)
		end
		button:CreateBackdrop()
		button.backdrop:SetOutside()

		icon:SetTexCoord(unpack(K.TexCoords))
		icon:SetInside()
		icon:SetDrawLayer("BORDER", 7) -- ??

		button.isSkinned = true
	end

	if not button.shadow then
		button:CreateBlizzShadow(5)
	end

	if normal then
		normal:ClearAllPoints()
		normal:SetPoint("TOPLEFT")
		normal:SetPoint("BOTTOMRIGHT")
	end
end

local function StyleSmallButton(normal, button, icon, name, pet)
	local flash = _G[name.."Flash"]
	button:SetNormalTexture("")
	button.SetNormalTexture = K.Noop

	flash:SetTexture(204/255, 204/255, 204/255, 0.5)
	flash:SetInside()

	if not button.isSkinned then
		button:SetSize(C["ActionBar"].Button_Size, C["ActionBar"].Button_Size)
		button:CreateBackdrop()
		button.backdrop:SetOutside()

		icon:SetTexCoord(unpack(K.TexCoords))
		icon:SetInside()
		icon:SetDrawLayer("BORDER", 7)

		if pet then
			local autocast = _G[name.."AutoCastable"]
			autocast:SetSize((C["ActionBar"].Button_Size * 2) - 10, (C["ActionBar"].Button_Size * 2) - 10)
			autocast:ClearAllPoints()
			autocast:SetPoint("CENTER", button, 0, 0)

			local shine = _G[name.."Shine"]
			shine:SetSize(C["ActionBar"].Button_Size, C["ActionBar"].Button_Size)

			local cooldown = _G[name.."Cooldown"]
			cooldown:SetSize(C["ActionBar"].Button_Size - 2, C["ActionBar"].Button_Size - 2)
		end

		button.isSkinned = true
	end

	if not button.shadow then
		button:CreateBlizzShadow(5)
	end

	if normal then
		normal:ClearAllPoints()
		normal:SetOutside()
	end
end

function K.StyleShift()
	for i = 1, NUM_SHAPESHIFT_SLOTS do
		local name = "ShapeshiftButton"..i
		local button = _G[name]
		local icon = _G[name.."Icon"]
		local normal = _G[name.."NormalTexture"]
		StyleSmallButton(normal, button, icon, name)
	end
end

function K.StylePet()
	for i = 1, NUM_PET_ACTION_SLOTS do
		local name = "PetActionButton"..i
		local button = _G[name]
		local icon = _G[name.."Icon"]
		local normal = _G[name.."NormalTexture2"]
		StyleSmallButton(normal, button, icon, name, true)
	end
end

local function UpdateHotkey(button, type)
	local hotkey = _G[button:GetName().."HotKey"]
	local text = hotkey:GetText()

	if text then
		text = gsub(text, "(Mouse Button )", "M")
		text = gsub(text, "(a%-)", "A")
		text = gsub(text, "(c%-)", "C")
		text = gsub(text, "(s%-)", "S")
		text = gsub(text, "(а%-)", "A") -- fix ruRU
		text = gsub(text, "ALT%-", L_ACTIONBAR_KEY_ALT)
		text = gsub(text, "BUTTON", L_ACTIONBAR_KEY_MOUSEBUTTON)
		text = gsub(text, "CTRL%-", L_ACTIONBAR_KEY_CTRL)
		text = gsub(text, "DELETE", L_ACTIONBAR_KEY_DELETE)
		text = gsub(text, "HOME", L_ACTIONBAR_KEY_HOME)
		text = gsub(text, "INSERT", L_ACTIONBAR_KEY_INSERT)
		text = gsub(text, "MOUSEWHEELDOWN", L_ACTIONBAR_KEY_MOUSEWHEELDOWN)
		text = gsub(text, "MOUSEWHEELUP", L_ACTIONBAR_KEY_MOUSEWHEELUP)
		text = gsub(text, "NMINUS", "N-")
		text = gsub(text, "NMULTIPLY", "*")
		text = gsub(text, "NPLUS", "N+")
		text = gsub(text, "NUMPAD", L_ACTIONBAR_KEY_NUMPAD)
		text = gsub(text, "PAGEDOWN", L_ACTIONBAR_KEY_PAGEDOWN)
		text = gsub(text, "PAGEUP", L_ACTIONBAR_KEY_PAGEUP)
		text = gsub(text, "SHIFT%-", L_ACTIONBAR_KEY_SHIFT)
		text = gsub(text, "SPACE", L_ACTIONBAR_KEY_SPACE)
		text = gsub(text, KEY_BUTTON3, "M3")

		if hotkey:GetText() == _G["RANGE_INDICATOR"] then
			hotkey:SetText("")
		else
			hotkey:SetText(text)
		end
	end

	if C["ActionBar"].Hotkey == true then
		hotkey:Show()
	else
		hotkey:SetText("")
		hotkey:Kill()
	end

	hotkey:ClearAllPoints()
	hotkey:SetPoint("TOPRIGHT", 0, -3)
end

-- Rescale cooldown spiral to fix texture
local buttonNames = {
	"ActionButton",
	"MultiBarBottomLeftButton",
	"MultiBarBottomRightButton",
	"MultiBarLeftButton",
	"MultiBarRightButton",
	"ShapeshiftButton",
	"PetActionButton",
	"MultiCastActionButton"
}
for _, name in ipairs(buttonNames) do
	for index = 1, 12 do
		local buttonName = name..tostring(index)
		local button = _G[buttonName]
		local cooldown = _G[buttonName.."Cooldown"]

		if (button == nil or cooldown == nil) then
			break
		end

		cooldown:ClearAllPoints()
		cooldown:SetInside()
	end
end

do
	for i = 1, 12 do
		_G["ActionButton"..i]:StyleButton(true)
		_G["BonusActionButton"..i]:StyleButton(true)
		_G["MultiBarBottomLeftButton"..i]:StyleButton(true)
		_G["MultiBarBottomRightButton"..i]:StyleButton(true)
		_G["MultiBarLeftButton"..i]:StyleButton(true)
		_G["MultiBarRightButton"..i]:StyleButton(true)
	end

	for i = 1, 10 do
		_G["ShapeshiftButton"..i]:StyleButton(true)
		_G["PetActionButton"..i]:StyleButton(true)
	end
end

hooksecurefunc("ActionButton_Update", StyleNormalButton)
if C["ActionBar"].Hotkey == true then
	hooksecurefunc("ActionButton_UpdateHotkeys", UpdateHotkey)
end