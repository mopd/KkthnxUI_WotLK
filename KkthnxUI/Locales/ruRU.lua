local K, C, L = unpack(select(2, ...));

if K.Client == "ruRU" then
	-- Keybinds
	L_BIND_BINDING = "Назначение"
	L_BIND_CLEARED = "Сброшены все назначения для"
	L_BIND_DISCARD = "Назначения отменены."
	L_BIND_INSTRUCT = "Наведите курсор на любую кнопку на панели, чтобы назначит ей клавишу. Нажмите правую кнопку мыши или 'Escape', чтобы сбросить назначение для этой кнопки."
	L_BIND_KEY = "Клавиша"
	L_BIND_NO_SET = "Нет назначений"
	L_BIND_SAVED = "Назначения сохранены."
	-- Welcome
	L_WELCOME_LINE_1 = "Добро пожаловать в |cFF4488FFKkthnxUI|r "
	L_WELCOME_LINE_2_1 = ""
	L_WELCOME_LINE_2_2 = "Введите |cFF4488FF/uihelp|r или |cFF4488FF/cfg|r для настройки интерфейса"
	L_WELCOME_LINE_2_3 = ""
	L_WELCOME_LINE_2_4 = "Для получения дополнительной информации посетите |cFF4488FFhttps://github.com/Kkthnx/KkthnxUI-3.3.5|r"
	-- Popups
	L_POPUP_INSTALLUI = "|cFF4488FFKkthnxUI|r впервые с этим персонажем. Вы должны перезагрузить пользовательский интерфейс, чтобы настроить его."
	L_POPUP_RESETUI = "Вы уверены, что хотите сбросить все настройки |cFF4488FFKkthnxUI|r?"
	-- Chat
	L_CHAT_COME_ONLINE = "has come |cff298F00online|r."
	--L_CHAT_DND = "[DND]"
	L_CHAT_GM = "[ГМ]"
	L_CHAT_AFK = "[АФК]"
	L_CHAT_DND = "[ДНД]"
	L_CHAT_GONE_OFFLINE = "has gone |cffff0000offline|r."
	L_CHAT_GUILD = "Г"
	L_CHAT_OFFICER = "Оф."
	L_CHAT_PARTY = "П"
	L_CHAT_PARTY_LEADER = "Лидер гр."
	L_CHAT_RAID = "Р"
	L_CHAT_RAID_LEADER = "РЛ"
	L_CHAT_RAID_WARNING = "Объявление"
	L_CHAT_WHISPER = "Шепчет"
	-- DataText
	L_DATATEXT_ARATHI = "Низина Арати"
	L_DATATEXT_WARSONG = "Ущелье Песни Войны"
	L_DATATEXT_EYE = "Око Бури"
	L_DATATEXT_ALTERAC = "Альтеракская долина"
	L_DATATEXT_ANCIENTS = "Берег Древних"
	L_DATATEXT_ISLE = "Остров Завоеваний"
	L_DATATEXT_BASESASSAULTED = "Штурмы баз:"
	L_DATATEXT_BASESDEFENDED = "Оборона баз:"
	L_DATATEXT_TOWERSASSAULTED = "Штурмы башен:"
	L_DATATEXT_TOWERSDEFENDED = "Оборона башен:"
	L_DATATEXT_FLAGSCAPTURED = "Захваты флага:"
	L_DATATEXT_FLAGSRETURNED = "Возвраты флага:"
	L_DATATEXT_GRAVEYARDSASSAULTED = "Штурмы кладбищ:"
	L_DATATEXT_GRAVEYARDSDEFENDED = "Оборона кладбищ:"
	L_DATATEXT_DEMOLISHERSDESTROYED = "Разрушителей уничтожено:"
	L_DATATEXT_GATESDESTROYED = "Врат разрушено:"
	-- Tooltip
	L_TOOLTIP_SPELL_ID = "ID заклинания:"
	L_TOOLTIP_ITEM_ID = "ID предмета:"
	L_TOOLTIP_NO_TALENT = "Нет талантов"
	L_TOOLTIP_LOADING = "Загрузка..."
	L_TOOLTIP_ACH_STATUS = "Ваш статус:"
	L_TOOLTIP_ACH_COMPLETE = "Ваш статус: завершено "
	L_TOOLTIP_ACH_INCOMPLETE = "Ваш статус: незавершено"
	-- Loot
	L_LOOT_ANNOUNCE = "Объявить"
	L_LOOT_FISH = "Fishing loot"
	L_LOOT_RANDOM = "Random Player"
	L_LOOT_MONSTER = ">> Loot from "
	L_LOOT_CHEST = ">> Loot from chest"
	L_LOOT_SELF = "Self Loot"
	L_LOOT_TO_GUILD = " гильдие"
	L_LOOT_TO_PARTY = " группе"
	L_LOOT_TO_RAID = " рейду"
	L_LOOT_TO_SAY = " сказать"
	-- Mail
	L_MAIL_STOPPED = ERR_INV_FULL
	L_MAIL_COMPLETE = DONE
	L_MAIL_NEED = "Need a mainbox."
	L_MAIL_MESSAGES = "Posts"
	-- Info Strings
	L_INFO_DUEL = "Declined duel request from "
	L_INFO_ERRORS = "Ошибок пока нет."
	L_INFO_INVITE = "Принято приглашение от "
	L_INFO_NOT_INSTALLED = " не установлен."
	-- WoWHead Strings
	L_WATCH_WOWHEAD_LINK = "|cFFFFC445Wowhead link|r"
	-- Profile Strings
	L_INFO_SETTINGS_PLATES = "Введите /settings nameplates, чтобы применить настройки |cffffc700Nameplates|r."
	L_INFO_SETTINGS_ALL = "Введите /settings all, чтобы применить настройки для всех поддерживаемых аддонов."
	L_INFO_SETTINGS_BIGWIGS = "Введите /settings bigwigs, чтобы применить настройки |cffffc700Bigwigs|r."
	L_INFO_SETTINGS_BT4 = "Введите /settings bartender4, чтобы применить настройки |cffffc700Bartender4|r."
	L_INFO_SETTINGS_MAPSTER = "Введите /settings mapster, чтобы применить настройки |cffffc700Mapster|r."
	L_INFO_SETTINGS_BUTTONFACADE = "Введите /settings bfacade, чтобы применить настройки |cffffc700ButtonFacade|r."
	L_INFO_SETTINGS_CLASSCOLOR = "Введите /settings color, чтобы применить настройки |cffffc700!ClassColor|r."
	L_INFO_SETTINGS_MSBT = "Введите /settings msbt, чтобы применить настройки |cffffc700MikScrollingBattleText|r."
	L_INFO_SETTINGS_SKADA = "Введите /settings skada, чтобы применить настройки |cffffc700Skada|r."
	L_INFO_SETTINGS_CHATCONSOLIDATE = "Введите /settings chatfilter, чтобы применить настройки |cffffc700ChatConsolidate|r."
	L_INFO_SETTINGS_XLOOT = "Введите /settings xloot, чтобы применить настройки |cffffc700XLoot|r."
	L_POPUP_SETTINGS_DBM = "Нам нужно изменить позиция баров |cffffc700DBM|r."
	L_INFO_SETTINGS_CLASSTIMER = "Введите /settings classtimer, чтобы применить настройки |cffffc700ClassTimer|r."
	L_POPUP_SETTINGS_BW = "Необходимо изменить положение элементов |cffffc700BigWigs|r."
	L_INFO_SETTINGS_THREATPLATES = "Необходимо изменить положение элементов |cffffc700TidyPlates_ThreatPlates|r."
	L_POPUP_SETTINGS_ALL = "Применить настройки для всех поддерживаемых аддонов? |cffffc700!!Это рекомендуется!!|r"
	-- Slash commands
	L_SLASHCMD_HELP = {
		"Доступные команды:",
		"/cfg - Открыть настройки интерфейса.",
		"/farmmode - Увеличение размера миникарты.",
		"/frame - Description is not ready.",
		"/gm - Opens GM frame.",
		"/ls, /litestats - Помощь для LiteStats.",
		"/moveui - Позволяет перемещать элементы интерфейса.",
		"/rc - Активизирует проверку котовности.",
		"/resetconfig - Сбросить настройки |cFF4488FFKkthnxUI|r_Config.",
		"/resetui - Сброс общих настроек по умолчанию.",
		"/rl - Перезагрузить интерфейс.",
		"/settings ADDON_NAME - Applies settings to msbt, dbm, skada, or all addons.",
		"/spec, /ss - Switches between talent spec's.",
		"/teleport - Телепортация из случайного подземелья.",
		"/tt - Сообщение цели.",
		"/xct - Manage the combat text.",
	}
end