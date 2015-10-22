--[[
   Version 1

   Attempt to detect and stop trade scams where the enemy removes gold or items right before you
   accept.

   Commands:
      /safetrade trust <name>        - toggle people on or off your trust list
      /safetrade trustguild <on|off> - set on to trust all guild members
      /safetrade alwayslock <on|off> - set on to use the Lock button even when not trading anything

   Using:
      1. If you trade anything to an untrusted person, then the Trade button will be replaced with
         Lock. Once both people set up the items and money, click Lock to go into locked mode.
      2. While in locked mode, you can inspect the items and click Trade without worrying about any
         changes. If they do change something, the Trade button will be disabled and you'll have to
         click a Confirm button to continue. If you make a change, then it will start over in
         unlocked mode.

   Limitations:
      * When your item is enchanted, it counts as you making a change. When their item is enchanted,
        it counts as them making a change.
--]]

local tradeFrame    = CreateFrame("frame", nil, UIParent) -- anonymous frame to handle events
SS_SafeTradeOptions = nil -- settings and trusted people - defaults set up in ADDON_LOADED
local inLockPhase   = nil -- if in locked mode where changes aren't allowed
local playerMoney   = nil -- amount of money currently offered by the player, used to track changes
local trustedTrader = nil -- if the current trader is trusted
local confirmTime   = nil -- GetTime() of when Confirm button is shown, to detect scam-like behavior

local GetPlayerTradeMoney = GetPlayerTradeMoney -- local reference

----------------------------------------------------------------------------------------------------
-- GUI elements
----------------------------------------------------------------------------------------------------
-- the Lock / fake Trade button
local tradeLockButton = CreateFrame("Button", "SafeTradeLockButton", TradeFrame, "UIPanelButtonTemplate")
tradeLockButton:SetWidth(85)
tradeLockButton:SetHeight(22)
tradeLockButton:SetPoint("TOPLEFT", TradeFrameTradeButton, "TOPLEFT", 0, 0)
tradeLockButton.text = _G["SafeTradeLockButtonText"] -- the text on this button may change so save it

-- the Confirm button shown when there's a change after locking
local tradeConfirmButton = CreateFrame("Button", "SafeTradeConfirmButton", TradeFrame, "UIPanelButtonTemplate")
tradeConfirmButton:SetWidth(126)
tradeConfirmButton:SetHeight(22)
tradeConfirmButton:SetPoint("TOPLEFT", TradeFrameTradeButton, "TOPLEFT", -172, 0)
_G["SafeTradeConfirmButtonText"]:SetText("Confirm change")
tradeConfirmButton:SetScript("OnShow", function() confirmTime = GetTime() end)

-- the text shown when lock mode is enabled
local tradeLockText = TradeFrame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
tradeLockText:SetPoint("TOPLEFT", TradeFrameTradeButton, "TOPLEFT", -164, -3)
tradeLockText:SetText("Locked")
 
----------------------------------------------------------------------------------------------------
-- handle GUI changes
----------------------------------------------------------------------------------------------------
-- set up the Trade button during unlocked mode - decides whether to enable locking or not
local function SetTradeButton()
   -- first check if the player is trading anything
   local player_is_trading = (GetPlayerTradeMoney() ~= 0) or SS_SafeTradeOptions["alwayslock"]
   if not player_is_trading then
      for i=1,6 do -- don't count the "Will not be traded" item
         if (GetTradePlayerItemLink(i)) ~= nil then
            player_is_trading = true
            break
         end
      end
   end

   if not player_is_trading then
      -- not trading anything, so just show the normal Trade button
      TradeFrameTradeButton:Show()
      tradeLockButton:Hide()
      tradeConfirmButton:Hide()
   else
      -- hide the Trade and Confirm buttons
      TradeFrameTradeButton:Hide()
      tradeConfirmButton:Hide()
      -- show the Lock button in place of the Trade button
      tradeLockButton.text:SetText("Lock")
      tradeLockButton:Enable()
      tradeLockButton:Show()
   end

   -- not in the locked phase, so all changes are allowed
   confirmTime = nil
   inLockPhase = false
   tradeLockText:Hide()
end

-- set the trade as being in the locked phase
local function SetLockPhase()
   tradeConfirmButton:Hide()
   tradeLockButton:Hide()
   TradeFrameTradeButton:Show()
   confirmTime = nil
   inLockPhase = true
   tradeLockText:Show()
end

