local K, C, L = unpack(select(2, ...));

local last_search = 0;

local AHFix = CreateFrame("Frame")
AHFix:RegisterEvent("AUCTION_ITEM_LIST_UPDATE")

local origCanSendAuctionQuery = CanSendAuctionQuery;
CanSendAuctionQuery = function(...)
	if (last_search + 1.2 > GetTime()) then
		return false, false;
	else
		return origCanSendAuctionQuery(...)
	end
end

local origQueryAuctionItems = QueryAuctionItems;
QueryAuctionItems = function(...)
	while (last_search + 1.2 > GetTime()) do
	end
	last_search = GetTime()
	return origQueryAuctionItems(...)
end

local eventHandler = function()
	if (event == "AUCTION_ITEM_LIST_UPDATE") then
		if (last_search + 0.2 < GetTime()) then
			last_search = GetTime() - 0.2;
		end
	end
end
AHFix:SetScript("OnEvent", eventHandler)

local origStartAuction = StartAuction;
StartAuction = function(minBid, buyoutPrice, runTime, stackSize, numStacks)
	numStacks = numStacks or 1;
	stackSize = stackSize or AuctionsStackSizeEntry:GetText()
	return origStartAuction(minBid, buyoutPrice, runTime, stackSize, numStacks)
end