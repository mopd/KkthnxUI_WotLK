local K, C, L = unpack(select(2, ...));
if C["unitframe"].enable ~= true then return end

local KkthnxCB = CreateFrame("Frame", "KkthnxCB", UIParent)
_G["KkthnxCB"] = KkthnxCB

-- Anchors
local PlayerCastbarAnchor = CreateFrame("Frame", "PlayerCastbarAnchor", UIParent)
PlayerCastbarAnchor:SetSize(CastingBarFrame:GetWidth() * C["unitframe"].cbscale, CastingBarFrame:GetHeight() * 2)
PlayerCastbarAnchor:SetPoint(unpack(C["position"].playercastbar))

local TargetCastbarAnchor = CreateFrame("Frame", "TargetCastbarAnchor", UIParent)
TargetCastbarAnchor:SetSize(CastingBarFrame:GetWidth() * C["unitframe"].cbscale, CastingBarFrame:GetHeight() * 2)
TargetCastbarAnchor:SetPoint(unpack(C["position"].targetcastbar))


function KkthnxCB:HideBlizzard(unit)
	if(unit == "player") then
		CastingBarFrame:UnregisterAllEvents()
		CastingBarFrame.Show = K.Dummy
		CastingBarFrame:Hide()
	end
end

function KkthnxCB:CastInfo(unit)
	local spell, rank, name, icon, startTime, endTime, isTradeSkill = UnitCastingInfo(unit)
	local channeled = false
	
	if(not spell) then
		channeled = true
		spell, rank, name, icon, startTime, endTime, isTradeSkill = UnitChannelInfo(unit)
	end
	
	return spell, rank, name, icon, startTime, endTime, isTradeSkill, channeled
end

function KkthnxCB:IsCasting(unit)
	local spell = select(1, self:CastInfo(unit))
	
	return spell ~= nil and true or false
end

function KkthnxCB:Start(unit)
	local spell, rank, name, icon, startTime, endTime, isTradeSkill, channeled = self:CastInfo(unit)
	
	local f = self[unit]
	
	f.startTime = startTime
	f.endTime = endTime
	f.duration = endTime-startTime
	f.initialDuration = f.duration
	f.channeled = channeled
	
	f.name:SetText(spell)
	f.icon:SetTexture(icon)
	
	if(channeled) then
		f.progress:SetStatusBarColor(1, 122/255, 0, 1)
	else
		f.progress:SetStatusBarColor(0, 122/255, 1, 1)
	end
	
	f.fade = 0
	f.fadeAlpha = 150 -- deliberatly set too high, as it gets multipled down later. This is there is a linger time before fading
	f:SetAlpha(1)
	f:Show()
end

function KkthnxCB:Stop(unit)
	local f = self[unit]
	local success = false
	
	if(f.endTime) then
		local lag = select(3, GetNetStats())
		local eta = (GetTime()*1000)-f.endTime
		
		if(eta+lag >= 0) then
			success = true
		end
	end
	
	f.startTime = nil
	f.endTime = nil
	f.duration = nil
	f.initialDuration = nil
	
	if(not success) then
		f.progress:SetStatusBarColor(122/255, 0, 0, 1)
	end
	
	self:FadeOut(unit)
end

function KkthnxCB:FadeOut(unit)
	local f = self[unit]
	
	f.fade = 1
end

