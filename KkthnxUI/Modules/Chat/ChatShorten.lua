local _G = _G; local hooks = {}

local function AddMessage(frame, channel, ...)
    channel = tostring(channel) or ""

    channel = channel:gsub("%[Battleground%]", "[BG]")
    channel = channel:gsub("%[Battleground Leader%]", "[BGL]")
    channel = channel:gsub("%[Guild%]", "[G]")
    channel = channel:gsub("%[Officer%]", "[O]")
    channel = channel:gsub("%[Party%]", "[P]")
    channel = channel:gsub("%[Raid Leader%]", "[RL]")
    channel = channel:gsub("%[Raid%]", "[R]")
    channel = channel:gsub("%[Raid Warning%]", "[RW]")
	channel = channel:gsub("%[Party Leader%]", "[PL]")

    -- Numbered channels
    channel = channel:gsub("%[(%d+)%. General%]", "[%1. G]")
    channel = channel:gsub("%[(%d+)%. GuildRecruitment%]", "[%1. GR]")
    channel = channel:gsub("%[(%d+)%. LocalDefense%]", "[%1. LD]")
    channel = channel:gsub("%[(%d+)%. LookingForGroup%]", "[%1. LFG]")
    channel = channel:gsub("%[(%d+)%. Trade%]", "[%1. T]")
    channel = channel:gsub("%[(%d+)%. WorldDefense%]", "[%1. WD]")

    -- Comment/uncomment the following line to toggle time stamps
    -- channel = "|cff20b2aa"..date("%H:%M").."|||r "..channel

    return hooks[frame](frame, channel, ...)
end

for i=1, 1 do -- NUM_CHAT_WINDOWS
    frame = _G["ChatFrame"..i]
    hooks[frame] = frame.AddMessage
    frame.AddMessage = AddMessage
end
