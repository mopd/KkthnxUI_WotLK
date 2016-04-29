local K, C, L, _ = unpack(select(2, ...))

local unpack = unpack
local select = select
local floor = math.floor
local collectgarbage = collectgarbage
local print = print

local GetNumAddOns, GetAddOnInfo, GetAddOnMemoryUsage = GetNumAddOns, GetAddOnInfo, GetAddOnMemoryUsage
local CreateFrame = CreateFrame
local IsAddOnLoaded = IsAddOnLoaded
local GetFramerate = GetFramerate

local Stat = CreateFrame("Frame")
Stat:RegisterEvent("PLAYER_ENTERING_WORLD")
Stat:SetFrameStrata("BACKGROUND")
Stat:SetFrameLevel(3)
Stat:EnableMouse(true)
Stat.tooltip = false

local Text = Minimap:CreateFontString(nil, "OVERLAY")
Text:SetFont(C["font"].stats_font, C["font"].stats_font_size, C["font"].stats_font_style)
Text:SetPoint(unpack(C["position"].statsframe));

-- Format Memory
local kiloByteString = "%d kb"
local megaByteString = "%.2f mb"
local function formatMem(memory)
	local mult = 10^1
	if memory > 999 then
		local mem = ((memory / 1024) * mult) / mult
		return string.format(megaByteString, mem)
	else
		local mem = (memory * mult) / mult
		return string.format(kiloByteString, mem)
	end
end

-- Build Memorytable
local memoryTable = {}
local function RebuildAddonList(self)
	local addOnCount = GetNumAddOns()
	if (addOnCount == #memoryTable) or self.tooltip == true then return end

	memoryTable = {}
	for i = 1, addOnCount do memoryTable[i] = {i, select(2, GetAddOnInfo(i)), 0, IsAddOnLoaded(i)} end
	self:SetAllPoints(Text)
end

-- Update Memorytable
local function UpdateMemory()
	UpdateAddOnMemoryUsage()
	local addOnMem = 0
	local totalMemory = 0
	for i = 1, #memoryTable do
		addOnMem = GetAddOnMemoryUsage(memoryTable[i][1])
		memoryTable[i][3] = addOnMem
		totalMemory = totalMemory + addOnMem
	end
	table.sort(memoryTable, function(a, b)
		if a and b then return a[3] > b[3] end
	end)
	return totalMemory
end

-- Build DataText
local int, int2 = 10, 2
local function Update(self, t)
	int = int - t
	int2 = int2 - t
	if int < 0 then
		RebuildAddonList(self)
		int = 10
	end
	if int2 < 0 then
		Text:SetText(floor(GetFramerate())..K.RGBToHex(K.Color.r, K.Color.g, K.Color.b).." fps|r & "..select(3, GetNetStats())..K.RGBToHex(K.Color.r, K.Color.g, K.Color.b).." ms|r")
		int2 = 2
	end
end

-- Setup Tooltip
Stat:SetScript("OnEnter", function(self)
	self.tooltip = true
	local anchor, panel, xoff, yoff = "ANCHOR_BOTTOMLEFT", self:GetParent(), 0, K.Scale(5)
	local bw_in, bw_out, latencyHome = GetNetStats()
	ms_combined = latencyHome
	GameTooltip:SetOwner(self, anchor, xoff, yoff)
	GameTooltip:ClearLines()
	local totalMemory = UpdateMemory()
	GameTooltip:AddDoubleLine(L_TOTALMEMORY_USAGE, formatMem(totalMemory))
	GameTooltip:AddLine(" ")
	for i = 1, #memoryTable do
		if (memoryTable[i][4]) then
			local red = memoryTable[i][3] / totalMemory
			local green = 1 - red
			GameTooltip:AddDoubleLine(memoryTable[i][2], formatMem(memoryTable[i][3]))
		end
	end
	GameTooltip:AddLine(" ")
	GameTooltip:AddDoubleLine(L_STATS_HOME, latencyHome.." "..MILLISECONDS_ABBR)
	GameTooltip:AddDoubleLine(L_STATS_GLOBAL, ms_combined.." "..MILLISECONDS_ABBR)
	GameTooltip:AddLine(" ")
	GameTooltip:AddDoubleLine(L_STATS_INC, string.format( "%.4f", bw_in ) .. " kb/s")
	GameTooltip:AddDoubleLine(L_STATS_OUT, string.format( "%.4f", bw_out ) .. " kb/s")

	GameTooltip:AddLine(" ")
	GameTooltip:AddLine(L_STATS_SYSTEMLEFT)
	GameTooltip:AddLine(L_STATS_SYSTEMRIGHT)
	GameTooltip:Show()
end)

-- Button Functionality
Stat:SetScript("OnMouseDown", function(self, btn)
	if (btn == "LeftButton") then
		if not LFDQueueFrame then ToggleFrame(LFDParentFrame) end
		ToggleFrame(LFDParentFrame)
	else
		UpdateAddOnMemoryUsage()
		local Before = gcinfo()
		collectgarbage("collect")
		UpdateAddOnMemoryUsage()
		local After = gcinfo()
		print("|cff3AA0E9Memory Cleaned:|r "..formatMem(Before-After))
	end
end)
Stat:SetScript("OnLeave", function(self) self.tooltip = false GameTooltip:Hide() end)
Stat:SetScript("OnUpdate", Update)
Update(Stat, 10)