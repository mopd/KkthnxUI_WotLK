local K, C, L, _ = select(2, ...):unpack()
if C["error"].enable ~= true then return end

-- http://wowwiki.wikia.com/wiki/WoW_Constants/Errors
-- http://wowwiki.wikia.com/wiki/WoW_Constants/Spells

local NoError = CreateFrame("Frame")
-- Set messages to allow
NoError.Filter = {
	[ERR_INV_FULL] = true,
	[ERR_ITEM_MAX_COUNT] = true,
	[ERR_LOOT_MASTER_INV_FULL] = true,
	[ERR_LOOT_MASTER_OTHER] = true,
	[ERR_LOOT_MASTER_UNIQUE_ITEM] = true,
	[ERR_NOT_ENOUGH_MONEY] = true,
	[ERR_QUEST_LOG_FULL] = true,
}

function NoError:OnEvent(event, msg)
	if self.Filter[msg] then
		UIErrorsFrame:AddMessage(msg, 1, 0, 0)
	end	
end

UIErrorsFrame:UnregisterEvent("UI_ERROR_MESSAGE")
NoError:RegisterEvent("UI_ERROR_MESSAGE")
NoError:SetScript("OnEvent", NoError.OnEvent)