local K, C, L, _ = unpack(select(2, ...))
if C.unitframe.enable ~= true then return end

-- Smoothing Bars
if C.unitframe.smoothbars == true then
	local StatusBars = {
		PlayerFrameHealthBar, PlayerFrameManaBar,
        TargetFrameHealthBar, TargetFrameManaBar,
        MainMenuExpBar,
	}
	
	local SmoothFrame = CreateFrame("Frame")
	SmoothStatusBar = {}
	local abs = math.abs
	local function AnimationTick()
		for bar, value in pairs(SmoothStatusBar) do
			local cur = bar:GetValue()
			local new = cur + ((value - cur) / 3)
			if new ~= new then new = value end
			if cur == value or abs(new - value) < 2 then
				bar:SetValue_(value)
				SmoothStatusBar[bar] = nil
			else
				bar:SetValue_(new)
			end
		end
	end
	
	SmoothFrame:SetScript('OnUpdate', AnimationTick)
	
	local function SmoothSetValue(self, value)
		local _, max = self:GetMinMaxValues()
		
		if value == self:GetValue() or self._max and self._max ~= max then
			SmoothStatusBar[self] = nil
			self:SetValue_(value)
		else
			SmoothStatusBar[self] = value
		end
		self._max = max
	end
	
	for bar, value in pairs(SmoothStatusBar) do
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
	
	for i, v in pairs (StatusBars) do
		if v then SmoothBar(v) end
	end
end