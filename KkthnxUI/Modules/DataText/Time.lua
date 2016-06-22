local K, C, L, _ = select(2, ...):unpack()

local Stat = CreateFrame("Frame", "StatTime")
Stat:EnableMouse(true)
Stat:SetFrameStrata("MEDIUM")
Stat:SetFrameLevel(3)

local Text = Minimap:CreateFontString(nil, "OVERLAY")
Text:SetFont(C["Media"].Font, 12, "OUTLINE")
Text:SetPoint("BOTTOM", Minimap, "BOTTOM", 0, 2)

local int = 1
local function Update(self, t)
	local pendingCalendarInvites = CalendarGetNumPendingInvites()
	int = int - t
	if int < 0 then
		if C["Minimap"].Local_Time == true then
			Hr24 = tonumber(date("%H"))
			Hr = tonumber(date("%I"))
			Min = date("%M")
			if C["Minimap"].Time_24 == true then
				if pendingCalendarInvites > 0 then
					Text:SetText("|cffFF0000"..Hr24..":"..Min)
				else
					Text:SetText(Hr24..":"..Min)
				end
			else
				if Hr24 >= 12 then
					if pendingCalendarInvites > 0 then
						Text:SetText("|cffFF0000"..Hr..":"..Min.." |cffffffffpm|r")
					else
						Text:SetText(Hr..":"..Min.." |cffffffffpm|r")
					end
				else
					if pendingCalendarInvites > 0 then
						Text:SetText("|cffFF0000"..Hr..":"..Min.." |cffffffffam|r")
					else
						Text:SetText(Hr..":"..Min.." |cffffffffam|r")
					end
				end
			end
		else
			local Hr, Min = GetGameTime()
			if Min < 10 then Min = "0"..Min end
			if C["Minimap"].Time_24 == true then
				if pendingCalendarInvites > 0 then
					Text:SetText("|cffFF0000"..Hr..":"..Min.." |cffffffff|r")
				else
					Text:SetText(Hr..":"..Min.." |cffffffff|r")
				end
			else
				if Hr >= 12 then
					if Hr > 12 then Hr = Hr - 12 end
					if pendingCalendarInvites > 0 then
						Text:SetText("|cffFF0000"..Hr..":"..Min.." |cffffffffpm|r")
					else
						Text:SetText(Hr..":"..Min.." |cffffffffpm|r")
					end
				else
					if Hr == 0 then Hr = 12 end
					if pendingCalendarInvites > 0 then
						Text:SetText("|cffFF0000"..Hr..":"..Min.." |cffffffffam|r")
					else
						Text:SetText(Hr..":"..Min.." |cffffffffam|r")
					end
				end
			end
		end
		self:SetAllPoints(Text)
		int = 2
	end
end

Stat:SetScript("OnEnter", function(self)
	OnLoad = function(self) RequestRaidInfo() end
	local anchor, panel, xoff, yoff = "ANCHOR_BOTTOMLEFT", self:GetParent(), 0, K.Scale(5)
	GameTooltip:SetOwner(self, anchor, xoff, yoff)
	GameTooltip:ClearLines()

	local WGTime = GetWintergraspWaitTime() or nil
	inInstance, instanceType = IsInInstance()
	if not ( instanceType == "none" ) then
		WGTime = QUEUE_TIME_UNAVAILABLE
	elseif WGTime == nil then
		WGTime = WINTERGRASP_IN_PROGRESS
	else
		local Hour = tonumber(format("%01.f", floor(WGTime / 3600)))
		local Min = format(Hour > 0 and "%02.f" or "%01.f", floor(WGTime / 60 - (Hour * 60)))
		local Sec = format("%02.f", floor(WGTime - Hour * 3600 - Min *60))
		WGTime = (Hour > 0 and Hour..":" or "")..Min..":"..Sec
		SetMapByID(485)
		SetMapToCurrentZone()
	end
	GameTooltip:AddDoubleLine(L_DATATEXT_WINTERGRASP, WGTime)

	if C["Minimap"].Local_Time == true then
		local Hr, Min = GetGameTime()
		if Min < 10 then Min = "0"..Min end
		if C["Minimap"].Time_24 == true then
			GameTooltip:AddDoubleLine(L_DATATEXT_SERVERTIME, Hr .. ":" .. Min)
		else
			if Hr >= 12 then
				Hr = Hr-12
				if Hr == 0 then Hr = 12 end
				GameTooltip:AddDoubleLine(L_DATATEXT_SERVERTIME, Hr .. ":" .. Min.." PM")
			else
				if Hr == 0 then Hr = 12 end
				GameTooltip:AddDoubleLine(L_DATATEXT_SERVERTIME, Hr .. ":" .. Min.." AM")
			end
		end
	else
		Hr24 = tonumber(date("%H"))
		Hr = tonumber(date("%I"))
		Min = date("%M")
		if C["Minimap"].Time_24 == true then
			GameTooltip:AddDoubleLine(L_DATATEXT_LOCALTIME, Hr24 .. ":" .. Min)
		else
			if Hr24 >= 12 then
				GameTooltip:AddDoubleLine(L_DATATEXT_LOCALTIME, Hr .. ":" .. Min.." PM")
			else
				GameTooltip:AddDoubleLine(L_DATATEXT_LOCALTIME, Hr .. ":" .. Min.." AM")
			end
		end
	end

	local oneraid
	for i = 1, GetNumSavedInstances() do
		local name, _, reset, difficulty, locked, extended, _, isRaid, maxPlayers = GetSavedInstanceInfo(i)
		if isRaid and (locked or extended) then
			local tr, tg, tb, diff
			if not oneraid then
				GameTooltip:AddLine(" ")
				GameTooltip:AddLine(L_DATATEXT_SAVEDRAIDS)
				oneraid = true
			end

			local function fmttime(Sec,table)
				local table = table or {}
				local d, h, m, s = ChatFrame_TimeBreakDown(floor(Sec))
				local string = gsub(gsub(format(" %dd %dh %dm "..((d == 0 and h == 0) and "%ds" or ""), d, h, m, s)," 0[dhms]"," "),"%s+"," ")
				local string = strtrim(gsub(string, "([dhms])", {d = table.days or "d", h = table.hours or "h", m = table.minutes or "m",s = table.seconds or "s"})," ")
				return strmatch(string,"^%s*$") and "0"..(table.seconds or L"s") or string
			end
			if extended then tr, tg, tb = 0.3, 1, 0.3 else tr, tg, tb = 1, 1, 1 end
			if difficulty == 3 or difficulty == 4 then diff = "H" else diff = "N" end
			GameTooltip:AddDoubleLine(format("%s |cffaaaaaa(%s%s)", name, maxPlayers, diff), fmttime(reset), 1, 1, 1, tr, tg, tb)
		end
	end
	GameTooltip:Show()
end)

Stat:SetScript("OnLeave", function() GameTooltip:Hide() end)
Stat:SetScript("OnUpdate", Update)
Stat:RegisterEvent("CALENDAR_UPDATE_PENDING_INVITES")
Stat:RegisterEvent("PLAYER_ENTERING_WORLD")
Stat:SetScript("OnMouseDown", function(self, btn)
	if btn == 'RightButton'  then
		ToggleTimeManager()
	else
		GameTimeFrame:Click()
	end
end)
Update(Stat, 10)