tradeLockButton:SetScript("OnClick", SetLockPhase)
tradeConfirmButton:SetScript("OnClick", SetLockPhase)

-- watch for changes in the player's set money (because PLAYER_TRADE_MONEY doesn't work on Feenix)
local function SafeTrade_OnUpdate()
   if playerMoney ~= GetPlayerTradeMoney() then
      playerMoney = GetPlayerTradeMoney()
      SetTradeButton()
   end
end

----------------------------------------------------------------------------------------------------
-- handle events
----------------------------------------------------------------------------------------------------
local function SafeTrade_OnEvent(self, event, ...)
   ----------------------------------------
   -- the trade window opened
   ----------------------------------------
   if event == "TRADE_SHOW" then
      -- check if they're a trusted person
      trustedTrader = (SS_SafeTradeOptions["trustguild"] and (GetGuildInfo("npc")) == (GetGuildInfo("player")))
      if not trustedTrader then
         local trader_name = UnitName("npc")
         for name in pairs(SS_SafeTradeOptions["trusted"]) do
             if trader_name == name then
               trustedTrader = true
               break
            end
         end
      end

      if trustedTrader then -- they are trusted, so hide this addon's system
         tradeLockText:Hide()
         tradeLockButton:Hide()
         tradeConfirmButton:Hide()
         TradeFrameTradeButton:Show()
         inLockPhase = false
         confirmTime = nil
      else -- they aren't trusted, so set up this addon's system
         playerMoney = GetPlayerTradeMoney()
         tradeFrame:SetScript("OnUpdate", SafeTrade_OnUpdate)
         SetTradeButton()
      end
      return
   end

   -- only care about changes below if it's not a trusted trader
   if not trustedTrader then
      ----------------------------------------
      -- the player changed an item
      ----------------------------------------
      if event == "TRADE_PLAYER_ITEM_CHANGED" then
         SetTradeButton()
         return
      end
   
      ----------------------------------------
      -- other trader changed something
      ----------------------------------------
      if event == "TRADE_TARGET_ITEM_CHANGED" or event == "TRADE_MONEY_CHANGED" then
         -- if during the locked phase, show the Confirm button
         if inLockPhase then
            TradeFrameTradeButton:Hide()
            tradeLockText:Hide()
            tradeConfirmButton:Show()

            -- change Lock button to look like a fake disabled Trade button (because a lot of things
            -- can enable the real button again so using a fake one is safer/easier than trying to
            -- keep the real one disabled!)
            tradeLockButton.text:SetText("Trade")
            tradeLockButton:Disable()
            tradeLockButton:Show()
         end
         return
      end
   
      ----------------------------------------
      -- the trade window is being closed
      ----------------------------------------
      if event == "TRADE_CLOSED" then
         tradeFrame:SetScript("OnUpdate", nil)
         if confirmTime and confirmTime > GetTime()-3 then
            DEFAULT_CHAT_FRAME:AddMessage("\124cffFF0000WARNING! The trade window closed soon after a change was made during locked mode.\124h\124r")
            DEFAULT_CHAT_FRAME:AddMessage("\124cffFF0000This is common in scams to try to hide a last second change when they did it too soon.\124h\124r")
            confirmTime = nil -- unset because TRADE_CLOSED is received twice
         end
         return
      end
   end

   ----------------------------------------
   -- addon loaded
   ----------------------------------------
   if event == "ADDON_LOADED" then
      if ... == "SS_SafeTrade" then
         tradeFrame:UnregisterEvent("ADDON_LOADED")
         -- set default settings if needed
         if SS_SafeTradeOptions               == nil then SS_SafeTradeOptions               = {}    end
         if SS_SafeTradeOptions["trustguild"] == nil then SS_SafeTradeOptions["trustguild"] = false end
         if SS_SafeTradeOptions["alwayslock"] == nil then SS_SafeTradeOptions["alwayslock"] = false end
         if SS_SafeTradeOptions["trusted"]    == nil then SS_SafeTradeOptions["trusted"]    = {}    end
      end
      return
   end
end