function KkthnxCB:Spawn(unit)
	self:HideBlizzard(unit)
	
	local f = CreateFrame("Frame", nil, KkthnxCB)
	self[unit] = f
	f.unit = unit
	f.lingerDuration = .5
	
	f:SetWidth(250)
	f:SetHeight(32)
	f:SetBackdrop(K.Backdrop)
	f:SetBackdropBorderColor(0.7, 0.7, 0.7, 1)
	f:SetBackdropColor(0.05, 0.05, 0.05, .9)
	f:Hide()
	
	f.icon = f:CreateTexture()
	f.icon:SetPoint("TOPLEFT", f, "TOPLEFT", 5, -5)
	f.icon:SetWidth(f:GetHeight()-10)
	f.icon:SetHeight(f:GetHeight()-10)
	f.icon:SetTexCoord(0.1, .9, 0.1, .9)
	
	f.progress = CreateFrame("StatusBar", nil, f)
	f.progress:SetStatusBarTexture(C["media"].texture)
	f.progress:SetBackdrop(K.BasicBackdrop) -- Idk if I like this.
	f.progress:SetBackdropColor(0.05, 0.05, 0.05, 0)
	f.progress:SetPoint("TOPLEFT", f.icon, "TOPRIGHT", 0, 0)
	f.progress:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", -5, 5)
	f.progress:SetMinMaxValues(0, 100)
	
	f.lag = CreateFrame("Frame", nil, f.progress)
	f.lag:SetPoint("TOPRIGHT", f.progress, "TOPRIGHT", 0, 0)
	f.lag:SetWidth(f.icon:GetHeight())
	f.lag:SetHeight(f.icon:GetHeight())
	f.lag.texture = f.lag:CreateTexture()
	f.lag.texture:SetAllPoints(f.lag)
	f.lag.texture:SetTexture(C["media"].texture)
	f.lag.texture:SetVertexColor(0, 122/255, 0, 1)
	if(unit ~= "player") then f.lag.texture:Hide() end
	
	f.name = f.progress:CreateFontString(nil, "OVERLAY")
	f.name:SetPoint("LEFT", f.progress, "LEFT", 5, 0)
	f.name:SetFont(C["font"].basic_font, C["font"].basic_font_size + 1)
	f.name:SetTextColor(1, 1, 1)
	f.name:SetJustifyH("LEFT")
	f.name:SetShadowOffset(1, -1)
	
	f.time = f.lag:CreateFontString(nil, "OVERLAY")
	f.time:SetPoint("RIGHT", f.progress, "RIGHT", -5, 0)
	f.time:SetFont(C["font"].basic_font, C["font"].basic_font_size + 1)
	f.time:SetTextColor(1, 1, 1)
	f.time:SetJustifyH("RIGHT")
	f.time:SetShadowOffset(1, -1)
	
	f:RegisterEvent("UNIT_SPELLCAST_START")
	f:RegisterEvent("UNIT_SPELLCAST_STOP")
	f:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")
	f:RegisterEvent("UNIT_SPELLCAST_FAILED")
	f:RegisterEvent("UNIT_SPELLCAST_INTERRUPTED")
	f:RegisterEvent("UNIT_SPELLCAST_DELAYED")
	f:RegisterEvent("UNIT_SPELLCAST_CHANNEL_START")
	f:RegisterEvent("UNIT_SPELLCAST_CHANNEL_STOP")
	f:RegisterEvent("UNIT_SPELLCAST_CHANNEL_UPDATE")
	
	if(unit ~= "player" and unit ~= "target") then
		f:RegisterEvent("UNIT_TARGET")
	elseif(unit == "player") then
		f:RegisterEvent("PLAYER_TARGET_CHANGED")
		f:RegisterEvent("PLAYER_FOCUS_CHANGED")
	end
	f:SetScript("OnEvent", function(self, e)
		if(e == "PLAYER_TARGET_CHANGED") then
			if(KkthnxCB:IsCasting("target")) then
				KkthnxCB:Start("target")
			else
				KkthnxCB:FadeOut("target")
			end
		elseif(e == "PLAYER_FOCUS_CHANGED") then
			if(KkthnxCB:IsCasting("focus")) then
				KkthnxCB:Start("focus")
			else
				KkthnxCB:FadeOut("focus")
			end
		elseif(e == "UNIT_TARGET" and arg1 == self.unit) then
			if(KkthnxCB:IsCasting(self.unit)) then
				KkthnxCB:Start(self.unit)
			else
				KkthnxCB:FadeOut(self.unit)
			end
		elseif(arg1 == self.unit) then
			if(e == "UNIT_SPELLCAST_START" or e == "UNIT_SPELLCAST_CHANNEL_START") then
				KkthnxCB:Start(self.unit)
			elseif(e == "UNIT_SPELLCAST_FAILED" or e == "UNIT_SPELLCAST_INTERRUPTED" or e == "UNIT_SPELLCAST_STOP" or e == "UNIT_SPELLCAST_CHANNEL_STOP") then
				KkthnxCB:Stop(self.unit)
			end
		end
	end)
	f:SetScript("OnUpdate", function(self, elapsed)
		if(self.fade <= 0) then
			local time = GetTime()
			local milliTime = time*1000
			
			local percent = ((milliTime-self.startTime)/self.duration)*100
			local timeDone = milliTime-self.startTime
			local lag = select(3, GetNetStats())
			local progressText = K.Round(timeDone/1000, 1)
			
			self.progress:SetValue(percent)
			
			self.lag:SetWidth((self.progress:GetWidth()/100)*(lag/self.duration*100))
			if(self.duration ~= self.initialDuration) then
				self.time:SetFormattedText("|cffdd0000-%s |cffffffff%s|r", K.Round((self.duration-self.initialDuration)/1000, 1), progressText)
			else
				self.time:SetFormattedText("|cffffffff%s|r", progressText)
			end
			
			if(percent >= 100) then
				KkthnxCB:FadeOut(self.unit)
			end
		else
			if(self:GetAlpha() <= 0) then
				self:Hide()
			else
				self.fadeAlpha = self.fadeAlpha*.9
				self:SetAlpha(self.fadeAlpha)
			end
		end
	end)
	
	return f
end

local player = KkthnxCB:Spawn("player")
player:SetPoint("CENTER", PlayerCastbarAnchor, "CENTER", 0, -3)

local target = KkthnxCB:Spawn("target")
target:SetPoint("CENTER", TargetCastbarAnchor, "CENTER", 0, -3)

local focus = KkthnxCB:Spawn("focus")
focus:SetPoint("BOTTOMLEFT", target, "TOPLEFT", 0, 0)