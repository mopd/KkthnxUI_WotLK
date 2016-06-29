local K, C, L, _ = select(2, ...):unpack()
if C["Unitframe"].enable ~= true or IsAddOnLoaded("Quartz") then return end

local unpack = unpack
local format = string.format
local max = math.max
local CreateFrame = CreateFrame
local hooksecurefunc = hooksecurefunc
local InCombatLockdown = InCombatLockdown

local CastBars = CreateFrame("Frame", nil, UIParent)

local PlayerCastbarAnchor = CreateFrame("Frame", "PlayerCastbarAnchor", UIParent)
if not InCombatLockdown() then
	PlayerCastbarAnchor:SetSize(CastingBarFrame:GetWidth() * C["Unitframe"].cbscale, CastingBarFrame:GetHeight() * 2)
	PlayerCastbarAnchor:SetPoint(unpack(C["position"].unitframes.player_castbar))
end

local TargetCastbarAnchor = CreateFrame("Frame", "TargetCastbarAnchor", UIParent)
if not InCombatLockdown() then
	TargetCastbarAnchor:SetSize(TargetFrameSpellBar:GetWidth() * C["Unitframe"].cbscale, TargetFrameSpellBar:GetHeight() * 2)
	TargetCastbarAnchor:SetPoint(unpack(C["position"].unitframes.target_castbar))
end

-- Helper function for moving a Blizzard frame that has a SetMoveable flag
local function ModifyFrame(frame, anchor, parent, posX, posY, scale)
	frame:SetMovable(true)
	frame:ClearAllPoints()
	if(parent == nil) then frame:SetPoint(anchor, posX, posY) else frame:SetPoint(anchor, parent, posX, posY) end
	if(scale ~= nil) then frame:SetScale(scale) end
	frame:SetUserPlaced(true)
	frame:SetMovable(false)
end

-- Helper function for moving a Blizzard frame that does NOT have a SetMoveable flag
local function ModifyBasicFrame(frame, anchor, parent, posX, posY, scale)
	frame:ClearAllPoints()
	if(parent == nil) then frame:SetPoint(anchor, posX, posY) else frame:SetPoint(anchor, parent, posX, posY) end
	if(scale ~= nil) then frame:SetScale(scale) end
end

-- Does the bulk of the tweaking to the castbars
local function AdjustCastBars()
	if not InCombatLockdown() then
		-- Player CastBar
		ModifyFrame(CastingBarFrame, "CENTER", PlayerCastbarAnchor, 0, -3, C["Unitframe"].cbscale)
		CastingBarFrame.timer = CastingBarFrame:CreateFontString(nil)
		CastingBarFrame.timer:SetFont(C["Media"].Font, C["Media"].Font_Size + 2)
		CastingBarFrame.timer:SetShadowOffset((K.Mult or 1), -(K.Mult or 1))
		CastingBarFrame.timer:SetPoint("RIGHT", CastingBarFrame, "LEFT", -12, 1)
		CastingBarFrame.updateDelay = 0.1

		-- Style it.
		CastingBarFrameBorder:SetTexture("Interface\\CastingBar\\UI-CastingBar-Border-Small")
		CastingBarFrameFlash:SetTexture("Interface\\CastingBar\\UI-CastingBar-Flash-Small")

		CastingBarFrameText:ClearAllPoints()
		CastingBarFrameText:SetPoint("CENTER", 0, 1)

		CastingBarFrameBorder:SetWidth(CastingBarFrameBorder:GetWidth() + 4)
		CastingBarFrameFlash:SetWidth(CastingBarFrameFlash:GetWidth() + 4)
		CastingBarFrameBorderShield:SetWidth(CastingBarFrameBorderShield:GetWidth() + 4)
		CastingBarFrameBorder:SetPoint("TOP", 0, 26)
		CastingBarFrameFlash:SetPoint("TOP", 0, 26)
		CastingBarFrameBorderShield:SetPoint("TOP", 0, 26)

		-- CastingBarFrame Icon
		CastingBarFrameIcon:Show()
		ModifyBasicFrame(CastingBarFrameIcon, "RIGHT", CastingBarFrame, 28, 0) --??
		CastingBarFrameIcon:SetSize(20, 20)

		-- Target CastBar
		ModifyBasicFrame(TargetFrameSpellBar, "CENTER", TargetCastbarAnchor, 0, 0, C["Unitframe"].cbscale)
		TargetFrameSpellBar.SetPoint = K.Noop -- Seems we still need this. :(
		TargetFrameSpellBar.timer = TargetFrameSpellBar:CreateFontString(nil)
		TargetFrameSpellBar.timer:SetFont(C["Media"].Font, C["Media"].Font_Size)
		TargetFrameSpellBar.timer:SetShadowOffset((K.Mult or 1), -(K.Mult or 1))
		TargetFrameSpellBar.timer:SetPoint("LEFT", TargetFrameSpellBar, "RIGHT", 8, 2)
		TargetFrameSpellBar.updateDelay = 0.1
	end
end

local function HandleEvents(self, event, ...)
	if(event == "PLAYER_ENTERING_WORLD") then
		AdjustCastBars()
	end

	if(event == "UNIT_EXITED_VEHICLE") then
		if(... == "player") then
			AdjustCastBars()
		end
	end
end

-- Sets up Event Handlers etc
local function Init()
	CastBars:SetScript("OnEvent", HandleEvents)

	-- Register all Events
	CastBars:RegisterEvent("PLAYER_ENTERING_WORLD")
	CastBars:RegisterEvent("UNIT_EXITED_VEHICLE")
end

-- Displays the Casting Bar timer
local function CastingBarFrame_OnUpdate_Hook(self, elapsed)
	if(not self.timer) then
		return
	end
	if(self.updateDelay) and (self.updateDelay < elapsed) then
		if(self.casting) then
			self.timer:SetText(format("%2.1f / %1.1f", max(self.maxValue - self.value, 0), self.maxValue))
		elseif(self.channeling) then
			self.timer:SetText(format("%.1f", max(self.value, 0)))
		else
			self.timer:SetText("")
		end
		self.updateDelay = 0.1
	else
		self.updateDelay = self.updateDelay - elapsed
	end
end

-- Add a function to be called after execution of a secure function. Allows one to "post-hook" a secure function without tainting the original.
hooksecurefunc("CastingBarFrame_OnUpdate", CastingBarFrame_OnUpdate_Hook)

-- End of file, call Init
Init()