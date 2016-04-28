local K, C, L, _ = unpack(select(2, ...))
if(IsAddOnLoaded("OmniCC") or IsAddOnLoaded("ncCooldown") or C["cooldown"].enable ~= true) then return end

local floor = math.floor
local min = math.min
local tonumber = tonumber
local getmetatable = getmetatable
local time = time
local pairs = pairs

local GetTime = GetTime
local CreateFrame = CreateFrame

OmniCC = true
local ICON_SIZE = 36
local MIN_SCALE = 0.5
local MIN_DURATION = 2.5

local function Timer_Stop(self)
	self.enabled = nil
	self:Hide()
end

local function Timer_ForceUpdate(self)
	self.nextUpdate = 0
	self:Show()
end

local function Timer_OnSizeChanged(self, width, height)
	local fontScale = K.Round(width +.5) / ICON_SIZE
	if(fontScale == self.fontScale) then
		return
	end
	
	self.fontScale = fontScale
	if(fontScale < MIN_SCALE) then
		self:Hide()
	else
		self.text:SetFont(C["media"].normal_font, fontScale * C["cooldown"].font_size, "OUTLINE")
		self.text:SetShadowColor(0, 0, 0, 0.5)
		self.text:SetShadowOffset(2, -2)
		if(self.enabled) then
			Timer_ForceUpdate(self)
		end
	end
end

local function Timer_OnUpdate(self, elapsed)
	if(self.nextUpdate > 0) then
		self.nextUpdate = self.nextUpdate - elapsed
	else
		local remain = self.duration - (GetTime() - self.start)
		if(tonumber(K.Round(remain)) > 0) then
			if((self.fontScale * self:GetEffectiveScale() / UIParent:GetScale()) < MIN_SCALE) then
				self.text:SetText("")
				self.nextUpdate = 1
			else
				local formatStr, time, nextUpdate = K.GetTimeInfo(remain)
				self.text:SetFormattedText(formatStr, time)
				self.nextUpdate = nextUpdate
			end
		else
			Timer_Stop(self)
		end
	end
end

local function Timer_Create(self)
	local scaler = CreateFrame("Frame", nil, self)
	scaler:SetAllPoints(self)
	
	local timer = CreateFrame("Frame", nil, scaler)
	timer:Hide()
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

local function Timer_Start(self, start, duration)
	if(self.noOCC) then return end
	
	if(start > 0 and duration > MIN_DURATION) then
		local timer = self.timer or Timer_Create(self)
		timer.start = start
		timer.duration = duration
		timer.enabled = true
		timer.nextUpdate = 0
		if(timer.fontScale >= MIN_SCALE) then timer:Show() end
	else
		local timer = self.timer
		if(timer) then
			Timer_Stop(timer)
		end
	end
end

hooksecurefunc(getmetatable(ActionButton1Cooldown).__index, "SetCooldown", Timer_Start)

if(K.Toc < 40300) then return end

local active = {}
local hooked = {}

local function cooldown_OnShow(self)
	active[self] = true
end

local function cooldown_OnHide(self)
	active[self] = nil
end

local function cooldown_ShouldUpdateTimer(self, start, duration)
	local timer = self.timer
	if not timer then
		return true
	end
	return timer.start ~= start
end

local function cooldown_Update(self)
	local button = self:GetParent()
	local start, duration, enable = GetActionCooldown(button.action)
	
	if(cooldown_ShouldUpdateTimer(self, start, duration)) then
		Timer_Start(self, start, duration)
	end
end

local EventWatcher = CreateFrame("Frame")
EventWatcher:Hide()
EventWatcher:SetScript("OnEvent", function(self, event)
	for cooldown in pairs(active) do
		cooldown_Update(cooldown)
	end
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

if(_G["ActionBarButtonEventsFrame"].frames) then
	for i, frame in pairs(_G["ActionBarButtonEventsFrame"].frames) do
		actionButton_Register(frame)
	end
end

hooksecurefunc("ActionBarButtonEventsFrame_RegisterFrame", actionButton_Register)