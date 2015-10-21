local K, C, L, _ = unpack(select(2, ...))
if C.actionbar.enable ~= true then return end
if IsAddOnLoaded("OmniCC") or IsAddOnLoaded("ncCooldown") or IsAddOnLoaded("tullaCC") then return end

OmniCC = true
local ICON_SIZE = 36
local DAY, HOUR, MINUTE = 86400, 3600, 60
local DAYISH, HOURISH, MINUTEISH = 3600 * 23.5, 60 * 59.5, 59.5
local HALFDAYISH, HALFHOURISH, HALFMINUTEISH = DAY / 2 + 0.5, HOUR / 2 + 0.5, MINUTE / 2 + 0.5

SetDefaultActionButtonCooldownFont = C.font.cooldown_timers_font
SetDefaultActionButtonCooldownFontSize = C.font.cooldown_timers_font_size
SetDefaultActionButtonCooldownMinScale = 0.5
SetDefaultActionButtonCooldownMinDuration = 2.5
local EXPIRING_DURATION = 8
local EXPIRING_FORMAT = K.RGBToHex(1, 0, 0) .. "%.1f|r"
local SECONDS_FORMAT = K.RGBToHex(1, 1, 0) .. "%d|r"
local MINUTES_FORMAT = K.RGBToHex(1, 1, 1) .. "%dm|r"
local HOURS_FORMAT = K.RGBToHex(0.4, 1, 1) .. "%dh|r"
local DAYS_FORMAT = K.RGBToHex(0.4, 0.4, 1) .. "%dh|r"
local floor = math.floor
local min = math.min
local GetTime = GetTime

local function getTimeText(s)
	if s < MINUTEISH then
		local seconds = tonumber(K.Round(s))
		if seconds > EXPIRING_DURATION then return SECONDS_FORMAT, seconds, s - (seconds - .51) else return EXPIRING_FORMAT, s, .051 end
	elseif s < HOURISH then
		local minutes = tonumber(K.Round(s/MINUTE))
		return MINUTES_FORMAT, minutes, minutes > 1 and (s - (minutes*MINUTE - HALFMINUTEISH)) or (s - MINUTEISH)
	elseif s < DAYISH then
		local hours = tonumber(K.Round(s/HOUR))
		return HOURS_FORMAT, hours, hours > 1 and (s - (hours*HOUR - HALFHOURISH)) or (s - HOURISH)
	else
		local days = tonumber(K.Round(s/DAY))
		return DAYS_FORMAT, days, days > 1 and (s - (days*DAY - HALFDAYISH)) or (s - DAYISH)
	end
end

local function Timer_Stop(self)
	self.enabled = nil
	self:Hide()
end

local function Timer_ForceUpdate(self)
	self.nextUpdate = 0
	self:Show()
end

local function Timer_OnSizeChanged(self, width, height)
	local fontScale = K.Round(width) / ICON_SIZE
	if fontScale == self.fontScale then return end
	
	self.fontScale = fontScale
	if fontScale < SetDefaultActionButtonCooldownMinScale then
		self:Hide()
	else
		self.text:SetFont(SetDefaultActionButtonCooldownFont, fontScale * SetDefaultActionButtonCooldownFontSize, "OUTLINE")
		self.text:SetShadowColor(0, 0, 0, .5)
		self.text:SetShadowOffset(2, -2)
		if self.enabled then Timer_ForceUpdate(self) end
	end
end

local function Timer_OnUpdate(self, elapsed)
	if self.nextUpdate > 0 then
		self.nextUpdate = self.nextUpdate - elapsed
	else
		local remain = self.duration - (GetTime() - self.start)
		if tonumber(K.Round(remain)) > 0 then
			if (self.fontScale * self:GetEffectiveScale() / UIParent:GetScale()) < SetDefaultActionButtonCooldownMinScale then
				self.text:SetText("")
				self.nextUpdate = 1
			else
				local formatStr, time, nextUpdate = getTimeText(remain)
				self.text:SetFormattedText(formatStr, time)
				self.nextUpdate = nextUpdate
			end
		else
			Timer_Stop(self)
		end
	end
end

local function Timer_Create(self)
	--a frame to watch for OnSizeChanged events
	--needed since OnSizeChanged has funny triggering if the frame with the handler is not shown
	local scaler = CreateFrame("Frame", nil, self)
	scaler:SetAllPoints(self)
	
	local timer = CreateFrame("Frame", nil, scaler); timer:Hide()
	timer:SetAllPoints(scaler)
	timer:SetScript("OnUpdate", Timer_OnUpdate)
	
	local text = timer:CreateFontString(nil, "OVERLAY")
	text:SetPoint("CENTER", 2, 0)
	text:SetJustifyH("CENTER")
	timer.text = text
	
	Timer_OnSizeChanged(timer, scaler:GetSize())
	scaler:SetScript("OnSizeChanged", function(self, ...) Timer_OnSizeChanged(timer, ...) end)
	
	self.timer = timer
	return timer
end

local function Timer_Start(self, start, duration, charges, maxCharges)
	if self.noOCC then return end
	
	if start > 0 and duration > SetDefaultActionButtonCooldownMinDuration then
		local timer = self.timer or Timer_Create(self)
		local num = charges or 0
		timer.start = start
		timer.duration = duration
		timer.charges = num
		timer.maxCharges = maxCharges
		timer.enabled = true
		timer.nextUpdate = 0
		if timer.fontScale >= SetDefaultActionButtonCooldownMinScale and timer.charges < 1 then timer:Show() end
	else
		local timer = self.timer
		if timer then Timer_Stop(timer) end
	end
end

hooksecurefunc(getmetatable(_G["ActionButton1Cooldown"]).__index, "SetCooldown", Timer_Start)

local active = {}
local hooked = {}

local function cooldown_OnShow(self) active[self] = true end
local function cooldown_OnHide(self) active[self] = nil end

UpdateActionButtonCooldown = function(self)
	local button = self:GetParent()
	local start, duration, enable = GetActionCooldown(button.action)
	local charges, maxCharges, chargeStart, chargeDuration = GetActionCharges(button.action)
	
	Timer_Start(self, start, duration, charges, maxCharges)
end

local EventWatcher = CreateFrame("Frame")
EventWatcher:Hide()
EventWatcher:SetScript("OnEvent", function(self, event)
	for cooldown in pairs(active) do UpdateActionButtonCooldown(cooldown) end
end)
EventWatcher:RegisterEvent("ACTIONBAR_UPDATE_COOLDOWN")

local function actionButton_Register(frame)
	local cooldown = frame.cooldown
	if not hooked[cooldown] then
		cooldown:HookScript("OnShow", cooldown_OnShow)
		cooldown:HookScript("OnHide", cooldown_OnHide)
		hooked[cooldown] = true
	end
end