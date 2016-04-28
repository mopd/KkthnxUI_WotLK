local K, C, L, _ = unpack(select(2, ...))
if C["actionbar"].enable ~= true then return end

-- Based on tullaRange

-- Locals and speed
local _G = _G
local UPDATE_DELAY = 0.1
local ATTACK_BUTTON_FLASH_TIME = ATTACK_BUTTON_FLASH_TIME

local ActionButton_GetPagedID = ActionButton_GetPagedID
local ActionButton_IsFlashing = ActionButton_IsFlashing
local ActionHasRange = ActionHasRange
local IsActionInRange = IsActionInRange
local IsUsableAction = IsUsableAction
local HasAction = HasAction

-- Main thing
local ActionBarRange = CreateFrame("Frame", "ActionBarRange", UIParent)
ActionBarRange:Hide()

function ActionBarRange:Load()
	self:SetScript("OnUpdate", self.OnUpdate)
	self:SetScript("OnHide", self.OnHide)
	self:SetScript("OnEvent", self.OnEvent)
	self.elapsed = 0
	
	self:RegisterEvent("PLAYER_LOGIN")
end

-- Frame Events
function ActionBarRange:OnEvent(event, ...)
	local action = self[event]
	if action then
		action(self, event, ...)
	end
end

function ActionBarRange:OnUpdate(elapsed)
	if self.elapsed < UPDATE_DELAY then
		self.elapsed = self.elapsed + elapsed
	else
		self:Update()
	end
end

function ActionBarRange:OnHide()
	self.elapsed = 0
end

-- Game Events
function ActionBarRange:PLAYER_LOGIN()
	if not ACTIONBAR_RANGE_COLORS then
		self:LoadDefaults()
	end
	self.colors = ACTIONBAR_RANGE_COLORS
	
	-- Add options loader
	local f = CreateFrame("Frame", nil, InterfaceOptionsFrame)
	f:SetScript("OnShow", function(self)
		self:SetScript("OnShow", nil)
		LoadAddOn("tullaRange_Config")
	end)
	
	self.buttonsToUpdate = {}
	
	hooksecurefunc("ActionButton_OnUpdate", self.RegisterButton)
	hooksecurefunc("ActionButton_UpdateUsable", self.OnUpdateButtonUsable)
	hooksecurefunc("ActionButton_Update", self.OnButtonUpdate)
end

-- Actions
function ActionBarRange:Update()
	self:UpdateButtons(self.elapsed)
	self.elapsed = 0
end

function ActionBarRange:ForceColorUpdate()
	for button in pairs(self.buttonsToUpdate) do
		ActionBarRange.OnUpdateButtonUsable(button)
	end
end

function ActionBarRange:UpdateShown()
	if next(self.buttonsToUpdate) then
		self:Show()
	else
		self:Hide()
	end
end

function ActionBarRange:UpdateButtons(elapsed)
	if not next(self.buttonsToUpdate) then
		self:Hide()
		return
	end
	
	for button in pairs(self.buttonsToUpdate) do
		self:UpdateButton(button, elapsed)
	end
end

function ActionBarRange:UpdateButton(button, elapsed)
	ActionBarRange.UpdateButtonUsable(button)
	ActionBarRange.UpdateFlash(button, elapsed)
end

function ActionBarRange:UpdateButtonStatus(button)
	local action = ActionButton_GetPagedID(button)
	if not(button:IsVisible() and action and HasAction(action) and ActionHasRange(action)) then
		self.buttonsToUpdate[button] = nil
	else
		self.buttonsToUpdate[button] = true
	end
	self:UpdateShown()
end

-- Button Hooking
function ActionBarRange.RegisterButton(button)
	button:HookScript("OnShow", ActionBarRange.OnButtonShow)
	button:HookScript("OnHide", ActionBarRange.OnButtonHide)
	button:SetScript("OnUpdate", nil)
	
	ActionBarRange:UpdateButtonStatus(button)
end

function ActionBarRange.OnButtonShow(button)
	ActionBarRange:UpdateButtonStatus(button)
end

function ActionBarRange.OnButtonHide(button)
	ActionBarRange:UpdateButtonStatus(button)
end

function ActionBarRange.OnUpdateButtonUsable(button)
	button.ActionBarRangeColor = nil
	ActionBarRange.UpdateButtonUsable(button)
end

function ActionBarRange.OnButtonUpdate(button)
	ActionBarRange:UpdateButtonStatus(button)
end

-- Range Coloring
function ActionBarRange.UpdateButtonUsable(button)
	local action = ActionButton_GetPagedID(button)
	local isUsable, notEnoughMana = IsUsableAction(action)
	
	-- Usable
	if isUsable then
		-- Out of range
		if IsActionInRange(action) == 0 then
			ActionBarRange.SetButtonColor(button, "oor")
			-- In range
		else
			ActionBarRange.SetButtonColor(button, "normal")
		end
		-- Out of mana
	elseif notEnoughMana then
		ActionBarRange.SetButtonColor(button, "oom")
		-- Unusable
	else
		button.ActionBarRangeColor = "unusuable"
	end
end

function ActionBarRange.SetButtonColor(button, colorType)
	if button.ActionBarRangeColor ~= colorType then
		button.ActionBarRangeColor = colorType
		
		local r, g, b = ActionBarRange:GetColor(colorType)
		
		local icon = _G[button:GetName() .. "Icon"]
		icon:SetVertexColor(r, g, b)
		
		local nt = button:GetNormalTexture()
		nt:SetVertexColor(r, g, b)
	end
end

function ActionBarRange.UpdateFlash(button, elapsed)
	if ActionButton_IsFlashing(button) then
		local flashtime = button.flashtime - elapsed
		
		if flashtime <= 0 then
			local overtime = -flashtime
			if overtime >= ATTACK_BUTTON_FLASH_TIME then
				overtime = 0
			end
			flashtime = ATTACK_BUTTON_FLASH_TIME - overtime
			
			local flashTexture = _G[button:GetName() .. "Flash"]
			if flashTexture:IsShown() then
				flashTexture:Hide()
			else
				flashTexture:Show()
			end
		end
		
		button.flashtime = flashtime
	end
end

-- Configuration
function ActionBarRange:LoadDefaults()
	ACTIONBAR_RANGE_COLORS = {
		normal = {1, 1, 1},
		oor = C["actionbar"].out_of_range,
		oom = C["actionbar"].out_of_mana,
	}
end

function ActionBarRange:Reset()
	self:LoadDefaults()
	self.colors = ACTIONBAR_RANGE_COLORS
	
	self:ForceColorUpdate()
end

function ActionBarRange:SetColor(index, r, g, b)
	local color = self.colors[index]
	color[1] = r
	color[2] = g
	color[3] = b
	
	self:ForceColorUpdate()
end

function ActionBarRange:GetColor(index)
	local color = self.colors[index]
	return color[1], color[2], color[3]
end

-- Load The Thing
ActionBarRange:Load()