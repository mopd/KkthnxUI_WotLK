local K, C, L, _ = select(2, ...):unpack()
if C["Unitframe"].enable ~= true or IsAddOnLoaded("Quartz") then return end

local unpack = unpack
local format = string.format
local max = math.max
local CreateFrame = CreateFrame
local hooksecurefunc = hooksecurefunc
local UIPARENT_MANAGED_FRAME_POSITIONS = UIPARENT_MANAGED_FRAME_POSITIONS

-- Anchors
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

local CastBars = CreateFrame("Frame", nil, UIParent)

CastBars:RegisterEvent("ADDON_LOADED")
CastBars:RegisterEvent("PLAYER_ENTERING_WORLD")
CastBars:SetScript("OnEvent", function(self, event, addon)
	if addon == "KkthnxUI" or event == "PLAYER_ENTERING_WORLD" then
		if not InCombatLockdown() then
			
			UIPARENT_MANAGED_FRAME_POSITIONS["CastingBarFrame"] = nil
			
			-- Move Cast Bar
			CastingBarFrame:ClearAllPoints()
			CastingBarFrame:SetScale(C["Unitframe"].cbscale)
			CastingBarFrame:SetPoint("CENTER", PlayerCastbarAnchor, "CENTER", 0, -3)
			CastingBarFrame.SetPoint = K.Noop
			
			-- Style CastingBarFrame
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
			CastingBarFrameIcon:SetSize(20, 20)
			CastingBarFrameIcon:ClearAllPoints()
			CastingBarFrameIcon:SetPoint("LEFT", CastingBarFrame, "RIGHT", 8, 0)
			
			-- Target Castbar
			TargetFrameSpellBar:ClearAllPoints()
			TargetFrameSpellBar:SetPoint("CENTER", TargetCastbarAnchor, "CENTER", 0, 0)
			TargetFrameSpellBar:SetScale(C["Unitframe"].cbscale)
			TargetFrameSpellBar.SetPoint = K.Noop
			
			-- Castbar Timer
			CastingBarFrame.timer = CastingBarFrame:CreateFontString(nil)
			CastingBarFrame.timer:SetFont(C["Media"].Font, C["Media"].Font_Size + 2)
			CastingBarFrame.timer:SetShadowOffset(K.Mult, -K.Mult)
			CastingBarFrame.timer:SetPoint("RIGHT", CastingBarFrame, "LEFT", -12, 1)
			CastingBarFrame.updateDelay = 0.1
			
			TargetFrameSpellBar.timer = TargetFrameSpellBar:CreateFontString(nil)
			TargetFrameSpellBar.timer:SetFont(C["Media"].Font, C["Media"].Font_Size)
			TargetFrameSpellBar.timer:SetShadowOffset(K.Mult, -K.Mult)
			TargetFrameSpellBar.timer:SetPoint("LEFT", TargetFrameSpellBar, "RIGHT", 8, 2)
			TargetFrameSpellBar.updateDelay = 0.1
			
			self:UnregisterEvent("ADDON_LOADED")
			self:UnregisterEvent("PLAYER_ENTERING_WORLD")
		end
	end
end)

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