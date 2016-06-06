local K, C, L, _ = select(2, ...):unpack()
if C["actionbar"].enable ~= true then return end

-- By Tukz
local _G = _G
local match = string.match
local gsub = string.gsub
local ipairs = ipairs
local tostring = tostring
local hooksecurefunc = hooksecurefunc

local function StyleNormalButton(self)
	local name = self:GetName()
	if name:match("MultiCast") or name:match("ExtraActionButton") then return end
	local button = self
	local icon = _G[name.."Icon"]
	local count = _G[name.."Count"]
	local flash = _G[name.."Flash"]
	local hotkey = _G[name.."HotKey"]
	local border = _G[name.."Border"]
	local btname = _G[name.."Name"]
	local normal = _G[name.."NormalTexture"]
	local float = _G[name.."FloatingBG"]

	flash:SetTexture("")
	button:SetNormalTexture("")

	if float then
		float:Hide()
		float = K.Dummy
	end

	if border then
		border:Hide()
		border = K.Dummy
	end

	count:ClearAllPoints()
	count:SetPoint("BOTTOMRIGHT", 0, 2)
	count:SetFont(C["font"].action_bars_font, C["font"].action_bars_font_size, C["font"].action_bars_font_style)
	count:SetShadowOffset(K.mult, -K.mult)

	if btname then
		if C["actionbar"].macro == true then
			btname:ClearAllPoints()
			btname:SetPoint("BOTTOM", 0, 3)
			btname:SetFont(C["font"].action_bars_font, C["font"].action_bars_font_size - 1, C["font"].action_bars_font_style)
			btname:SetShadowOffset(K.mult, -K.mult)
			--btname:SetWidth(C["actionbar"].button_size - 1)
			btname:SetVertexColor(1, 0.82, 0, 1)
		else
			btname:Kill()
		end
	end

	if C["actionbar"].hotkey == true then
		hotkey:ClearAllPoints()
		hotkey:SetPoint("TOPRIGHT", 0, -2)
		hotkey:SetFont(C["font"].action_bars_font, C["font"].action_bars_font_size, C["font"].action_bars_font_style)
		hotkey:SetShadowOffset(K.mult, -K.mult)
		hotkey:SetWidth(C["actionbar"].button_size - 1)
		hotkey.ClearAllPoints = K.Dummy
		hotkey.SetPoint = K.Dummy
	else
		hotkey:Kill()
	end

	if not _G[name.."Panel"] then
		if self:GetHeight() ~= C["actionbar"].button_size and not InCombatLockdown() then
			self:SetSize(C["actionbar"].button_size, C["actionbar"].button_size)
		end

		local panel = CreateFrame("Frame", name.."Panel", self)
		panel:CreatePanel("Transparent", C["actionbar"].button_size, C["actionbar"].button_size, "CENTER", self, "CENTER", 0, 0)
		panel:SetFrameStrata(self:GetFrameStrata())
		panel:SetFrameLevel(self:GetFrameLevel() - 1)

		icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		icon:SetPoint("TOPLEFT", button, 2, -2)
		icon:SetPoint("BOTTOMRIGHT", button, -2, 2)
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
	button.SetNormalTexture = K.Dummy

	flash:SetTexture(0.8, 0.8, 0.8, 0.5)
	flash:SetPoint("TOPLEFT", button, 2, -2)
	flash:SetPoint("BOTTOMRIGHT", button, -2, 2)

	if not _G[name.."Panel"] then
		button:SetWidth(C["actionbar"].button_size)
		button:SetHeight(C["actionbar"].button_size)

		local panel = CreateFrame("Frame", name.."Panel", button)
		panel:CreatePanel("Transparent", C["actionbar"].button_size, C["actionbar"].button_size, "CENTER", button, "CENTER", 0, 0)
		panel:SetFrameStrata(button:GetFrameStrata())
		panel:SetFrameLevel(button:GetFrameLevel() - 1)

		icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		icon:ClearAllPoints()
		icon:SetPoint("TOPLEFT", button, 2, -2)
		icon:SetPoint("BOTTOMRIGHT", button, -2, 2)

		if pet then
			local autocast = _G[name.."AutoCastable"]
			autocast:SetWidth((C["actionbar"].button_size * 2) - 10)
			autocast:SetHeight((C["actionbar"].button_size * 2) - 10)
			autocast:ClearAllPoints()
			autocast:SetPoint("CENTER", button, 0, 0)

			local shine = _G[name.."Shine"]
			shine:SetWidth(C["actionbar"].button_size)
			shine:SetHeight(C["actionbar"].button_size)

			local cooldown = _G[name.."Cooldown"]
			cooldown:SetWidth(C["actionbar"].button_size - 2)
			cooldown:SetHeight(C["actionbar"].button_size - 2)
		end
	end

	if normal then
		normal:ClearAllPoints()
		normal:SetPoint("TOPLEFT")
		normal:SetPoint("BOTTOMRIGHT")
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

local function UpdateHotkey(self, actionButtonType)
	local hotkey = _G[self:GetName().."HotKey"]
	local text = hotkey:GetText()

	text = gsub(text, "(s%-)", "S")
	text = gsub(text, "(a%-)", "A")
	text = gsub(text, "(а%-)", "A") -- fix ruRU
	text = gsub(text, "(c%-)", "C")
	text = gsub(text, "(Mouse Button )", "M")
	text = gsub(text, "(Кнопка мыши )", "M")
	text = gsub(text, KEY_BUTTON3, "M3")
	text = gsub(text, KEY_PAGEUP, "PU")
	text = gsub(text, KEY_PAGEDOWN, "PD")
	text = gsub(text, KEY_SPACE, "SpB")
	text = gsub(text, KEY_INSERT, "Ins")
	text = gsub(text, KEY_HOME, "Hm")
	text = gsub(text, KEY_DELETE, "Del")
	text = gsub(text, KEY_NUMPADDECIMAL, "Nu.")
	text = gsub(text, KEY_NUMPADDIVIDE, "Nu/")
	text = gsub(text, KEY_NUMPADMINUS, "Nu-")
	text = gsub(text, KEY_NUMPADMULTIPLY, "Nu*")
	text = gsub(text, KEY_NUMPADPLUS, "Nu+")
	text = gsub(text, KEY_NUMLOCK, "NuL")
	text = gsub(text, KEY_MOUSEWHEELDOWN, "MWD")
	text = gsub(text, KEY_MOUSEWHEELUP, "MWU")

	if hotkey:GetText() == _G["RANGE_INDICATOR"] then
		hotkey:SetText("")
	else
		hotkey:SetText(text)
	end
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
		cooldown:SetPoint("TOPLEFT", button, "TOPLEFT", 2, -2)
		cooldown:SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", -2, 2)
	end
end

do
	for i = 1, 12 do
		_G["ActionButton"..i]:StyleButton(true)
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
if C["actionbar"].hotkey == true then
	hooksecurefunc("ActionButton_UpdateHotkeys", UpdateHotkey)
end