tradeFrame:SetScript("OnEvent", SafeTrade_OnEvent)
tradeFrame:RegisterEvent("TRADE_SHOW")                -- to set up buttons and initiate the system
tradeFrame:RegisterEvent("TRADE_CLOSED")              -- to stop checking for player money changes
-- tradeFrame:RegisterEvent("PLAYER_TRADE_MONEY")     -- to know when the player changes money (doesn't work properly on Feenix)
tradeFrame:RegisterEvent("TRADE_PLAYER_ITEM_CHANGED") -- to know when the player changes items
tradeFrame:RegisterEvent("TRADE_TARGET_ITEM_CHANGED") -- to know when the other trader changes items
tradeFrame:RegisterEvent("TRADE_MONEY_CHANGED")       -- to know when the other trader changes money
tradeFrame:RegisterEvent("ADDON_LOADED")              -- temporary - load/set saved settings

----------------------------------------------------------------------------------------------------
-- /safetrade command
----------------------------------------------------------------------------------------------------
-- show the trusted player list
local function ShowTrustedList()
   local list = ""
   for name in pairs(SS_SafeTradeOptions["trusted"]) do
      if list ~= "" then
         list = list .. ", "
      end
      list = list .. name
   end
   if list ~= "" then
      DEFAULT_CHAT_FRAME:AddMessage("")
      DEFAULT_CHAT_FRAME:AddMessage("Trusted list: " .. list)
   end
end

_G.SlashCmdList["SAFETRADE"] = function(input)
   if not input then return end

   local command, value = input:match("(%w+)%s*(.*)")
   command = command or input -- if using input, then it's a single command without a value
   command = command:lower()
   -- capitalize the value
   if value then
      value = (value:gsub("(%a)(%w*)", function(first,rest) return first:upper()..rest:lower() end))
   end

   local ON_TEXT  = "\124cff00FF00ON\124h\124r"
   local OFF_TEXT = "\124cffFF0000OFF\124h\124r"

   ----------------------------------------
   -- /safetrade trustguild <on|off>
   ----------------------------------------
   if command == "trustguild" then
      if value == "On" then
         SS_SafeTradeOptions["trustguild"] = true
      elseif value == "Off" then
         SS_SafeTradeOptions["trustguild"] = false
      else
         DEFAULT_CHAT_FRAME:AddMessage('Syntax: /safetrade trustguild <"on"|"off">')
      end
      DEFAULT_CHAT_FRAME:AddMessage("Trusting guild members is " .. (SS_SafeTradeOptions["trustguild"] and ON_TEXT or OFF_TEXT) .. ".")
      return
   end

   ----------------------------------------
   -- /safetrade alwayslock <on|off>
   ----------------------------------------
   if command == "alwayslock" then
      if value == "On" then
         SS_SafeTradeOptions["alwayslock"] = true
      elseif value == "Off" then
         SS_SafeTradeOptions["alwayslock"] = false
      else
         DEFAULT_CHAT_FRAME:AddMessage('Syntax: /safetrade alwayslock <"on"|"off">')
      end
      DEFAULT_CHAT_FRAME:AddMessage("Always using the Lock button is " .. (SS_SafeTradeOptions["alwayslock"] and ON_TEXT or OFF_TEXT) .. ".")
      return
   end

   ----------------------------------------
   -- /safetrade trust <name>
   ----------------------------------------
   if command == "trust" then
      if not value or value == "" then
         DEFAULT_CHAT_FRAME:AddMessage('Syntax: /safetrade trust <name>')
         ShowTrustedList()
         return
      end
      -- check if they're already on the list - if so then remove them
      for name in pairs(SS_SafeTradeOptions["trusted"]) do
         if name == value then
            SS_SafeTradeOptions["trusted"][value] = nil
            DEFAULT_CHAT_FRAME:AddMessage("The player " .. value .. " is no longer trusted in trades." )
            return
         end
      end
      -- wasn't found on the list, so add them
      SS_SafeTradeOptions["trusted"][value] = true
      DEFAULT_CHAT_FRAME:AddMessage("The player " .. value .. " is now trusted in trades." )
      return
   end

   ----------------------------------------
   -- no command - show syntax and trusted list
   ----------------------------------------
   DEFAULT_CHAT_FRAME:AddMessage("SafeTrade syntax:")
   DEFAULT_CHAT_FRAME:AddMessage('/safetrade trust <name>')
   DEFAULT_CHAT_FRAME:AddMessage('/safetrade trustguild <"on"|"off"> - now ' .. (SS_SafeTradeOptions["trustguild"] and ON_TEXT or OFF_TEXT))
   DEFAULT_CHAT_FRAME:AddMessage('/safetrade alwayslock <"on"|"off"> - now ' .. (SS_SafeTradeOptions["alwayslock"] and ON_TEXT or OFF_TEXT))
   ShowTrustedList()
end
_G.SLASH_SAFETRADE1 = "/safetrade"
