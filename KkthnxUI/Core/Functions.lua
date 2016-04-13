local K, C, L = unpack(select(2, ...));

-- Backdrops
K.Backdrop = { bgFile = C["media"].blank, edgeFile = C["media"].blizz, edgeSize = 14, insets = { left = 2.5, right = 2.5, top = 2.5, bottom = 2.5 }}
K.BasicBackdrop = { bgFile = C["media"].blank, tile = true, tileSize = 16, insets = { left = 2.5, right = 2.5, top = 2.5, bottom = 2.5}}
K.SimpleBackdrop = { bgFile = C["media"].blank}
K.ModBackdrop = { bgFile = C["media"].blank, tile = true, tileSize = 16, insets = { left = 8, right = 8, top = 8, bottom = 8}}
K.EdgeBackdrop = { edgeFile = C["media"].blizz, edgeSize = 14, insets = { left = 2.5, right = 2.5, top = 2.5, bottom = 2.5}}
K.BlizBackdrop = { bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background", edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border", tile = true, tileSize = 32, edgeSize = 32, insets = { left = 11, right = 12, top = 12, bottom = 11}}
K.ShadowBackdrop = { bgFile = C["media"].blank, edgeFile = C["media"].glow, edgeSize = 4, insets = { left = 4, right = 4, top = 4, bottom = 4 }}

-- Blizz Style
K.SetBlizzBorder = function(f, size, level, alpha, alphaborder) 
	if( f.BlizzBorder ) then return end
	
	local BlizzBorder = CreateFrame("Frame", nil, f)
	BlizzBorder:SetFrameLevel(level or 0)
	BlizzBorder:SetFrameStrata(f:GetFrameStrata())
	BlizzBorder:SetPoint("TOPLEFT", -size, size )
	BlizzBorder:SetPoint("BOTTOMLEFT", -size, -size)
	BlizzBorder:SetPoint("TOPRIGHT", size, size)
	BlizzBorder:SetPoint("BOTTOMRIGHT", size, -size)
	BlizzBorder:SetBackdrop(K.Backdrop)
	BlizzBorder:SetBackdropColor(0.03, 0.03, 0.03, .9)
	if C["blizzard"].dark_textures == true then
		BlizzBorder:SetBackdropBorderColor(unpack(C["blizzard"].dark_textures_color));
	else
		BlizzBorder:SetBackdropBorderColor(.7, .7, .7, 1)
	end
	f.BlizzBorder = BlizzBorder
	return BlizzBorder
end

-- Shadow Style
K.SetShadowBorder = function(f, size, level, alpha, alphaborder) 
	if( f.ShadowBorder ) then return end

	local ShadowBorder = CreateFrame("Frame", nil, f)
	ShadowBorder:SetFrameLevel(level or 0)
	ShadowBorder:SetFrameStrata(f:GetFrameStrata())
	ShadowBorder:SetPoint("TOPLEFT", -size, size )
	ShadowBorder:SetPoint("BOTTOMLEFT", -size, -size)
	ShadowBorder:SetPoint("TOPRIGHT", size, size)
	ShadowBorder:SetPoint("BOTTOMRIGHT", size, -size)
	ShadowBorder:SetBackdrop( { 
		edgeFile = C["media"].glow, edgeSize = K.Scale( 3 ),
		insets = { left = K.Scale( 5 ), right = K.Scale( 5 ), top = K.Scale( 5 ), bottom = K.Scale( 5 ) },
	} )
	ShadowBorder:SetBackdropColor( 0, 0, 0, 0 )
	ShadowBorder:SetBackdropBorderColor( 0, 0, 0, 0.8 )
	f.ShadowBorder = ShadowBorder
end

K.SetFontString = function( parent, fontName, fontHeight, fontStyle )
	local fs = parent:CreateFontString( nil, "OVERLAY" )
	fs:SetFont( fontName, fontHeight, fontStyle )
	fs:SetJustifyH( "LEFT" )
	fs:SetShadowColor( 0, 0, 0 )
	fs:SetShadowOffset( 1.25, -1.25 )
	return fs
end

-- ShortValue
K.ShortValue = function(v)
	if (v >= 1e6) then
		return gsub(format("%.1fm", v / 1e6), "%.?0+([km])$", "%1")
	elseif (v >= 1e3 or v <= -1e3) then
		return gsub(format("%.1fk", v / 1e3), "%.?0+([km])$", "%1")
	else
		return v
	end
end

-- Rounding
K.Round = function(number, decimals)
	if (not decimals) then
		decimals = 0
	end

	return format(format("%%.%df", decimals), number)
end

-- RGBToHex Color
K.RGBToHex = function(r, g, b)
	r = r <= 1 and r >= 0 and r or 0
	g = g <= 1 and g >= 0 and g or 0
	b = b <= 1 and b >= 0 and b or 0
	
	return format("|cff%02x%02x%02x", r * 255, g * 255, b * 255)
end

K.Role = function()
	local role
	local tree = GetPrimaryTalentTree()
	if( ( K.Class == "PALADIN" and tree == 2 ) or ( K.Class == "WARRIOR" and tree == 3 ) or ( K.Class == "DEATHKNIGHT" and tree == 1 ) ) or ( K.Class == "DRUID" and tree == 2 and GetBonusBarOffset() == 3 ) then
		role = "Tank"
	else
		local playerint = select( 2, UnitStat( "player", 4 ) )
		local playeragi	= select( 2, UnitStat( "player", 2 ) )
		local base, posBuff, negBuff = UnitAttackPower( "player" )
		local playerap = base + posBuff + negBuff

		if( ( ( playerap > playerint ) or ( playeragi > playerint ) ) and not ( K.Class == "SHAMAN" and tree ~= 1 and tree ~= 3 ) and not ( UnitBuff( "player", GetSpellInfo( 24858 ) ) or UnitBuff( "player", GetSpellInfo( 65139 ) ) ) ) or K.Class == "ROGUE" or K.Class == "HUNTER" or ( K.Class == "SHAMAN" and tree == 2 ) then
			role = "Melee"
		else
			role = "Caster"
		end
	end

	return role
end

--Add time before calling a function
local waitTable = {}
local waitFrame
function K.Delay(delay, func, ...)
	if(type(delay)~="number" or type(func)~="function") then
		return false
	end
	if(waitFrame == nil) then
		waitFrame = CreateFrame("Frame","WaitFrame", UIParent)
		waitFrame:SetScript("onUpdate",function (self,elapse)
			local count = #waitTable
			local i = 1
			while(i<=count) do
				local waitRecord = tremove(waitTable,i)
				local d = tremove(waitRecord,1)
				local f = tremove(waitRecord,1)
				local p = tremove(waitRecord,1)
				if(d>elapse) then
					tinsert(waitTable,i,{d-elapse,f,p})
					i = i + 1
				else
					count = count - 1
					f(unpack(p))
				end
			end
		end)
	end
	tinsert(waitTable,{delay,func,{...}})
	return true
end