local K, C, L = unpack(select(2, ...))

if (C["general"].auto_scale) then
	C["general"].uiscale = min(2, max(0.32, 768 / string.match(K.Resolution, "%d+x(%d+)")))
end

-- Optimize Video after we enter world
local Video = CreateFrame("Frame")
Video:RegisterEvent("PLAYER_ENTERING_WORLD")
Video:SetScript("OnEvent", function(self, event)
	local UseUIScale = GetCVar("useUiScale")
	
	if (UseUIScale ~= "1") then
		SetCVar("useUiScale", 1)
	end
	
	if (format("%.2f", GetCVar("uiScale")) ~= format("%.2f", C["general"].uiscale)) then
		SetCVar("uiscale", C["general"].uiscale)
	end
	
	-- Allow 4K and WQHD Resolution to have an UIScale lower than 0.64, which is 
	-- the lowest value of UIParent scale by default
	if (C["general"].uiscale < 0.64) then
		UIParent:SetScale(C["general"].uiscale)
	end
	
	self:UnregisterEvent("PLAYER_ENTERING_WORLD")
end)

local mult = 768 / string.match(GetCVar("gxResolution"), "%d+x(%d+)") / C["general"].uiscale
local Scale = function(x) return mult * math.floor(x / mult + 0.5) end			

K.Scale = function(x) return K.mult * math.floor(x / K.mult+.5) end
K.mult = mult
K.noscalemult = K.mult * C["general"].uiscale