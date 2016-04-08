local K, C, L = unpack(select(2, ...))
if C["announcements"].interrupt ~= true then return end

--	Announce your interrupts
local InterruptAnnounce = CreateFrame( "Frame" )
InterruptAnnounce:RegisterEvent( "COMBAT_LOG_EVENT_UNFILTERED" )
InterruptAnnounce:SetScript( "OnEvent", function( self, _, ... )
	local event, sourceGUID, destName, spellID, spellName
	_, event, _, sourceGUID, _, _, _, _, destName, _, _, _, _, _, spellID, spellName = ...

	if not( event == "SPELL_INTERRUPT" and sourceGUID == UnitGUID( "player" ) ) then return end

	if( GetRealNumRaidMembers() > 0 ) then
		SendChatMessage( INTERRUPTED .. " " .. destName .. "'s \124cff71d5ff\124Hspell:" .. spellID .. "\124h[" .. spellName .. "]\124h\124r!", "RAID", nil, nil )
	elseif( GetRealNumPartyMembers() > 0 ) then
		SendChatMessage( INTERRUPTED .. " " .. destName .. "'s \124cff71d5ff\124Hspell:" .. spellID .. "\124h[" .. spellName .. "]\124h\124r!", "PARTY", nil, nil )
	else
		SendChatMessage( INTERRUPTED .. " " .. destName .. "'s \124cff71d5ff\124Hspell:" .. spellID .. "\124h[" .. spellName .. "]\124h\124r!", "SAY", nil, nil )
	end
end )