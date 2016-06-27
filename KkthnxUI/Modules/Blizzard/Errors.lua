local K, C, L, _ = select(2, ...):unpack()
if C["Error"].enable ~= true then return end

-- Error Whitelist > Thanks to Lars *"Goldpaw"* Norberg
local Errors = CreateFrame("Frame")
Errors.Filter = {
	[ERR_ABILITY_COOLDOWN] = true, -- "Ability is not ready yet."

	[ERR_ATTACK_CHANNEL] = true, -- "Can't attack while channeling."
	[ERR_ATTACK_CHARMED] = true, -- "Can't attack while charmed."
	[ERR_ATTACK_CONFUSED] = true, -- "Can't attack while confused."
	[ERR_ATTACK_DEAD] = true, -- "Can't attack while dead."
	[ERR_ATTACK_FLEEING] = true, -- "Can't attack while fleeing."
	[ERR_ATTACK_MOUNTED] = true, -- "Can't attack while mounted."
	[ERR_ATTACK_PACIFIED] = true, -- "Can't attack while pacified."
	[ERR_ATTACK_STUNNED] = true, -- "Can't attack while stunned."

	[ERR_BADATTACKFACING] = true, -- "You are facing the wrong way!"; -- Melee combat error
	[ERR_BADATTACKPOS] = true, -- "You are too far away!"; -- Melee combat error

	[ERR_BAG_FULL] = true, -- "That bag is full."
	[ERR_BANK_FULL] = true, -- "Your bank is full."

	[ERR_DOOR_LOCKED] = true, -- "The door is locked."

	[ERR_EXHAUSTION_EXHAUSTED] = true, -- "You feel exhausted."
	[ERR_EXHAUSTION_NORMAL] = true, -- "You are no longer rested."
	[ERR_EXHAUSTION_RESTED] = true, -- "You feel rested."
	[ERR_EXHAUSTION_TIRED] = true, -- "You feel tired."
	[ERR_EXHAUSTION_WELLRESTED] = true, -- "You feel well rested."

	[ERR_FISH_ESCAPED] = true, -- "Your fish got away!"
	[ERR_FISH_NOT_HOOKED] = true, -- "No fish are hooked."
	[ERR_FOOD_COOLDOWN] = true, -- "You are too full to eat more now."

	[ERR_GENERIC_NO_TARGET] = true, -- "You have no target."
	[ERR_GENERIC_NO_VALID_TARGETS] = true, -- "No valid targets."
	[ERR_GENERIC_STUNNED] = true, -- "You are stunned"

	[ERR_INVALID_ATTACK_TARGET] = true, -- "You cannot attack that target."
	[ERR_INVALID_FOLLOW_TARGET] = true, -- "You can't follow that unit."

	[ERR_INV_FULL] = true, -- "Inventory is full."

	[ERR_ITEM_CANT_BE_DESTROYED] = true, -- "That item cannot be destroyed.";
	[ERR_ITEM_COOLDOWN] = true, -- "Item is not ready yet."
	[ERR_ITEM_LOCKED] = true, -- "Item is locked.";
	[ERR_ITEM_MAX_COUNT] = true, -- "You can't carry any more of those items."

	[ERR_LOOT_ROLL_PENDING] = true, -- "That item is still being rolled for";
	[ERR_LOOT_STUNNED] = true, -- "You can't loot anything while stunned!";
	[ERR_LOOT_TOO_FAR] = true, -- "You are too far away to loot that corpse.";
	[ERR_LOOT_WHILE_INVULNERABLE] = true, -- "Cannot loot while invulnerable.";

	[ERR_NOT_ENOUGH_MONEY] = true, -- "You don't have enough money."
	[ERR_NOT_WHILE_DISARMED] = true, -- "You can't do that while disarmed"
	[ERR_NOT_WHILE_FALLING] = true, -- "You can't do that while jumping or falling"
	[ERR_NOT_WHILE_FATIGUED] = true, -- "You can't do that while fatigued"
	[ERR_NOT_WHILE_MOUNTED] = true, -- "You can't do that while mounted."
	[ERR_NOT_WHILE_SHAPESHIFTED] = true, -- "You can't do that while shapeshifted."

	[ERR_NO_ATTACK_TARGET] = true, -- "There is nothing to attack."

	[ERR_OUT_OF_ENERGY] = true, -- "Not enough energy"
	[ERR_OUT_OF_FOCUS] = true, -- "Not enough focus"
	[ERR_OUT_OF_HEALTH] = true, -- "Not enough health"
	[ERR_OUT_OF_MANA] = true, -- "Not enough mana"
	[ERR_OUT_OF_RAGE] = true, -- "Not enough rage"
	[ERR_OUT_OF_RANGE] = true, -- "Out of range."
	[ERR_OUT_OF_RUNES] = true, -- "Not enough runes"
	[ERR_OUT_OF_RUNIC_POWER] = true, -- "Not enough runic power"

	[ERR_PLAYER_DEAD] = true, -- "You can't do that when you're dead."

	[ERR_POTION_COOLDOWN] = true, -- "You can't do that yet."

	[ERR_PVP_TOGGLE_OFF] = true, -- "PvP combat toggled off"
	[ERR_PVP_TOGGLE_ON] = true, -- "PvP combat toggled on"

	[ERR_SPELL_COOLDOWN] = true, -- "Spell is not ready yet."
	[ERR_SPELL_OUT_OF_RANGE] = true, -- "Out of range."

	[ERR_TOO_FAR_TO_ATTACK] = true, -- "You are too far away from your victim!"
	[ERR_TOO_FAR_TO_INTERACT] = true, -- "You need to be closer to interact with that target."
	[ERR_TOO_MUCH_GOLD] = true, -- "At gold limit"

	[ERR_USE_BAD_ANGLE] = true, -- "You aren't facing the right angle!"
	[ERR_USE_CANT_IMMUNE] = true, -- "You can't do that while you are immune."
	[ERR_USE_CANT_OPEN] = true, -- "You can't open that."
	[ERR_USE_DESTROYED] = true, -- "That is destroyed."
	[ERR_USE_LOCKED] = true, -- "Item is locked."
	[ERR_USE_OBJECT_MOVING] = true, -- "Object is in motion."
	[ERR_USE_SPELL_FOCUS] = true, -- "Object is a spell focus."
	[ERR_USE_TOO_FAR] = true, -- "You are too far away."

	[ERR_VENDOR_TOO_FAR] = true, -- "You are too far away."

	[POTION_TIMER] = true, -- "You can't do that yet."

	[SPELL_FAILED_AFFECTING_COMBAT] = true, -- "You are in combat"
	[SPELL_FAILED_ALREADY_BEING_TAMED] = true, -- "That creature is already being tamed"
	[SPELL_FAILED_ALREADY_HAVE_CHARM] = true, -- "You already control a charmed creature"
	[SPELL_FAILED_ALREADY_HAVE_SUMMON] = true, -- "You already control a summoned creature"
	[SPELL_FAILED_ALREADY_OPEN] = true, -- "Already open"
	[SPELL_FAILED_AURA_BOUNCED] = true, -- "A more powerful spell is already active"
	[SPELL_FAILED_BAD_IMPLICIT_TARGETS] = true, -- "No target"
	[SPELL_FAILED_BAD_TARGETS] = true, -- "Invalid target"
	[SPELL_FAILED_CANT_CAST_ON_TAPPED] = true, -- "Target is tapped"
	[SPELL_FAILED_CASTER_AURASTATE] = true, -- "You can't do that yet"
	[SPELL_FAILED_CASTER_DEAD] = true, -- "You are dead"
	[SPELL_FAILED_CASTER_DEAD_FEMALE] = true, -- "You are dead"
	[SPELL_FAILED_CAST_NOT_HERE] = true, -- "You can't cast that here"
	[SPELL_FAILED_CHARMED] = true, -- "Can't do that while charmed"
	[SPELL_FAILED_CHEST_IN_USE] = true, -- "That is already being used"
	[SPELL_FAILED_CONFUSED] = true, -- "Can't do that while confused"
	[SPELL_FAILED_FIZZLE] = true, -- "Fizzled"
	[SPELL_FAILED_FLEEING] = true, -- "Can't do that while fleeing"
	[SPELL_FAILED_HIGHLEVEL] = true, -- "Target is too high level"
	[SPELL_FAILED_IMMUNE] = true, -- "Immune"
	[SPELL_FAILED_INCORRECT_AREA] = true, -- "You are in the wrong zone."
	[SPELL_FAILED_INTERRUPTED] = true, -- "Interrupted"
	[SPELL_FAILED_INTERRUPTED_COMBAT] = true, -- "Interrupted"
	[SPELL_FAILED_ITEM_NOT_READY] = true, -- "Item is not ready yet"
	[SPELL_FAILED_LINE_OF_SIGHT] = true, -- "Target not in line of sight"
	[SPELL_FAILED_MOVING] = true, -- "Can't do that while moving"
	[SPELL_FAILED_NOPATH] = true, -- "No path available"
	[SPELL_FAILED_NOTHING_TO_DISPEL] = true, -- "Nothing to dispel"
	[SPELL_FAILED_NOTHING_TO_STEAL] = true, -- "Nothing to steal"
	[SPELL_FAILED_NOT_BEHIND] = true, -- "You must be behind your target."
	[SPELL_FAILED_NOT_FLYING] = true, -- "You are flying."
	[SPELL_FAILED_NOT_HERE] = true, -- "You can't use that here."
	[SPELL_FAILED_NOT_IDLE] = true, -- "Can't use while Idle"
	[SPELL_FAILED_NOT_INACTIVE] = true, -- "Can't use while Inactive"
	[SPELL_FAILED_NOT_INFRONT] = true, -- "You must be in front of your target."
	[SPELL_FAILED_NOT_IN_ARENA] = true, -- "You can't do that in an arena."
	[SPELL_FAILED_NOT_IN_BARBERSHOP] = true, -- "You can't do that while in the barber shop"
	[SPELL_FAILED_NOT_IN_BATTLEGROUND] = true, -- "You can't do that in a battleground."
	[SPELL_FAILED_NOT_IN_CONTROL] = true, -- "You are not in control of your actions"
	[SPELL_FAILED_NOT_IN_RAID_INSTANCE] = true, -- "You can't do that in a raid instance."
	[SPELL_FAILED_NOT_KNOWN] = true, -- "Spell not learned"
	[SPELL_FAILED_NOT_MOUNTED] = true, -- "You are mounted."
	[SPELL_FAILED_NOT_ON_DAMAGE_IMMUNE] = true, -- "Spell cannot be cast on a damage immune target."
	[SPELL_FAILED_NOT_ON_GROUND] = true, -- "Cannot use on the ground"
	[SPELL_FAILED_NOT_ON_MOUNTED] = true, -- "Spell cannot be cast on a mounted unit."
	[SPELL_FAILED_NOT_ON_SHAPESHIFT] = true, -- "Cannot be cast on shapeshifted target."
	[SPELL_FAILED_NOT_ON_STEALTHED] = true, -- "Spell cannot be cast on stealthed target."
	[SPELL_FAILED_NOT_READY] = true, -- "Not yet recovered"
	[SPELL_FAILED_NOT_SHAPESHIFT] = true, -- "You are in shapeshift form"
	[SPELL_FAILED_NO_CHARGES_REMAIN] = true, -- "No charges remain"
	[SPELL_FAILED_NO_COMBO_POINTS] = true, -- "That ability requires combo points"
	[SPELL_FAILED_NO_DUELING] = true, -- "Dueling isn't allowed here."
	[SPELL_FAILED_NO_ENDURANCE] = true, -- "Not enough endurance"
	[SPELL_FAILED_NO_EVASIVE_CHARGES] = true, -- "You need Evasive Charges"
	[SPELL_FAILED_NO_FISH] = true, -- "There aren't any fish here"
	[SPELL_FAILED_NO_ITEMS_WHILE_SHAPESHIFTED] = true, -- "Can't use items while shapeshifted"
	[SPELL_FAILED_NO_MAGIC_TO_CONSUME] = true, -- "No magic to consume"
	[SPELL_FAILED_NO_MOUNTS_ALLOWED] = true, -- "You can't mount here."
	[SPELL_FAILED_NO_PET] = true, -- "You do not have a pet"
	[SPELL_FAILED_ONLY_ABOVEWATER] = true, -- "Cannot use while swimming"[SPELL_FAILED_NO_FISH = "There aren't any fish here";
	[SPELL_FAILED_ONLY_BATTLEGROUNDS] = true, -- "Can only use in battlegrounds"
	[SPELL_FAILED_ONLY_DAYTIME] = true, -- "Can only use during the day"
	[SPELL_FAILED_ONLY_INDOORS] = true, -- "Can only use indoors"
	[SPELL_FAILED_ONLY_IN_ARENA] = true, -- "You can only do that in an arena."
	[SPELL_FAILED_ONLY_MOUNTED] = true, -- "Can only use while mounted"
	[SPELL_FAILED_ONLY_NIGHTTIME] = true, -- "Can only use during the night"
	[SPELL_FAILED_ONLY_OUTDOORS] = true, -- "Can only use outside"
	[SPELL_FAILED_ONLY_STEALTHED] = true, -- "You must be in stealth mode."
	[SPELL_FAILED_ONLY_UNDERWATER] = true, -- "Can only use while swimming"
	[SPELL_FAILED_OUT_OF_RANGE] = true, -- "Out of range"
	[SPELL_FAILED_PACIFIED] = true, -- "Can't use that ability while pacified"
	[SPELL_FAILED_SPELL_IN_PROGRESS] = true, -- "Another action is in progress"
	[SPELL_FAILED_TARGET_ENEMY] = true, -- "Target is hostile"
	[SPELL_FAILED_TARGET_FRIENDLY] = true, -- "Target is friendly"
	[SPELL_FAILED_TOO_CLOSE] = true, -- "Target too close"
	[SPELL_FAILED_TOO_CLOSE] = true, -- "Target too close"
	[SPELL_FAILED_TOO_MANY_OF_ITEM] = true, -- "You have too many of that item already"
	[SPELL_FAILED_TOO_SHALLOW] = true, -- "Water too shallow"
	[SPELL_FAILED_UNIT_NOT_BEHIND] = true, -- "Target needs to be behind you."
	[SPELL_FAILED_UNIT_NOT_INFRONT] = true, -- "Target needs to be in front of you."

	[TOO_FAR_TO_LOOT] = true, -- "You are too far away to loot that corpse!"; -- The player is too far away to loot a corpse
}

function Errors:OnEvent(event, msg)
	if self.Filter[msg] then
		UIErrorsFrame:AddMessage(msg, 1, 0, 0)
	end
end

UIErrorsFrame:UnregisterEvent("UI_ERROR_MESSAGE")
Errors:RegisterEvent("UI_ERROR_MESSAGE")
Errors:SetScript("OnEvent", Errors.OnEvent)