local K, C, L, _ = unpack(select(2, ...))
if IsAddOnLoaded("OpenAll") or IsAddOnLoaded("Postal") or IsAddOnLoaded("TradeSkillMaster_Mailing") then return end
if C.misc.enhancedmail ~= true then return end

local LOOTDELAY = 0.3
local MAX_LOOPS = 5
local onlyCash, origInboxFrame_OnClick

local Mail = CreateFrame('Frame', "AbuMail", UIParent)
local button

local bacon = {
	["The Postmaster"] = true,
}

local function breathe(self, elapsed)
	self.ticker = self.ticker + elapsed
	
	if (self.delay < self.ticker) then
		self.delay = 0
		self.ticker = 0
		self:ProcessMail()
	end
end

local function checkBagSize()
	local totalFree = 0
	for i=0, NUM_BAG_SLOTS do
		local numberOfFreeSlots = GetContainerNumFreeSlots(i)
		totalFree = totalFree + numberOfFreeSlots
	end
	return totalFree
end

function Mail:ProcessMail()
	if not InboxFrame:IsVisible() then return self:StopMail() end
	
	if self.index <= 0 then
		local items_left = GetInboxNumItems()
		if (items_left <= 0) or (self.times_looped >= MAX_LOOPS) then
			return self:StopMail()
		end
		
		self.times_looped = self.times_looped + 1
		self.index = items_left
	end
	
	local _, _, sender, subject, money, CODAmount, _, numItems, wasRead, wasReturned, textCreated, canReply, isGM = GetInboxHeaderInfo(self.index)
	numItems = (not numItems) and 0 or numItems
	money = (not money) and 0 or money
	
	if (money <= 0) and (onlyCash or numItems == 0) or (CODAmount > 0) then
		if (money <= 0) and (numItems <= 0) and bacon[sender] then
			DeleteInboxItem(self.index)
			self.delay = LOOTDELAY
		end
		
	elseif (not onlyCash) and (numItems > 0) and (CODAmount <= 0) and (checkBagSize() > 0) then
		AutoLootMailItem(self.index)
		self.delay = LOOTDELAY
		
	elseif (money > 0) then
		TakeInboxMoney(self.index)
		self.delay = LOOTDELAY
	end
	
	self.index = self.index - 1
end

function Mail:StopMail(msg)
	self:SetScript('OnUpdate', nil)
	self:UnregisterEvent("UI_ERROR_MESSAGE")
	
	if origInboxFrame_OnClick then
		_G.InboxFrame_OnClick = origInboxFrame_OnClick
	end
	if msg then
		ns:Print(msg)
	end
	
	local _, totalLeft = GetInboxNumItems()
	if (totalLeft == 0) then
		MiniMapMailFrame:Hide()
	end
	
	button:Enable()
end

function Mail:GetMail(grabOnlyCash)
	if GetInboxNumItems() > 0 then
		self:RegisterEvent("UI_ERROR_MESSAGE")
		button:Disable()
		
		self.index = GetInboxNumItems()
		self.delay = 0
		self.ticker = 0
		self.times_looped = 0
		
		onlyCash = grabOnlyCash
		
		origInboxFrame_OnClick = InboxFrame_OnClick
		_G.InboxFrame_OnClick = function() end
		
		self:SetScript('OnUpdate', breathe)	
	end
end

function Mail:UI_ERROR_MESSAGE(event, arg1)
	if arg1 == ERR_INV_FULL then
		self:StopMail('Your bags are full!')
	end
end

local function CalculateMoney()
	local profit = 0
	for i = GetInboxNumItems(), 1, -1 do
		local _, _, _, _, money = GetInboxHeaderInfo(i)
		profit = profit + (money or 0)
	end
	return profit
end

function Mail:PLAYER_LOGIN(event, ...)
	button = CreateFrame("Button", "AbuMail", InboxFrame, "UIPanelButtonTemplate")
	button:SetWidth(120)
	button:SetHeight(25)
	button:SetPoint("CENTER", InboxFrame, "TOP", -36, -399)
	button:SetText("Take All")
	button:SetFrameLevel(button:GetFrameLevel() + 1)
	
	button:RegisterEvent("MODIFIER_STATE_CHANGED")
	button:SetScript("OnEvent", function(self, event, key, state)
		if key ~= "LSHIFT" then return; end
		if state == 1 then
			if (CalculateMoney() == 0) then
				self:Disable()
			else
				self:Enable()
			end
			self:SetText("Take Money")
			self.takeMoney = true
		else
			self:SetText("Take All")
			self.takeMoney = false
			self:Enable()
		end
	end)
	
	button:SetScript("OnClick", function(self) Mail:GetMail(self.takeMoney) end)
	button:SetScript("OnEnter", function(self, motion)
		local profit = CalculateMoney()
		if profit == 0 then return; end
		
		GameTooltip:SetOwner(self, "ANCHOR_TOP");
		GameTooltip:SetText("Total Money:\n|cffffffff" .. GetCoinTextureString(profit).."|r")
		GameTooltip:Show();
	end)
	button:SetScript("OnLeave", GameTooltip_Hide)
	button:SetScript("OnHide", GameTooltip_Hide)
end

Mail:RegisterEvent("PLAYER_LOGIN")
Mail:SetScript("OnEvent", function(self, event, ...) 
	if self[event] then 
		return self[event](self, event, ...) 
	end 
end)