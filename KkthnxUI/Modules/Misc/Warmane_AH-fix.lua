local K, C, L, _ = unpack(select(2, ...))
if IsAddOnLoaded("Warmane_AH-fix") then return end

-- Fixes auction house addon functionality on Warmane wotlk realms (Anyone@Deathwing)
if (K.Realm == "Ragnaros" or K.Realm == "Deathwing" or K.Realm == "Lordaeron") then -- Replace this when realms merge to Icecrown
--if (K.Realm == "Icecrown" or K.Realm == "Lordaeron") then

	local pairs = pairs 
	
	local IsAddOnLoaded = IsAddOnLoaded
	local CreateFrame = CreateFrame
	local origStartAuction = origStartAuction
	local GetInboxHeaderInfo = GetInboxHeaderInfo
	local origGetInboxHeaderInfo = origGetInboxHeaderInfo
	local AuctionsStackSizeEntry = AuctionsStackSizeEntry
	local sender = sender
	local packageIcon, stationeryIcon, sender, subject, money, CODAmount = packageIcon, stationeryIcon, sender, subject, money, CODAmount
	local daysLeft, hasItem, wasRead, wasReturned, textCreated, canReply, isGM = daysLeft, hasItem, wasRead, wasReturned, textCreated, canReply, isGM
	local minBid, buyoutPrice, runTime, stackSize, numStacks = minBid, buyoutPrice, runTime, stackSize, numStacks
	
	local frame = CreateFrame("frame")
	
	local origStartAuction = StartAuction
	StartAuction = function(minBid, buyoutPrice, runTime, stackSize, numStacks)
		numStacks = numStacks or 1
		stackSize = stackSize or AuctionsStackSizeEntry:GetText()
		return origStartAuction(minBid, buyoutPrice, runTime, stackSize, numStacks)
	end
	
	local AllianceMails = {
		"Stormwind Auction House",
		"Ironforge Auction House",
		"Darnassus Auction House",
		"Exodar Auction House"
	}
	
	local HordeMails = {
		"Undercity Auction House",
		"Thunder Bluff Auction House",
		"Thunder Bluff Auction House", -- Currently with 2 spaces, listing with 1 space also in case it gets changed.
		"Orgrimmar Auction House",
		"Silvermoon Auction House"
	}
	
	local origGetInboxHeaderInfo = GetInboxHeaderInfo
	GetInboxHeaderInfo = function(index)
		packageIcon, stationeryIcon, sender, subject, money, CODAmount, daysLeft, hasItem, wasRead, wasReturned, textCreated, canReply, isGM = origGetInboxHeaderInfo(index)
		
		for _,v in pairs(AllianceMails) do
			if v == sender then
				sender = "Alliance Auction House"
				break
			end
		end
		
		for _,v in pairs(HordeMails) do
			if v == sender then
				sender = "Horde Auction House"
				break
			end
		end
		
		return packageIcon, stationeryIcon, sender, subject, money, CODAmount, daysLeft, hasItem, wasRead, wasReturned, textCreated, canReply, isGM
	end
end