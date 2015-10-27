local K, C, L, _ = unpack(select(2, ...))
--if C.unitframe.smoothing ~= true then return end

if C.unitframe.classhealth == false then
	function HealthBar_OnValueChanged(self, value, smooth)
		if not value then return end
		local r, g, b
		local min, max = self:GetMinMaxValues()
		
		if value < min or value > max then return end
		
		if (max - min) > 0 then
			value = (value - min)/(max - min)
		else
			value = 0
		end
		if value > .5 then
			r = (1 - value)*2
			g = 1
		else
			r = 1
			g = value * 2
		end
		b = 0
		self:SetStatusBarColor(r, g, b)
	end
end

local barstosmooth = {
	PlayerFrameHealthBar,
	PlayerFrameManaBar,
	TargetFrameHealthBar,
	TargetFrameManaBar,
	CastingBarFrame,
	FocusFrameHealthBar,
	FocusFrameManaBar,
	FocusFrameToTHealthBar,
	FocusFrameToTManaBar,
	TargetFrameToTHealthBar,
	TargetFrameToTManaBar,
}

local smoothframe = CreateFrame'Frame'
smoothing = {}
local min, max = math.min, math.max
local function AnimationTick()
	local limit = 30/GetFramerate()
	for bar, value in pairs(smoothing) do
		local cur = bar:GetValue()
		local new = cur + min((value - cur)/3, max(value - cur, limit))
		if new ~= new then new = value end
		if cur == value or abs(new - value) < 2 then
			bar:SetValue_(value)
			-- print(value)
			smoothing[bar] = nil
		else
			bar:SetValue_(new)
		end
	end
end

smoothframe:SetScript('OnUpdate', AnimationTick)

local function SmoothSetValue(self, value)
	local _, max = self:GetMinMaxValues()
	
	if value == self:GetValue() or self._max and self._max ~= max then
		smoothing[self] = nil
		self:SetValue_(value)
	else
		smoothing[self] = value
	end
	self._max = max
end

for bar, value in pairs(smoothing) do
	if bar.SetValue_ then bar.SetValue = SmoothSetValue end
end

local function SmoothBar(bar)
	if not bar.SetValue_ then
		bar.SetValue_ = bar.SetValue
		bar.SetValue = SmoothSetValue
	end
end

local function ResetBar(bar)
	if bar.SetValue_ then
		bar.SetValue = bar.SetValue_
		bar.SetValue_ = nil
	end
end

for i, v in pairs (barstosmooth) do
	if v then SmoothBar(v) end
end