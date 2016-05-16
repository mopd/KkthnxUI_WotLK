local K, C, L, _ = select(2, ...):unpack()
if K.Client == "ruRU" then
	-- AddonList Localization
	L_ADDON_DISABLE_ALL = "Выключить все"
	L_ADDON_ENABLE_ALL = "Включить все"
	L_ADDON_LIST = "|cff2eb6ffAddonList|r"
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
	L_INFO_SETTINGS_ALL = "Введите |cff2eb6ff/settings all|r|cffE8CB3B, чтобы применить настройки для всех поддерживаемых аддонов"
	L_INFO_SETTINGS_BIGWIGS = "Введите |cff2eb6ff/settings bigwigs|r|cffE8CB3B, чтобы применить настройки |cff2eb6ffBigwigs|r"
	L_INFO_SETTINGS_BT4 = "Введите |cff2eb6ff/settings bartender4|r|cffE8CB3B, чтобы применить настройки |cff2eb6ffBartender4|r"
	L_INFO_SETTINGS_BUTTONFACADE = "Введите |cff2eb6ff/settings bfacade|r|cffE8CB3B, чтобы применить настройки |cff2eb6ffButtonFacade|r"
	L_INFO_SETTINGS_CHATCONSOLIDATE = "Введите |cff2eb6ff/settings chatfilter|r|cffE8CB3B, чтобы применить настройки |cff2eb6ffChatConsolidate|r"
	L_INFO_SETTINGS_CLASSCOLOR = "Введите |cff2eb6ff/settings color|r|cffE8CB3B, чтобы применить настройки |cff2eb6ff!ClassColor|r."
	L_INFO_SETTINGS_CLASSTIMER = "Введите |cff2eb6ff/settings classtimer|r|cffE8CB3B, чтобы применить настройки |cff2eb6ffClassTimer|r"
	L_INFO_SETTINGS_MAPSTER = "Введите |cff2eb6ff/settings mapster|r|cffE8CB3B, чтобы применить настройки |cff2eb6ffMapster|r"
	L_INFO_SETTINGS_MSBT = "Введите |cff2eb6ff/settings msbt|r|cffE8CB3B, чтобы применить настройки |cff2eb6ffMikScrollingBattleText|r"
	L_INFO_SETTINGS_PLATES = "Введите |cff2eb6ff/settings nameplates|r|cffE8CB3B, чтобы применить настройки |cff2eb6ffNameplates|r"
	L_INFO_SETTINGS_SKADA = "Введите |cff2eb6ff/settings skada|r|cffE8CB3B, чтобы применить настройки |cff2eb6ffSkada|r"
	L_INFO_SETTINGS_THREATPLATES = "Необходимо изменить положение элементов |cff2eb6ffTidyPlates_ThreatPlates|r"
	L_INFO_SETTINGS_XLOOT = "Введите |cff2eb6ff/settings xloot|r|cffE8CB3B, чтобы применить настройки |cff2eb6ffXLoot|r"
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
	L_MISC_UI_OUTDATED = "Ваша версия |cff2eb6ffKkthnxUI|r устарела. Вы можете скачать последнюю версию с www.github.com/Kkthnx"
	L_MISC_UNDRESS = "Undress"
	-- Popup Localization
	L_POPUP_ARMORY = "|cffE8CB3BArmory|r"
	L_POPUP_INSTALLUI = "|cff2eb6ffKkthnxUI|r впервые с этим персонажем. Вы должны перезагрузить пользовательский интерфейс, чтобы настроить его."
	L_POPUP_RESETUI = "Вы уверены, что хотите сбросить все настройки |cff2eb6ffKkthnxUI|r?"
	L_POPUP_SETTINGS_ALL = "Применить настройки для всех поддерживаемых аддонов? |cff2eb6ff!!Это рекомендуется!!|r"
	L_POPUP_SETTINGS_BW = "Необходимо изменить положение элементов |cff2eb6ffBigWigs|r."
	L_POPUP_SETTINGS_DBM = "Нам нужно изменить позиция баров |cff2eb6ffDBM|r."
	-- Stats Localization
	L_STATS_GLOBAL = "Глобальная задержка:"
	L_STATS_HOME = "Локальная задержка:"
	L_STATS_INC = "Incoming:"
	L_STATS_OUT = "Outgoing:"
	L_STATS_SYSTEMLEFT = "|cff2eb6ffЛКМ: Открыть PvE-Frame|r"
	L_STATS_SYSTEMRIGHT = "|cff2eb6ffПКМ: Clean Memoryusage|r"
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
	L_WELCOME_LINE_1 = "Добро пожаловать в |cff2eb6ffKkthnxUI|r "
	L_WELCOME_LINE_2_1 = ""
	L_WELCOME_LINE_2_2 = "Введите |cff2eb6ff/uihelp|r или |cff2eb6ff/cfg|r для настройки интерфейса"
	-- Slash Commands Localization
	L_SLASHCMD_HELP = {
		"|cff2eb6ffДоступные команды:|r",
		"|cff2eb6ff/align|r - |cffE8CB3BBecause everyone loves to align their UI",
		"|cff2eb6ff/bigchat|r - |cffE8CB3BIncrease the size of the chat frame to see more.",
		"|cff2eb6ff/cfg|r - |cffE8CB3BОткрыть настройки|r |cff2eb6ffKkthnxUI|r.",
		"|cff2eb6ff/clc, /clfix|r - |cffE8CB3BFixes the combatlog when it breaks.",
		"|cff2eb6ff/clearchat, /cc|r - |cffE8CB3BClear your focused chat frame.",
		"|cff2eb6ff/clearquests, /clquests|r - |cffE8CB3BFull clears all quests you have.",
		"|cff2eb6ff/dbmtest|r - |cffE8CB3BЗапустить проверку Deadly Boss Mods.",
		"|cff2eb6ff/farmmode|r - |cffE8CB3BУвеличение размера миникарты.",
		"|cff2eb6ff/frame|r - |cffE8CB3BPrints info about the frame you're hovered on.",
		"|cff2eb6ff/fs|r - |cffE8CB3BShow Framestack. Useful for Devs.",
		"|cff2eb6ff/gm|r - |cffE8CB3BOpens GM frame.",
		"|cff2eb6ff/moveui|r - |cffE8CB3BПозволяет перемещать элементы интерфейса.",
		"|cff2eb6ff/rc|r - |cffE8CB3BАктивизирует проверку котовности.",
		"|cff2eb6ff/rd|r - |cffE8CB3BРаспустить группу или рейд.",
		"|cff2eb6ff/resetconfig|r - |cffE8CB3BСбросить настройки |cff2eb6ffKkthnxUI|r.",
		"|cff2eb6ff/resetui|r - |cffE8CB3BСброс общих настроек по умолчанию.",
		"|cff2eb6ff/rl|r - |cffE8CB3BПерезагрузить интерфейс.",
		"|cff2eb6ff/settings ADDON_NAME|r - |cffE8CB3BApplies settings to msbt, dbm, skada, or all addons.",
		"|cff2eb6ff/spec, /ss|r - |cffE8CB3BSwitches between talent spec's.",
		"|cff2eb6ff/teleport|r - |cffE8CB3BТелепортация из случайного подземелья",
		"|cff2eb6ff/testa|r - |cffE8CB3BTest Blizzard alert frames :D.",
		"|cff2eb6ff/toparty, /toraid, /convert|r - |cffE8CB3BSimple convert party to raid.",
		"|cff2eb6ff/tt|r - |cffE8CB3BСообщение цели.",
		"",
		"|cff2eb6ffHint|r - |cffE8CB3BShift + Alt and click will let you move Petbar & Stancebar."
	}
end