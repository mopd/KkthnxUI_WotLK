local K, C, L = unpack(select(2, ...))
if C.minimap.nodeflash ~= true then return end

-- Flashing Gather nodes
function AssignButtonTexture(obj,tx,num,total)
	self.ChainCall(obj):SetNormalTexture(CreateTexWithCoordsNum(obj,tx,num,total,1,4))
	:SetPushedTexture(CreateTexWithCoordsNum(obj,tx,num,total,2,4))
	:SetHighlightTexture(CreateTexWithCoordsNum(obj,tx,num,total,3,4))
	:SetDisabledTexture(CreateTexWithCoordsNum(obj,tx,num,total,4,4))
end

local nodeFrame = CreateFrame("Frame")
function nodeFrame.ChainCall(obj) local T={} setmetatable(T,{__index=function(self,fun) if fun=="__END" then return obj end return function(self,...) assert(obj[fun],fun.." missing in object") obj[fun](obj,...) return self end end}) return T end

local flash_interval = 0.25

local flash = nil
local MinimapNodeFlash = function(s)
	flash = not flash
	Minimap:SetBlipTexture("Interface\\AddOns\\KkthnxUI\\Media\\Minimap\\objecticons_"..(flash and "on" or "off"))
end

local q = 0
do
	local flashgathernodes = true
	local flashFrame = CreateFrame("FRAME","PointerExtraFrame")
	local ant_last=GetTime()
	local flash_last=GetTime()
	flashFrame:SetScript("OnUpdate",function(self,elapsed)
		local t=GetTime()
		
		-- Flashing node dots. Prettier than the standard, too. And slightly bigger.
		if flashgathernodes == true then
			if t-flash_last>=flash_interval then
				MinimapNodeFlash()
				flash_last=t-(t-flash_last)%flash_interval
			end
		else
			Minimap:SetBlipTexture("Interface\\AddOns\\KkthnxUI\\Media\\Minimap\\objecticons_on")		
		end
	end)
	
	flashFrame:SetPoint("CENTER", UIParent)
	flashFrame:Show()
	nodeFrame.ChainCall(flashFrame:CreateTexture("PointerDotOn","OVERLAY")) :SetTexture("Interface\\AddOns\\KkthnxUI\\Media\\Minimap\\objecticons_on") :SetSize(50,50) :SetPoint("CENTER") :SetNonBlocking(true) :Show()
	nodeFrame.ChainCall(flashFrame:CreateTexture("PointerDotOff","OVERLAY")) :SetTexture("Interface\\AddOns\\KkthnxUI\\Media\\Minimap\\objecticons_off") :SetSize(50,50) :SetPoint("RIGHT") :SetNonBlocking(true) :Show()
end