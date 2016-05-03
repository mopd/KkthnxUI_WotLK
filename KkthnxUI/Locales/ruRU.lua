local K, C, L, _ = unpack(select(2, ...))
if K.Client == "ruRU" then
	-- AddonList Localization
	L_ADDON_DISABLE_ALL = "Выключить все"
	L_ADDON_ENABLE_ALL = "Включить все"
	L_ADDON_LIST = "|cff3AA0E9AddonList|r"
	L_ADDON_RELOAD = "Перезагрузить"
	-- Announce Localization
	L_ANNOUNCE_INTERRUPTED = INTERRUPTED.." %s's \124cff71d5ff\124Hspell:%d\124h[%s]\124h\124r!"
	L_ANNOUNCE_PC_ABORTED = "Pull ABORTED!"
	L_ANNOUNCE_PC_GO = "GO!"
	L_ANNOUNCE_PC_MSG = "Pulling %s in %s.."
	-- Bags Localization
	L_BAG_BAGS_BIDS = "Использование сумок: "
	L_BAG_BUY_BANKS_SLOT = "buy bank slot. (need to have bank open)"
	L_BAG_BUY_SLOTS = "Buy new slot with /bags purchase yes"
	L_BAG_COSTS = "Cost: %.2f gold"
	L_BAG_NOTHING_SORT = "Nothing to sort."
	L_BAG_NO_SLOTS = "can't buy anymore slots!"
	L_BAG_OPEN_BANK = "You need to open your bank first."
	L_BAG_SHOW_BAGS = "Показать сумки"
	L_BAG_SORT = "sort your bags or your bank, if open."
	L_BAG_SORTING_BAGS = "Сортировка завершена."
	L_BAG_SORT_MENU = "Сортировать"
	L_BAG_SORT_SPECIAL = "Сортировать Special"
	L_BAG_STACK = "fill up partial stacks in your bags or bank, if open."
	L_BAG_STACK_END = "Сборка завершена."
	L_BAG_STACK_MENU = "Собрать"
	L_BAG_STACK_SPECIAL = "Собрать Special"
	-- Bindings Localization
	L_BIND_BINDING = "Назначение"
	L_BIND_CLEARED = "Сброшены все назначения для"
	L_BIND_DISCARD = "All newly set keybindings have been discarded."
	L_BIND_INSTRUCT = "Hover your mouse over any actionbutton to bind it. Press the escape key or right click to clear the current actionbutton's keybinding."
	L_BIND_KEY = "Клавиша"
	L_BIND_NO_SET = "Нет назначений"
	L_BIND_SAVED = "Все назначения клавиш сохранены."
	-- Chat Localization
	L_CHAT_AFK = "[АФК]"
	L_CHAT_BATTLEGROUND	= "ПБ"
	L_CHAT_BATTLEGROUND_LEADER = "Лидер ПБ"
	L_CHAT_COME_ONLINE = "has come |cff298F00online|r."
	L_CHAT_DND = "[ДНД]"
	L_CHAT_GM = "[ГМ]"
	L_CHAT_GONE_OFFLINE = "has gone |cffff0000offline|r."
	L_CHAT_GUILD = "Г"
	L_CHAT_OFFICER = "Оф."
	L_CHAT_PARTY = "Гр"
	L_CHAT_PARTY_LEADER = "Лидер гр."
	L_CHAT_RAID = "Р"
	L_CHAT_RAID_LEADER = "РЛ"
	L_CHAT_RAID_WARNING = "Объявление"
	L_CHAT_WHISPER = "Шепчет"
	-- Class Localization
	L_CLASS_HUNTER_CONTENT = "Your pet is content!"
	L_CLASS_HUNTER_HAPPY = "Ваш петомец счастлив!"
	L_CLASS_HUNTER_UNHAPPY = "Ваш петомец несчастлив!"
	-- Datatext Localization
	L_DATATEXT_ALTERAC = "Альтеракская долина"
	L_DATATEXT_ANCIENTS = "Берег Древних"
	L_DATATEXT_ARATHI = "Низина Арати"
	L_DATATEXT_BASESASSAULTED = "Штурмы баз:"
	L_DATATEXT_BASESDEFENDED = "Оборона баз:"
	L_DATATEXT_DEMOLISHERSDESTROYED = "Разрушителей уничтожено:"
	L_DATATEXT_EYE = "Око Бури"
	L_DATATEXT_FLAGSCAPTURED = "Захваты флага:"
	L_DATATEXT_FLAGSRETURNED = "Возвраты флага:"
	L_DATATEXT_GATESDESTROYED = "Врат разрушено:"
	L_DATATEXT_GRAVEYARDSASSAULTED = "Штурмы кладбищ:"
	L_DATATEXT_GRAVEYARDSDEFENDED = "Оборона кладбищ:"
	L_DATATEXT_ISLE = "Остров Завоеваний"
	L_DATATEXT_TOWERSASSAULTED = "Штурмы башен:"
	L_DATATEXT_TOWERSDEFENDED = "Оборона башен:"
	L_DATATEXT_WARSONG = "Ущелье Песни Войны"
	-- Info Localization
	L_INFO_DISBAND = "Роспуск группы..."
	L_INFO_DUEL = "Declined duel request from "
	L_INFO_DUEL_DECLINE = "I'm not accepting duels right now"
	L_INFO_ERRORS = "Ошибок пока нет."
	L_INFO_INVITE = "Принято приглашение от "
	L_INFO_NOT_INSTALLED = " не установлен."
	L_INFO_SETTINGS_ALL = "Введите |cff3AA0E9/settings all|r|cffE8CB3B, чтобы применить настройки для всех поддерживаемых аддонов."
	L_INFO_SETTINGS_BIGWIGS = "Введите |cff3AA0E9/settings bigwigs|r|cffE8CB3B, чтобы применить настройки |cff3AA0E9Bigwigs|r."
	L_INFO_SETTINGS_BT4 = "Введите |cff3AA0E9/settings bartender4|r|cffE8CB3B, чтобы применить настройки |cff3AA0E9Bartender4|r."
	L_INFO_SETTINGS_BUTTONFACADE = "Введите |cff3AA0E9/settings bfacade|r|cffE8CB3B, чтобы применить настройки |cff3AA0E9ButtonFacade|r."
	L_INFO_SETTINGS_CHATCONSOLIDATE = "Введите |cff3AA0E9/settings chatfilter|r|cffE8CB3B, чтобы применить настройки |cff3AA0E9ChatConsolidate|r."
	L_INFO_SETTINGS_CLASSCOLOR = "Введите |cff3AA0E9/settings color|r|cffE8CB3B, чтобы применить настройки |cff3AA0E9!ClassColor|r."
	L_INFO_SETTINGS_CLASSTIMER = "Введите |cff3AA0E9/settings classtimer|r|cffE8CB3B, чтобы применить настройки |cff3AA0E9ClassTimer|r."
	L_INFO_SETTINGS_MAPSTER = "Введите |cff3AA0E9/settings mapster|r|cffE8CB3B, чтобы применить настройки |cff3AA0E9Mapster|r."
	L_INFO_SETTINGS_MSBT = "Введите |cff3AA0E9/settings msbt|r|cffE8CB3B, чтобы применить настройки |cff3AA0E9MikScrollingBattleText|r."
	L_INFO_SETTINGS_PLATES = "Введите |cff3AA0E9/settings nameplates|r|cffE8CB3B, чтобы применить настройки |cff3AA0E9Nameplates|r."
	L_INFO_SETTINGS_SKADA = "Введите |cff3AA0E9/settings skada|r|cffE8CB3B, чтобы применить настройки |cff3AA0E9Skada|r."
	L_INFO_SETTINGS_THREATPLATES = "Необходимо изменить положение элементов |cff3AA0E9TidyPlates_ThreatPlates|r."
	L_INFO_SETTINGS_XLOOT = "Введите |cff3AA0E9/settings xloot|r|cffE8CB3B, чтобы применить настройки |cff3AA0E9XLoot|r."
	-- Loot Localization
	L_LOOT_ANNOUNCE = "Объявить"
	L_LOOT_CANNOT = "Cannot roll"
	L_LOOT_CHEST = ">> Loot from chest"
	L_LOOT_FISH = "Fishing loot"
	L_LOOT_MONSTER = ">> Loot from "
	L_LOOT_RANDOM = "Random Player"
	L_LOOT_SELF = "Self Loot"
	L_LOOT_TO_GUILD = " гильдие"
	L_LOOT_TO_PARTY = " группе"
	L_LOOT_TO_RAID = " рейду"
	L_LOOT_TO_SAY = " сказать"
	-- Mail Localization
	L_MAIL_COMPLETE = "All done."
	L_MAIL_MESSAGES = "messages"
	L_MAIL_NEED = "Need a mailbox."
	L_MAIL_STOPPED = "Stopped, inventory is full."
	L_MAIL_UNIQUE = "Stopped. Found a duplicate unique item in bag or in bank."
	-- Map Localization
	L_MAP_BOUNDS = "За границами!"
	L_MAP_CURSOR = "Курсор: "
	-- Misc Localization
	L_MISC_UI_OUTDATED = "Ваша версия |cff3AA0E9KkthnxUI|r устарела. Вы можете скачать последнюю версию с www.github.com/Kkthnx"
	L_MISC_UNDRESS = "Undress"
	-- Popup Localization
	L_POPUP_ARMORY = "|cffE8CB3BArmory|r"
	L_POPUP_INSTALLUI = "|cff3AA0E9KkthnxUI|r впервые с этим персонажем. Вы должны перезагрузить пользовательский интерфейс, чтобы настроить его."
	L_POPUP_RESETUI = "Вы уверены, что хотите сбросить все настройки |cff3AA0E9KkthnxUI|r?"
	L_POPUP_SETTINGS_ALL = "Применить настройки для всех поддерживаемых аддонов? |cff3AA0E9!!Это рекомендуется!!|r"
	L_POPUP_SETTINGS_BW = "Необходимо изменить положение элементов |cff3AA0E9BigWigs|r."
	L_POPUP_SETTINGS_DBM = "Нам нужно изменить позиция баров |cff3AA0E9DBM|r."
	-- Stats Localization
	L_STATS_GLOBAL = "Глобальная задержка:"
	L_STATS_HOME = "Локальная задержка:"
	L_STATS_INC = "Incoming:"
	L_STATS_OUT = "Outgoing:"
	L_STATS_SYSTEMLEFT = "|cff3AA0E9ЛКМ: Открыть PvE-Frame|r"
	L_STATS_SYSTEMRIGHT = "|cff3AA0E9ПКМ: Clean Memoryusage|r"
	-- Tooltip Localization
	L_TOOLTIP_ACH_COMPLETE = "Ваш статус: завершено "
	L_TOOLTIP_ACH_INCOMPLETE = "Ваш статус: незавершено"
	L_TOOLTIP_ACH_STATUS = "Ваш статус:"
	L_TOOLTIP_ITEM_COUNT = "Кол-во предметов:"
	L_TOOLTIP_ITEM_ID = "ID предмета:"
	L_TOOLTIP_LOADING = "Загрузка..."
	L_TOOLTIP_NO_TALENT = "Нет талантов"
	L_TOOLTIP_SPELL_ID = "ID заклинания:"
	L_TOOLTIP_WHO_TARGET = "Является целью"
	-- Total Memory Localization
	L_TOTALMEMORY_USAGE = "Total Memory Usage:"
	-- WowHead Link Localization
	L_WATCH_WOWHEAD_LINK = "|cffE8CB3BWowhead link|r"
	-- Welcome Localization
	L_WELCOME_LINE_1 = "Добро пожаловать в |cff3AA0E9KkthnxUI|r "
	L_WELCOME_LINE_2_1 = ""
	L_WELCOME_LINE_2_2 = "Введите |cff3AA0E9/uihelp|r или |cff3AA0E9/cfg|r для настройки интерфейса"
	L_WELCOME_LINE_2_3 = ""
	L_WELCOME_LINE_2_4 = "Для получения дополнительной информации посетите |cFF4488FFhttps://github.com/Kkthnx/KkthnxUI-3.3.5|r"
	-- Slash Commands Localization
	L_SLASHCMD_HELP = {
		"|cff3AA0E9Доступные команды:|r",
		"|cff3AA0E9/align|r - |cffE8CB3BBecause everyone loves to align their UI",
		"|cff3AA0E9/bigchat|r - |cffE8CB3BIncrease the size of the chat frame to see more.",
		"|cff3AA0E9/cfg|r - |cffE8CB3BОткрыть настройки|r |cff3AA0E9KkthnxUI|r.",
		"|cff3AA0E9/clc, /clfix|r - |cffE8CB3BFixes the combatlog when it breaks.",
		"|cff3AA0E9/clearchat, /cc|r - |cffE8CB3BClear your focused chat frame.",
		"|cff3AA0E9/clearquests, /clquests|r - |cffE8CB3BFull clears all quests you have.",
		"|cff3AA0E9/dbmtest|r - |cffE8CB3BЗапустить проверку Deadly Boss Mods.",
		"|cff3AA0E9/farmmode|r - |cffE8CB3BУвеличение размера миникарты.",
		"|cff3AA0E9/frame|r - |cffE8CB3BPrints info about the frame you're hovered on.",
		"|cff3AA0E9/fs|r - |cffE8CB3BShow Framestack. Useful for Devs.",
		"|cff3AA0E9/gm|r - |cffE8CB3BOpens GM frame.",
		"|cff3AA0E9/moveui|r - |cffE8CB3BПозволяет перемещать элементы интерфейса.",
		"|cff3AA0E9/rc|r - |cffE8CB3BАктивизирует проверку котовности.",
		"|cff3AA0E9/rd|r - |cffE8CB3BРаспустить группу или рейд.",
		"|cff3AA0E9/resetconfig|r - |cffE8CB3BСбросить настройки |cff3AA0E9KkthnxUI|r.",
		"|cff3AA0E9/resetui|r - |cffE8CB3BСброс общих настроек по умолчанию.",
		"|cff3AA0E9/rl|r - |cffE8CB3BПерезагрузить интерфейс.",
		"|cff3AA0E9/settings ADDON_NAME|r - |cffE8CB3BApplies settings to msbt, dbm, skada, or all addons.",
		"|cff3AA0E9/spec, /ss|r - |cffE8CB3BSwitches between talent spec's.",
		"|cff3AA0E9/teleport|r - |cffE8CB3BТелепортация из случайного подземелья",
		"|cff3AA0E9/testa|r - |cffE8CB3BTest Blizzard alert frames :D.",
		"|cff3AA0E9/toparty, /toraid, /convert|r - |cffE8CB3BSimple convert party to raid.",
		"|cff3AA0E9/tt|r - |cffE8CB3BСообщение цели.",
		"",
		"|cff3AA0E9Hint|r - |cffE8CB3BShift + Alt and click will let you move Petbar & Stancebar."
	}
end