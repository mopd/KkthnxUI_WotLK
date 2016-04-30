local K, C, L, _ = unpack(select(2, ...))
if(IsAddOnLoaded("OmniCC") or IsAddOnLoaded("ncCooldown") or C["cooldown"].enable ~= true) then return end

local floor = math.floor
local min = math.min
local pairs, tonumber, time = pairs, tonumber, time
local getmetatable = getmetatable

local GetTime = GetTime
local CreateFrame = CreateFrame
local hooksecurefunc = hooksecurefunc

local ICON_SIZE = 36
local MIN_SCALE = 0.5
local MIN_DURATION = 1.5

local function Timer_ForceUpdate(self)
	self.nextUpdate = 0
	self:Show()
end

local function Timer_Stop(self)
	self.enabled = nil
	self:Hide()
end

local function Timer_OnUpdate(self, elapsed)
	if self.nextUpdate > 0 then
		self.nextUpdate = self.nextUpdate - elapsed
		return
	end

	local remain = self.duration - (GetTime() - self.start)

	if remain > 0.05 then
		if (self.fontScale * self:GetEffectiveScale() / UIParent:GetScale()) < MIN_SCALE then
			self.text:SetText("")
			self.nextUpdate = 500
		else
			local formatStr, time, nextUpdate = K.GetTimeInfo(remain, C["cooldown"].threshold)
			self.text:SetFormattedText(formatStr, time)
			self.nextUpdate = nextUpdate
		end
	else
		Timer_Stop(self)
	end
end

local function Timer_OnSizeChanged(self, width, height)
	local fontScale = floor(width +.5) / ICON_SIZE
	--local fontScale = K.Round(width +.5) / ICON_SIZE
	local override = self:GetParent():GetParent().SizeOverride
	if override then
		fontScale = override / FONT_SIZE
	end

	if fontScale == self.fontScale then
		return
	end

	self.fontScale = fontScale
	if fontScale < MIN_SCALE and not override then
		self:Hide()
	else
		self:Show()
		self.text:SetFont(C["media"].normal_font, fontScale * C["cooldown"].font_size, "OUTLINE")
		self.text:SetShadowOffset(K.mult, -K.mult)
		if self.enabled then
			Timer_ForceUpdate(self)
		end
	end
end

local function Timer_Create(self)
	local scaler = CreateFrame("Frame", nil, self)
	scaler:SetAllPoints()

	local timer = CreateFrame("Frame", nil, scaler)
	timer:Hide()
	timer:SetAllPoints(scaler)
	timer:SetScript("OnUpdate", Timer_OnUpdate)

	local text = timer:CreateFontString(nil, "OVERLAY")
	text:SetPoint("CENTER", 1, 1)
	text:SetJustifyH("CENTER")
	timer.text = text

	Timer_OnSizeChanged(timer, scaler:GetSize())
	scaler:SetScript("OnSizeChanged", function(_, ...) Timer_OnSizeChanged(timer, ...) end)

	self.timer = timer
	return timer
end

local function Timer_Start(self, start, duration)
	if(self.noOCC) then return end
	local button = self:GetParent()

	if start > 0 and duration > MIN_DURATION then
		local timer = self.timer or Timer_Create(self)
		timer.start = start
		timer.duration = duration
		timer.enabled = true
		timer.nextUpdate = 0
		if timer.fontScale >= MIN_SCALE then timer:Show() end
	else
		local timer = self.timer
		if timer then
			Timer_Stop(timer)
			return
		end
	end

	if self.timer then
		if charges and charges > 0 then
			self.timer:SetAlpha(0)
		else
			self.timer:SetAlpha(1)
		end
	end
end

hooksecurefunc(getmetatable(ActionButton1Cooldown).__index, "SetCooldown", Timer_Start)