local K, C, L, _ = select(2, ...):unpack()

local CreateFrame = CreateFrame
local IsAddOnLoaded = IsAddOnLoaded

-- Fuck off CLC_DK. Quit hiding shit without peoples permission
if K.Class == "DEATHKNIGHT" then
	local Runebar = CreateFrame("Frame")
	if IsAddOnLoaded("CLC_DK") then
		Runebar:RegisterEvent("ADDON_LOADED")
		Runebar:SetScript("OnEvent",
		function(self, event, addon)
			RuneFrame:Show()
			if (addon == "CLC_DK") then
				self:UnRegisterEvent("ADDON_LOADED")
			end
		end)
	end
end