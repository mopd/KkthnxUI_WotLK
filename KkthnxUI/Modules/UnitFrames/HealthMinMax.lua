local K, C, L, _ = unpack(select(2, ...))
if C.unitframe.enable ~= true then return end

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