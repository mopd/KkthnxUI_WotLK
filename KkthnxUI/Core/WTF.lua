local K, C, L, _ = unpack(select(2, ...))

----------------------------------------------------------------------------------------
--	Masque Settings
----------------------------------------------------------------------------------------
local UploadBFacade = function()
	if ButtonFacadeDB then table.wipe(ButtonFacadeDB) end
	ButtonFacadeDB = {
		["profileKeys"] = {
			["Kkthnx - Lordaeron"] = "Default",
		},
		["profiles"] = {
			["Default"] = {
				["Gloss"] = 0,
				["Backdrop"] = true,
				["SkinID"] = "|cff1784d1Kkthnx's|r |cFFFFB200Normal|r",
			},
		},
	}
end

----------------------------------------------------------------------------------------
--	Bartender 4
----------------------------------------------------------------------------------------
local UploadBartender4 = function()
	if Bartender4DB then table.wipe(Bartender4DB) end
	Bartender4DB = {
		["namespaces"] = {
			["ActionBars"] = {
				["profiles"] = {
					["Default"] = {
						["actionbars"] = {
							{
								["showgrid"] = true,
								["rows"] = 2,
								["skin"] = {
									["ID"] = "|cff1784d1Kkthnx's|r |cFFFFB200Normal|r",
								},
								["version"] = 3,
								["position"] = {
									["y"] = -214,
									["x"] = -124.299991607666,
									["point"] = "CENTER",
									["scale"] = 1.1,
								},
								["padding"] = 0,
							}, -- [1]
							{
								["skin"] = {
									["ID"] = "|cff1784d1Kkthnx's|r |cFFFFB200Normal|r",
								},
								["enabled"] = false,
								["version"] = 3,
								["position"] = {
									["y"] = -227.499923706055,
									["x"] = -231.500183105469,
									["point"] = "CENTER",
								},
							}, -- [2]
							{
								["showgrid"] = true,
								["rows"] = 12,
								["skin"] = {
									["ID"] = "|cff1784d1Kkthnx's|r |cFFFFB200Normal|r",
								},
								["enabled"] = false,
								["version"] = 3,
								["position"] = {
									["y"] = -67.9999237060547,
									["x"] = -82,
									["point"] = "RIGHT",
								},
								["padding"] = 3,
							}, -- [3]
							{
								["showgrid"] = true,
								["rows"] = 12,
								["fadeout"] = true,
								["skin"] = {
									["ID"] = "|cff1784d1Kkthnx's|r |cFFFFB200Normal|r",
								},
								["version"] = 3,
								["position"] = {
									["y"] = 242.5499692236002,
									["x"] = -47,
									["point"] = "RIGHT",
									["scale"] = 1.100000023841858,
								},
								["padding"] = 0,
							}, -- [4]
							{
								["showgrid"] = true,
								["skin"] = {
									["ID"] = "|cff1784d1Kkthnx's|r |cFFFFB200Normal|r",
								},
								["version"] = 3,
								["position"] = {
									["y"] = 44,
									["x"] = -243.1,
									["point"] = "BOTTOM",
									["scale"] = 1.1,
								},
								["padding"] = 0,
							}, -- [5]
							{
								["showgrid"] = true,
								["skin"] = {
									["ID"] = "|cff1784d1Kkthnx's|r |cFFFFB200Normal|r",
								},
								["buttons"] = 6,
								["version"] = 3,
								["position"] = {
									["y"] = 246.6,
									["x"] = -124.299991607666,
									["point"] = "BOTTOM",
									["scale"] = 1.1,
								},
								["padding"] = 0,
							}, -- [6]
							{
							}, -- [7]
							nil, -- [8]
							{
							}, -- [9]
							{
							}, -- [10]
						},
					},
				},
			},
			["LibDualSpec-1.0"] = {
			},
			["ExtraActionBar"] = {
				["profiles"] = {
					["Default"] = {
						["version"] = 3,
						["position"] = {
							["y"] = 152.401489257813,
							["x"] = -31.4999389648438,
							["point"] = "BOTTOM",
						},
					},
				},
			},
			["MicroMenu"] = {
				["profiles"] = {
					["Default"] = {
						["enabled"] = false,
						["position"] = {
							["y"] = 41.75,
							["x"] = 37.5,
							["point"] = "BOTTOM",
							["scale"] = 1,
						},
						["skin"] = {
							["ID"] = "|cff1784d1Kkthnx's|r |cFFFFB200Normal|r",
						},
						["version"] = 3,
						["padding"] = -2,
					},
				},
			},
			["XPBar"] = {
				["profiles"] = {
					["Default"] = {
						["position"] = {
							["y"] = 4.0001220703125,
							["x"] = -519,
							["point"] = "TOP",
						},
						["version"] = 3,
					},
				},
			},
			["BlizzardArt"] = {
				["profiles"] = {
					["Default"] = {
						["position"] = {
							["y"] = 47,
							["x"] = -512,
							["point"] = "BOTTOM",
						},
						["version"] = 3,
					},
				},
			},
			["BagBar"] = {
				["profiles"] = {
					["Default"] = {
						["enabled"] = false,
						["position"] = {
							["y"] = 178.288848876953,
							["x"] = 352.98876953125,
							["point"] = "BOTTOM",
						},
						["skin"] = {
							["ID"] = "|cff1784d1Kkthnx's|r |cFFFFB200Normal|r",
						},
						["version"] = 3,
					},
				},
			},
			["StanceBar"] = {
				["profiles"] = {
					["Default"] = {
						["fadeout"] = true,
						["version"] = 3,
						["position"] = {
							["y"] = 207.951248168945,
							["x"] = -19.5,
							["point"] = "BOTTOM",
							["scale"] = 1,
						},
						["skin"] = {
							["ID"] = "|cff1784d1Kkthnx's|r |cFFFFB200Normal|r",
						},
					},
				},
			},
			["Vehicle"] = {
				["profiles"] = {
					["Default"] = {
						["version"] = 3,
						["skin"] = {
							["ID"] = "|cff1784d1Kkthnx's|r |cFFFFB200Normal|r",
						},
						["position"] = {
							["y"] = 77.9999847412109,
							["x"] = 195.562377929688,
							["point"] = "BOTTOM",
						},
					},
				},
			},
			["PetBar"] = {
				["profiles"] = {
					["Default"] = {
						["version"] = 3,
						["skin"] = {
							["ID"] = "|cff1784d1Kkthnx's|r |cFFFFB200Normal|r",
						},
						["padding"] = 0,
						["position"] = {
							["y"] = 78,
							["x"] = -170.499983215332,
							["point"] = "BOTTOM",
							["scale"] = 1.1,
						},
					},
				},
			},
			["RepBar"] = {
				["profiles"] = {
					["Default"] = {
						["position"] = {
							["y"] = 4.0001220703125,
							["x"] = -516.500061035156,
							["point"] = "TOP",
						},
						["version"] = 3,
					},
				},
			},
		},
		["profileKeys"] = {
			["Kkthnx - Lordaeron"] = "Default",
		},
		["profiles"] = {
			["Default"] = {
				["blizzardVehicle"] = true,
				["focuscastmodifier"] = false,
				["onkeydown"] = false,
				["outofrange"] = "hotkey",
			},
		},
	}
end

----------------------------------------------------------------------------------------
--	BigWigs settings
----------------------------------------------------------------------------------------
local UploadBigWigs = function()
	if BigWigs3DB then table.wipe(BigWigs3DB) end
	BigWigs3DB = {
		["namespaces"] = {
			["BigWigs_Plugins_Victory"] = {
			},
			["BigWigs_Plugins_Colors"] = {
			},
			["BigWigs_Plugins_Alt Power"] = {
				["profiles"] = {
					["Default"] = {
						["posx"] = 268.800462238005,
						["fontSize"] = 12,
						["font"] = "Friz Quadrata TT",
						["fontOutline"] = "",
						["posy"] = 58.311036568216,
					},
				},
			},
			["BigWigs_Plugins_BossBlock"] = {
			},
			["BigWigs_Plugins_Bars"] = {
				["profiles"] = {
					["Default"] = {
						["BigWigsEmphasizeAnchor_y"] = 302.222338047295,
						["scale"] = 1.3,
						["BigWigsAnchor_y"] = 155.733239448068,
						["emphasizeGrowup"] = true,
						["BigWigsAnchor_x"] = 4.26666575272876,
						["texture"] = "KkthnxTex",
						["barStyle"] = "BeautyCase",
						["BigWigsAnchor_width"] = 205.999908447266,
						["BigWigsEmphasizeAnchor_width"] = 240,
						["BigWigsEmphasizeAnchor_x"] = 257.422271858322,
						["font"] = "Friz Quadrata TT",
					},
				},
			},
			["BigWigs_Plugins_Super Emphasize"] = {
				["profiles"] = {
					["Default"] = {
						["outline"] = "OUTLINE",
						["font"] = "Friz Quadrata TT",
					},
				},
			},
			["BigWigs_Plugins_Sounds"] = {
			},
			["LibDualSpec-1.0"] = {
			},
			["BigWigs_Plugins_Statistics"] = {
			},
			["BigWigs_Plugins_Messages"] = {
				["profiles"] = {
					["Default"] = {
						["outline"] = "OUTLINE",
						["fontSize"] = 20,
						["BWEmphasizeCountdownMessageAnchor_x"] = 512.710472484414,
						["BWMessageAnchor_x"] = 457.244498919117,
						["BWEmphasizeCountdownMessageAnchor_y"] = 316.444213391669,
						["font"] = "Friz Quadrata TT",
						["BWMessageAnchor_y"] = 406.755522002113,
					},
				},
			},
			["BigWigs_Plugins_Raid Icons"] = {
			},
			["BigWigs_Plugins_Proximity"] = {
				["profiles"] = {
					["Default"] = {
						["fontSize"] = 20,
						["posy"] = 86.0442891928847,
						["posx"] = 936.533442816472,
						["font"] = "Friz Quadrata TT",
					},
				},
			},
			["BigWigs_Plugins_Respawn"] = {
			},
		},
		["profiles"] = {
			["Default"] = {
			},
		},
	}
end

----------------------------------------------------------------------------------------
--	Nameplate settings
----------------------------------------------------------------------------------------
local UploadPlates = function()
	if NameplatesDB then table.wipe(NameplatesDB) end
	NameplatesDB = {
		["profileKeys"] = {
			["Kkthnx - Lordaeron"] = "Default",
		},
		["profiles"] = {
			["Default"] = {
				["hideUninterruptible"] = true,
				["bindings"] = true,
				["text"] = {
					["name"] = "KNORM_Font",
					["shadowEnabled"] = true,
					["size"] = 10,
				},
				["textureName"] = "KkthnxTex",
				["name"] = {
					["name"] = "KNORM_Font",
					["size"] = 11,
					["border"] = "OUTLINE",
					["shadowEnabled"] = true,
				},
				["level"] = {
					["name"] = "KNORM_Font",
					["border"] = "OUTLINE",
					["shadowEnabled"] = true,
				},
			},
			["Kkthnx - Lordaeron"] = {
			},
		},
	}
	
end

----------------------------------------------------------------------------------------
--	!ClassColor settings
----------------------------------------------------------------------------------------
local UploadColor = function()
	if ClassColorsDB then table.wipe(ClassColorsDB) end
	ClassColorsDB = {
		["DEATHKNIGHT"] = {
			["b"] = 0.23,
			["g"] = 0.12,
			["r"] = 0.77,
		},
		["WARRIOR"] = {
			["b"] = 0.43,
			["g"] = 0.61,
			["r"] = 0.78,
		},
		["PALADIN"] = {
			["b"] = 0.73,
			["g"] = 0.55,
			["r"] = 0.96,
		},
		["MAGE"] = {
			["b"] = 0.94,
			["g"] = 0.8,
			["r"] = 0.41,
		},
		["PRIEST"] = {
			["b"] = 0.9803921568627451,
			["g"] = 0.9215686274509803,
			["r"] = 0.8627450980392157,
		},
		["WARLOCK"] = {
			["b"] = 0.79,
			["g"] = 0.51,
			["r"] = 0.58,
		},
		["HUNTER"] = {
			["b"] = 0.45,
			["g"] = 0.83,
			["r"] = 0.67,
		},
		["DRUID"] = {
			["b"] = 0.04,
			["g"] = 0.49,
			["r"] = 1,
		},
		["SHAMAN"] = {
			["b"] = 0.87,
			["g"] = 0.44,
			["r"] = 0,
		},
		["ROGUE"] = {
			["b"] = 0.41,
			["g"] = 0.96,
			["r"] = 1,
		},
	}
	
end

----------------------------------------------------------------------------------------
--	XLoot settings
----------------------------------------------------------------------------------------
local UploadXLoot = function()
	if XLootADB then table.wipe(XLootADB) end
	XLootADB = {
		["namespaces"] = {
			["Group"] = {
				["profiles"] = {
					["Default"] = {
						["hook_alert"] = false,
						["roll_width"] = 300,
						["alert_anchor"] = {
							["visible"] = false,
							["y"] = 807.999694824219,
							["x"] = 645.667053222656,
						},
						["roll_anchor"] = {
							["visible"] = false,
							["x"] = 370.444221494004,
							["scale"] = 1.2,
							["y"] = 454.000302361127,
						},
					},
				},
			},
			["Frame"] = {
				["profiles"] = {
					["Default"] = {
						["frame_color_backdrop"] = {
							0.0941176470588235, -- [1]
							0.0941176470588235, -- [2]
							0.0941176470588235, -- [3]
							0.897589601576328, -- [4]
						},
						["quality_color_frame"] = true,
						["loot_row_height"] = 36,
						["loot_color_backdrop"] = {
							0.0705882352941177, -- [1]
							0.0705882352941177, -- [2]
							0.0705882352941177, -- [3]
							0.900000005960465, -- [4]
						},
						["loot_color_gradient"] = {
							1, -- [1]
							1, -- [2]
							1, -- [3]
							0.0903606414794922, -- [4]
						},
						["loot_collapse"] = true,
						["loot_color_info"] = {
							0.772549019607843, -- [1]
							0.772549019607843, -- [2]
							0.772549019607843, -- [3]
							1, -- [4]
						},
						["frame_color_gradient"] = {
							0.501960784313726, -- [1]
							0.501960784313726, -- [2]
							0.501960784313726, -- [3]
							0, -- [4]
						},
						["loot_icon_size"] = 40,
						["font"] = "Interface\\AddOns\\KkthnxUI\\Media\\Fonts\\Normal.ttf",
					},
				},
			},
			["Master"] = {
			},
		},
		["profiles"] = {
			["Default"] = {
				["skin_anchors"] = true,
				["skin"] = "|cff1784d1KkthnxUI|r",
			},
		},
	}
end

----------------------------------------------------------------------------------------
--	Mapster settings
----------------------------------------------------------------------------------------
local UploadMapster = function()
	if MapsterDB then table.wipe(MapsterDB) end
	MapsterDB = {
		["namespaces"] = {
			["GroupIcons"] = {
			},
			["Coords"] = {
			},
			["FogClear"] = {
				["profiles"] = {
					["Default"] = {
						["version"] = 2,
					},
				},
			},
			["BattleMap"] = {
			},
		},
		["profiles"] = {
			["Default"] = {
				["scale"] = 1.2,
				["mini"] = {
					["scale"] = 1,
					["hideBorder"] = false,
					["disableMouse"] = false,
				},
			},
		},
	}
end

----------------------------------------------------------------------------------------
--	Skada settings
----------------------------------------------------------------------------------------
local UploadSkada = function()
	if SkadaDB then table.wipe(SkadaDB) end
	SkadaDB = {
		["profileKeys"] = {
			["Kkthnx - Lordaeron"] = "Default",
		},
		["profiles"] = {
			["Default"] = {
				["windows"] = {
					{
						["barheight"] = 14,
						["barmax"] = 5,
						["scale"] = 1,
						["barslocked"] = true,
						["background"] = {
							["height"] = 132,
							["color"] = {
								["a"] = 0,
							},
						},
						["barwidth"] = 217,
						["barspacing"] = 7,
						["y"] = 119.0008345294831,
						["x"] = -387.0000836375939,
						["title"] = {
							["height"] = 13,
						},
						["point"] = "BOTTOMRIGHT",
						["enabletitle"] = false,
					}, -- [1]
				},
				["showranks"] = false,
			},
		},
	}
end

----------------------------------------------------------------------------------------
--	MSBT settings
----------------------------------------------------------------------------------------
local UploadMSBT = function()
	if MSBTProfiles_SavedVars then table.wipe(MSBTProfiles_SavedVars) end
	MSBTProfiles_SavedVars = {
		["profiles"] = {
			["Default"] = {
				["critFontName"] = "KDMG_Font",
				["stickyCritsDisabled"] = true,
				["animationSpeed"] = 70,
				["normalFontSize"] = 14,
				["textShadowingDisabled"] = true,
				["creationVersion"] = "5.4.78",
				["critFontSize"] = 24,
				["critOutlineIndex"] = 2,
				["events"] = {
					["NOTIFICATION_COMBAT_ENTER"] = {
						["colorR"] = 0.6980392156862745,
						["colorG"] = 0.1333333333333333,
						["colorB"] = 0.1333333333333333,
					},
					["NOTIFICATION_PC_KILLING_BLOW"] = {
						["disabled"] = true,
					},
					["NOTIFICATION_MONEY"] = {
						["disabled"] = true,
					},
					["NOTIFICATION_ITEM_BUFF_FADE"] = {
						["disabled"] = true,
					},
					["NOTIFICATION_REP_LOSS"] = {
						["disabled"] = true,
					},
					["NOTIFICATION_SKILL_GAIN"] = {
						["disabled"] = true,
					},
					["NOTIFICATION_LOOT"] = {
						["disabled"] = true,
					},
					["NOTIFICATION_SOUL_SHARD_CREATED"] = {
						["alwaysSticky"] = false,
					},
					["INCOMING_HEAL_CRIT"] = {
						["fontSize"] = false,
					},
					["NOTIFICATION_POWER_LOSS"] = {
						["disabled"] = true,
					},
					["NOTIFICATION_REP_GAIN"] = {
						["disabled"] = true,
					},
					["NOTIFICATION_HOLY_POWER_FULL"] = {
						["disabled"] = true,
					},
					["NOTIFICATION_MONSTER_EMOTE"] = {
						["disabled"] = true,
					},
					["NOTIFICATION_COMBAT_LEAVE"] = {
						["colorR"] = 0.1333333333333333,
						["colorG"] = 0.5450980392156862,
						["colorB"] = 0.1333333333333333,
					},
					["NOTIFICATION_POWER_GAIN"] = {
						["disabled"] = true,
					},
					["NOTIFICATION_PET_COOLDOWN"] = {
						["disabled"] = true,
					},
					["NOTIFICATION_HONOR_GAIN"] = {
						["disabled"] = true,
					},
					["NOTIFICATION_BUFF_STACK"] = {
						["disabled"] = true,
					},
					["NOTIFICATION_EXTRA_ATTACK"] = {
						["alwaysSticky"] = false,
						["disabled"] = true,
					},
					["NOTIFICATION_COOLDOWN"] = {
						["disabled"] = true,
					},
					["NOTIFICATION_HOLY_POWER_CHANGE"] = {
						["disabled"] = true,
					},
					["NOTIFICATION_CP_GAIN"] = {
						["disabled"] = true,
					},
					["NOTIFICATION_BUFF_FADE"] = {
						["disabled"] = true,
					},
					["NOTIFICATION_CP_FULL"] = {
						["disabled"] = true,
					},
					["NOTIFICATION_BUFF"] = {
						["disabled"] = true,
					},
					["NOTIFICATION_ITEM_BUFF"] = {
						["disabled"] = true,
					},
				},
				["hideFullOverheals"] = true,
				["scrollAreas"] = {
					["Outgoing"] = {
						["direction"] = "Up",
						["behavior"] = "MSBT_NORMAL",
						["stickyDirection"] = "Up",
						["scrollHeight"] = 150,
						["offsetX"] = 166,
						["stickyBehavior"] = "MSBT_NORMAL",
						["scrollWidth"] = 130,
						["offsetY"] = 10,
						["animationStyle"] = "Straight",
						["stickyAnimationStyle"] = "Static",
					},
					["Notification"] = {
						["direction"] = "Up",
						["critFontSize"] = 16,
						["scrollHeight"] = 100,
						["offsetX"] = -150,
						["normalFontSize"] = 16,
						["scrollWidth"] = 300,
						["offsetY"] = 60,
						["stickyDirection"] = "Up",
						["stickyAnimationStyle"] = "Static",
					},
					["Static"] = {
						["disabled"] = true,
						["offsetY"] = -65,
					},
					["Incoming"] = {
						["direction"] = "Up",
						["behavior"] = "MSBT_NORMAL",
						["stickyDirection"] = "Up",
						["scrollWidth"] = 130,
						["offsetX"] = -296,
						["scrollHeight"] = 150,
						["stickyBehavior"] = "MSBT_NORMAL",
						["offsetY"] = 10,
						["animationStyle"] = "Straight",
						["stickyAnimationStyle"] = "Static",
					},
				},
				["normalFontName"] = "KDMG_Font",
				["normalOutlineIndex"] = 2,
				["triggers"] = {
					["MSBT_TRIGGER_LOW_HEALTH"] = {
						["iconSkill"] = "3273",
						["mainEvents"] = "UNIT_HEALTH{unitID;;eq;;player;;threshold;;lt;;25}",
						["soundFile"] = "Omen: Aoogah!",
					},
					["Custom2"] = {
						["message"] = "New Trigger",
						["alwaysSticky"] = true,
					},
					["MSBT_TRIGGER_LOCK_AND_LOAD"] = {
						["disabled"] = true,
					},
					["MSBT_TRIGGER_TIDAL_WAVES"] = {
						["disabled"] = true,
					},
					["Custom1"] = {
						["message"] = "New Trigger",
						["alwaysSticky"] = true,
					},
					["MSBT_TRIGGER_MAELSTROM_WEAPON"] = {
						["disabled"] = true,
					},
					["MSBT_TRIGGER_NIGHTFALL"] = {
						["disabled"] = true,
					},
					["MSBT_TRIGGER_SWORD_AND_BOARD"] = {
						["disabled"] = true,
					},
					["MSBT_TRIGGER_LAVA_SURGE"] = {
						["disabled"] = true,
					},
					["MSBT_TRIGGER_SUDDEN_DEATH"] = {
						["disabled"] = true,
					},
					["MSBT_TRIGGER_SHADOW_ORB"] = {
						["disabled"] = true,
					},
					["MSBT_TRIGGER_LOW_PET_HEALTH"] = {
						["disabled"] = true,
					},
					["MSBT_TRIGGER_SHOOTING_STARS"] = {
						["disabled"] = true,
					},
					["MSBT_TRIGGER_BLOODSURGE"] = {
						["disabled"] = true,
					},
					["MSBT_TRIGGER_MOLTEN_CORE"] = {
						["disabled"] = true,
					},
					["MSBT_TRIGGER_ECLIPSE_SOLAR"] = {
						["disabled"] = true,
					},
					["MSBT_TRIGGER_LOW_MANA"] = {
						["mainEvents"] = "UNIT_MANA{unitID;;eq;;player;;threshold;;lt;;25}",
					},
					["MSBT_TRIGGER_RIME"] = {
						["disabled"] = true,
					},
					["MSBT_TRIGGER_SHADOW_INFUSION"] = {
						["disabled"] = true,
					},
					["MSBT_TRIGGER_CLEARCASTING"] = {
						["disabled"] = true,
					},
					["MSBT_TRIGGER_VICTORY_RUSH"] = {
						["disabled"] = true,
					},
					["MSBT_TRIGGER_KILLING_MACHINE"] = {
						["disabled"] = true,
					},
					["MSBT_TRIGGER_HOT_STREAK"] = {
						["disabled"] = true,
					},
					["MSBT_TRIGGER_IMPACT"] = {
						["disabled"] = true,
					},
					["MSBT_TRIGGER_ECLIPSE_LUNAR"] = {
						["disabled"] = true,
					},
					["MSBT_TRIGGER_THE_ART_OF_WAR"] = {
						["disabled"] = true,
					},
					["MSBT_TRIGGER_BRAIN_FREEZE"] = {
						["disabled"] = true,
					},
					["MSBT_TRIGGER_TASTE_FOR_BLOOD"] = {
						["disabled"] = true,
					},
				},
			},
		},
	}
end

----------------------------------------------------------------------------------------
--	WeakAuras Settings
----------------------------------------------------------------------------------------
local UploadWeakAuras = function()
	if WeakAurasSaved then table.wipe(WeakAurasSaved) end
	WeakAurasSaved = {
		["login_squelch_time"] = 10,
		["registered"] = {
		},
		["displays"] = {
			["Water Elemental"] = {
				["color"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["untrigger"] = {
				},
				["anchorPoint"] = "CENTER",
				["customTextUpdate"] = "update",
				["actions"] = {
					["start"] = {
					},
					["finish"] = {
						["message_type"] = "CHANNEL",
						["message"] = "Pet is summoned!",
						["do_message"] = false,
						["message_dest"] = "Player",
					},
					["init"] = {
					},
				},
				["fontFlags"] = "OUTLINE",
				["animation"] = {
					["start"] = {
						["type"] = "none",
						["duration_type"] = "seconds",
					},
					["main"] = {
						["type"] = "preset",
						["preset"] = "alphaPulse",
						["duration_type"] = "seconds",
					},
					["finish"] = {
						["type"] = "none",
						["duration_type"] = "seconds",
					},
				},
				["trigger"] = {
					["use_mounted"] = false,
					["use_resting"] = false,
					["use_unit"] = true,
					["unevent"] = "auto",
					["use_vehicle"] = false,
					["subeventPrefix"] = "SPELL",
					["event"] = "Conditions",
					["names"] = {
					},
					["type"] = "status",
					["custom_hide"] = "timed",
					["spellIds"] = {
					},
					["unit"] = "player",
					["subeventSuffix"] = "_CAST_START",
					["use_alive"] = true,
					["use_HasPet"] = false,
					["debuffType"] = "HELPFUL",
				},
				["desaturate"] = false,
				["font"] = "Friz Quadrata TT",
				["height"] = 100,
				["load"] = {
					["talent"] = {
						["multi"] = {
						},
					},
					["spec"] = {
						["single"] = 3,
						["multi"] = {
							[3] = true,
						},
					},
					["difficulty"] = {
						["multi"] = {
						},
					},
					["race"] = {
						["multi"] = {
						},
					},
					["use_spec"] = true,
					["class"] = {
						["single"] = "MAGE",
						["multi"] = {
						},
					},
					["role"] = {
						["multi"] = {
						},
					},
					["use_class"] = true,
					["size"] = {
						["multi"] = {
						},
					},
				},
				["fontSize"] = 18,
				["displayStacks"] = "Resummon",
				["regionType"] = "icon",
				["init_completed"] = 1,
				["parent"] = "Mage - Frost",
				["selfPoint"] = "CENTER",
				["stacksContainment"] = "INSIDE",
				["zoom"] = 0,
				["auto"] = false,
				["id"] = "Water Elemental",
				["additional_triggers"] = {
				},
				["yOffset"] = 164.000244140625,
				["frameStrata"] = 3,
				["width"] = 100,
				["stickyDuration"] = false,
				["numTriggers"] = 1,
				["inverse"] = false,
				["icon"] = true,
				["xOffset"] = -31.9996948242188,
				["displayIcon"] = "Interface\\Icons\\Spell_Frost_SummonWaterElemental_2",
				["stacksPoint"] = "BOTTOM",
				["textColor"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
			},
			["Frozen Orb Ready"] = {
				["color"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["untrigger"] = {
					["spellName"] = 84714,
				},
				["anchorPoint"] = "CENTER",
				["customTextUpdate"] = "update",
				["icon"] = true,
				["fontFlags"] = "OUTLINE",
				["animation"] = {
					["start"] = {
						["type"] = "preset",
						["preset"] = "spiral",
						["duration_type"] = "seconds",
					},
					["main"] = {
						["type"] = "none",
						["duration_type"] = "seconds",
					},
					["finish"] = {
						["type"] = "none",
						["duration_type"] = "seconds",
					},
				},
				["trigger"] = {
					["type"] = "status",
					["spellName"] = 84714,
					["unevent"] = "auto",
					["use_showOn"] = true,
					["custom_hide"] = "timed",
					["event"] = "Cooldown Progress (Spell)",
					["subeventPrefix"] = "SPELL",
					["unit"] = "player",
					["use_spellName"] = true,
					["spellIds"] = {
					},
					["subeventSuffix"] = "_CAST_START",
					["showOn"] = "showOnReady",
					["names"] = {
					},
					["use_unit"] = true,
					["debuffType"] = "HELPFUL",
				},
				["desaturate"] = false,
				["font"] = "Friz Quadrata TT",
				["height"] = 50,
				["load"] = {
					["talent"] = {
						["multi"] = {
						},
					},
					["spec"] = {
						["single"] = 3,
						["multi"] = {
							true, -- [1]
							[3] = true,
						},
					},
					["difficulty"] = {
						["multi"] = {
						},
					},
					["role"] = {
						["multi"] = {
						},
					},
					["class"] = {
						["single"] = "MAGE",
						["multi"] = {
						},
					},
					["use_spec"] = true,
					["race"] = {
						["multi"] = {
						},
					},
					["use_combat"] = true,
					["use_class"] = true,
					["size"] = {
						["multi"] = {
						},
					},
				},
				["fontSize"] = 12,
				["displayStacks"] = "%c",
				["regionType"] = "icon",
				["init_completed"] = 1,
				["parent"] = "Mage - Frost",
				["cooldown"] = false,
				["stacksContainment"] = "INSIDE",
				["zoom"] = 0,
				["auto"] = true,
				["actions"] = {
					["start"] = {
						["do_glow"] = false,
						["glow_action"] = "show",
						["do_sound"] = false,
						["do_custom"] = false,
						["glow_frame"] = "MultiBarBottomRightButton1",
						["sound"] = "Interface\\AddOns\\ElvUI\\media\\sounds\\awwcrap.mp3",
						["sound_channel"] = "Master",
					},
					["finish"] = {
					},
					["init"] = {
					},
				},
				["additional_triggers"] = {
				},
				["stickyDuration"] = false,
				["frameStrata"] = 1,
				["width"] = 50,
				["yOffset"] = -284.999938964844,
				["numTriggers"] = 1,
				["inverse"] = false,
				["xOffset"] = -195.99951171875,
				["id"] = "Frozen Orb Ready",
				["selfPoint"] = "CENTER",
				["stacksPoint"] = "BOTTOMRIGHT",
				["textColor"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
			},
			["Ice Block OFF"] = {
				["xOffset"] = -274,
				["untrigger"] = {
				},
				["anchorPoint"] = "CENTER",
				["customTextUpdate"] = "update",
				["actions"] = {
					["start"] = {
					},
					["finish"] = {
						["sound"] = "Interface\\AddOns\\WeakAuras\\Media\\Sounds\\CatMeow2.mp3",
						["do_sound"] = false,
					},
					["init"] = {
					},
				},
				["fontFlags"] = "OUTLINE",
				["animation"] = {
					["start"] = {
						["type"] = "none",
						["duration_type"] = "seconds",
					},
					["main"] = {
						["type"] = "none",
						["duration_type"] = "seconds",
					},
					["finish"] = {
						["type"] = "none",
						["duration_type"] = "seconds",
					},
				},
				["trigger"] = {
					["type"] = "aura",
					["spellId"] = "32182",
					["subeventSuffix"] = "_CAST_START",
					["event"] = "Health",
					["names"] = {
						"Ice Block", -- [1]
					},
					["custom_hide"] = "timed",
					["use_spellId"] = true,
					["name"] = "Heroism",
					["inverse"] = true,
					["unit"] = "player",
					["spellIds"] = {
					},
					["subeventPrefix"] = "SPELL",
					["debuffType"] = "HELPFUL",
				},
				["desaturate"] = false,
				["progressPrecision"] = 0,
				["font"] = "Friz Quadrata TT",
				["height"] = 32,
				["load"] = {
					["use_never"] = false,
					["talent"] = {
						["single"] = 16,
						["multi"] = {
						},
					},
					["class"] = {
						["single"] = "MAGE",
						["multi"] = {
						},
					},
					["use_talent"] = false,
					["difficulty"] = {
						["multi"] = {
						},
					},
					["race"] = {
						["multi"] = {
						},
					},
					["spec"] = {
						["single"] = 3,
						["multi"] = {
							[3] = true,
						},
					},
					["role"] = {
						["multi"] = {
						},
					},
					["use_combat"] = true,
					["use_class"] = true,
					["size"] = {
						["multi"] = {
						},
					},
				},
				["fontSize"] = 24,
				["displayStacks"] = " ",
				["regionType"] = "icon",
				["parent"] = "Mage - General Procs",
				["stacksPoint"] = "CENTER",
				["icon"] = true,
				["stacksContainment"] = "INSIDE",
				["zoom"] = 0,
				["auto"] = true,
				["additional_triggers"] = {
				},
				["id"] = "Ice Block OFF",
				["selfPoint"] = "CENTER",
				["frameStrata"] = 1,
				["width"] = 32,
				["numTriggers"] = 1,
				["yOffset"] = -265,
				["inverse"] = false,
				["color"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					0.4200000166893, -- [4]
				},
				["stickyDuration"] = false,
				["displayIcon"] = "Interface\\Icons\\Spell_Frost_Frost",
				["cooldown"] = true,
				["textColor"] = {
					1, -- [1]
					0.756862745098039, -- [2]
					0.0117647058823529, -- [3]
					1, -- [4]
				},
			},
			["Mage - General Procs"] = {
				["backdropColor"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					0.5, -- [4]
				},
				["controlledChildren"] = {
					"Cauterize", -- [1]
					"Toxic Power", -- [2]
					"Expanded Mind", -- [3]
					"gfsdfgsdgf", -- [4]
					"Ice Block", -- [5]
					"Ice Block OFF", -- [6]
					"Greater Invisibility", -- [7]
					"Greater Invisibility 2", -- [8]
					"Greater Invisibility OFF", -- [9]
					"Spellsteal", -- [10]
					"doom trink", -- [11]
				},
				["borderBackdrop"] = "Blizzard Tooltip",
				["xOffset"] = -1.99993896484375,
				["border"] = false,
				["yOffset"] = 32.9998168945313,
				["regionType"] = "group",
				["borderSize"] = 16,
				["borderColor"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					0.5, -- [4]
				},
				["expanded"] = false,
				["borderOffset"] = 5,
				["selfPoint"] = "BOTTOMLEFT",
				["id"] = "Mage - General Procs",
				["anchorPoint"] = "CENTER",
				["frameStrata"] = 1,
				["additional_triggers"] = {
				},
				["actions"] = {
					["start"] = {
					},
					["finish"] = {
					},
					["init"] = {
					},
				},
				["borderInset"] = 11,
				["numTriggers"] = 1,
				["animation"] = {
					["start"] = {
						["type"] = "none",
						["duration_type"] = "seconds",
					},
					["main"] = {
						["type"] = "none",
						["duration_type"] = "seconds",
					},
					["finish"] = {
						["type"] = "none",
						["duration_type"] = "seconds",
					},
				},
				["trigger"] = {
					["unit"] = "player",
					["type"] = "aura",
					["spellIds"] = {
					},
					["subeventSuffix"] = "_CAST_START",
					["debuffType"] = "HELPFUL",
					["names"] = {
					},
					["event"] = "Health",
					["subeventPrefix"] = "SPELL",
				},
				["borderEdge"] = "None",
				["load"] = {
					["difficulty"] = {
						["multi"] = {
						},
					},
					["role"] = {
						["multi"] = {
						},
					},
					["use_class"] = "true",
					["talent"] = {
						["multi"] = {
						},
					},
					["spec"] = {
						["multi"] = {
						},
					},
					["class"] = {
						["single"] = "MAGE",
						["multi"] = {
						},
					},
					["race"] = {
						["multi"] = {
						},
					},
					["size"] = {
						["multi"] = {
						},
					},
				},
				["untrigger"] = {
				},
			},
			["Greater Invisibility OFF"] = {
				["xOffset"] = -309,
				["untrigger"] = {
				},
				["anchorPoint"] = "CENTER",
				["customTextUpdate"] = "update",
				["actions"] = {
					["start"] = {
					},
					["finish"] = {
						["sound"] = "Interface\\AddOns\\WeakAuras\\Media\\Sounds\\CatMeow2.mp3",
						["do_sound"] = false,
					},
					["init"] = {
					},
				},
				["fontFlags"] = "OUTLINE",
				["animation"] = {
					["start"] = {
						["type"] = "none",
						["duration_type"] = "seconds",
					},
					["main"] = {
						["type"] = "none",
						["duration_type"] = "seconds",
					},
					["finish"] = {
						["type"] = "none",
						["duration_type"] = "seconds",
					},
				},
				["trigger"] = {
					["type"] = "aura",
					["spellId"] = "110960",
					["subeventSuffix"] = "_CAST_START",
					["fullscan"] = true,
					["event"] = "Health",
					["subeventPrefix"] = "SPELL",
					["name"] = "Greater Invisibility",
					["use_spellId"] = true,
					["inverse"] = true,
					["custom_hide"] = "timed",
					["unit"] = "player",
					["spellIds"] = {
					},
					["names"] = {
						"Greater Invisibility", -- [1]
					},
					["debuffType"] = "HELPFUL",
				},
				["desaturate"] = false,
				["progressPrecision"] = 0,
				["font"] = "Friz Quadrata TT",
				["height"] = 32,
				["load"] = {
					["use_never"] = false,
					["talent"] = {
						["single"] = 16,
						["multi"] = {
						},
					},
					["class"] = {
						["single"] = "MAGE",
						["multi"] = {
						},
					},
					["use_talent"] = false,
					["difficulty"] = {
						["multi"] = {
						},
					},
					["race"] = {
						["multi"] = {
						},
					},
					["spec"] = {
						["single"] = 3,
						["multi"] = {
							[3] = true,
						},
					},
					["role"] = {
						["multi"] = {
						},
					},
					["use_combat"] = true,
					["use_class"] = true,
					["size"] = {
						["multi"] = {
						},
					},
				},
				["fontSize"] = 24,
				["displayStacks"] = " ",
				["regionType"] = "icon",
				["parent"] = "Mage - General Procs",
				["cooldown"] = true,
				["icon"] = true,
				["stacksContainment"] = "INSIDE",
				["zoom"] = 0,
				["auto"] = true,
				["id"] = "Greater Invisibility OFF",
				["additional_triggers"] = {
				},
				["selfPoint"] = "CENTER",
				["frameStrata"] = 1,
				["width"] = 32,
				["numTriggers"] = 1,
				["yOffset"] = -265,
				["inverse"] = false,
				["color"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					0.4200000166893, -- [4]
				},
				["stickyDuration"] = false,
				["displayIcon"] = "Interface\\Icons\\ability_mage_greaterinvisibility",
				["stacksPoint"] = "CENTER",
				["textColor"] = {
					1, -- [1]
					0.756862745098039, -- [2]
					0.0117647058823529, -- [3]
					1, -- [4]
				},
			},
			["Brain Freeze"] = {
				["color"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["untrigger"] = {
				},
				["anchorPoint"] = "CENTER",
				["customTextUpdate"] = "update",
				["actions"] = {
					["start"] = {
						["do_glow"] = false,
						["glow_frame"] = "WeakAuras:Brain Freeze",
						["glow_action"] = "show",
					},
					["finish"] = {
						["sound"] = "Interface\\AddOns\\WeakAuras\\Media\\Sounds\\CatMeow2.mp3",
						["do_sound"] = false,
					},
					["init"] = {
					},
				},
				["fontFlags"] = "OUTLINE",
				["animation"] = {
					["start"] = {
						["type"] = "none",
						["duration_type"] = "seconds",
					},
					["main"] = {
						["type"] = "none",
						["duration_type"] = "seconds",
					},
					["finish"] = {
						["type"] = "none",
						["duration_type"] = "seconds",
					},
				},
				["trigger"] = {
					["type"] = "aura",
					["subeventSuffix"] = "_CAST_START",
					["event"] = "Health",
					["names"] = {
						"Brain Freeze", -- [1]
					},
					["spellIds"] = {
					},
					["debuffType"] = "HELPFUL",
					["unit"] = "player",
					["subeventPrefix"] = "SPELL",
					["custom_hide"] = "timed",
				},
				["desaturate"] = false,
				["progressPrecision"] = 0,
				["font"] = "Friz Quadrata TT",
				["height"] = 32,
				["load"] = {
					["use_never"] = false,
					["talent"] = {
						["single"] = 16,
						["multi"] = {
						},
					},
					["spec"] = {
						["single"] = 3,
						["multi"] = {
							[3] = true,
						},
					},
					["difficulty"] = {
						["multi"] = {
						},
					},
					["race"] = {
						["multi"] = {
						},
					},
					["use_spec"] = true,
					["class"] = {
						["single"] = "MAGE",
						["multi"] = {
						},
					},
					["role"] = {
						["multi"] = {
						},
					},
					["use_class"] = true,
					["size"] = {
						["multi"] = {
						},
					},
				},
				["fontSize"] = 15,
				["displayStacks"] = " %s",
				["regionType"] = "icon",
				["parent"] = "Mage - Frost",
				["stacksPoint"] = "BOTTOMRIGHT",
				["stacksContainment"] = "INSIDE",
				["zoom"] = 0,
				["auto"] = true,
				["icon"] = true,
				["id"] = "Brain Freeze",
				["yOffset"] = -254.000122070312,
				["frameStrata"] = 1,
				["width"] = 32,
				["stickyDuration"] = false,
				["numTriggers"] = 1,
				["inverse"] = false,
				["xOffset"] = -144.999450683594,
				["selfPoint"] = "CENTER",
				["additional_triggers"] = {
				},
				["cooldown"] = true,
				["textColor"] = {
					1, -- [1]
					0.756862745098039, -- [2]
					0.0117647058823529, -- [3]
					1, -- [4]
				},
			},
			["Ice Block"] = {
				["color"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["untrigger"] = {
				},
				["anchorPoint"] = "CENTER",
				["customTextUpdate"] = "update",
				["actions"] = {
					["start"] = {
						["do_glow"] = true,
						["glow_frame"] = "WeakAuras:Ice Block",
						["glow_action"] = "show",
					},
					["finish"] = {
						["sound"] = "Interface\\AddOns\\WeakAuras\\Media\\Sounds\\CatMeow2.mp3",
						["do_sound"] = false,
					},
					["init"] = {
					},
				},
				["fontFlags"] = "OUTLINE",
				["animation"] = {
					["start"] = {
						["type"] = "none",
						["duration_type"] = "seconds",
					},
					["main"] = {
						["type"] = "none",
						["duration_type"] = "seconds",
					},
					["finish"] = {
						["type"] = "none",
						["duration_type"] = "seconds",
					},
				},
				["trigger"] = {
					["type"] = "aura",
					["spellId"] = "32182",
					["subeventSuffix"] = "_CAST_START",
					["event"] = "Health",
					["names"] = {
						"Ice Block", -- [1]
					},
					["use_spellId"] = true,
					["name"] = "Heroism",
					["custom_hide"] = "timed",
					["unit"] = "player",
					["spellIds"] = {
					},
					["subeventPrefix"] = "SPELL",
					["debuffType"] = "HELPFUL",
				},
				["desaturate"] = false,
				["progressPrecision"] = 0,
				["font"] = "Friz Quadrata TT",
				["height"] = 32,
				["load"] = {
					["use_never"] = false,
					["talent"] = {
						["single"] = 16,
						["multi"] = {
						},
					},
					["class"] = {
						["single"] = "MAGE",
						["multi"] = {
						},
					},
					["use_talent"] = false,
					["difficulty"] = {
						["multi"] = {
						},
					},
					["race"] = {
						["multi"] = {
						},
					},
					["spec"] = {
						["single"] = 3,
						["multi"] = {
							[3] = true,
						},
					},
					["role"] = {
						["multi"] = {
						},
					},
					["use_class"] = true,
					["size"] = {
						["multi"] = {
						},
					},
				},
				["fontSize"] = 15,
				["displayStacks"] = " %c",
				["regionType"] = "icon",
				["parent"] = "Mage - General Procs",
				["cooldown"] = true,
				["stacksContainment"] = "INSIDE",
				["zoom"] = 0,
				["auto"] = true,
				["additional_triggers"] = {
				},
				["id"] = "Ice Block",
				["yOffset"] = -264.999877929688,
				["frameStrata"] = 1,
				["width"] = 32,
				["stickyDuration"] = false,
				["numTriggers"] = 1,
				["inverse"] = false,
				["xOffset"] = -273.999938964844,
				["icon"] = true,
				["selfPoint"] = "CENTER",
				["stacksPoint"] = "CENTER",
				["textColor"] = {
					1, -- [1]
					0.756862745098039, -- [2]
					0.0117647058823529, -- [3]
					1, -- [4]
				},
			},
			["Mage Tier 6 Talents"] = {
				["backdropColor"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					0.5, -- [4]
				},
				["controlledChildren"] = {
					"RoP Missing", -- [1]
					"Rune of Power", -- [2]
					"Rune of Power Missing", -- [3]
					"Incanter's Flow 1", -- [4]
					"Incanter's Flow 2", -- [5]
					"Incanter's Flow 3", -- [6]
					"Incanter's Flow 4", -- [7]
					"Incanter's Flow Peak", -- [8]
					"Mirror Image Cooldown", -- [9]
					"Mirror Image Ready", -- [10]
				},
				["borderBackdrop"] = "Blizzard Tooltip",
				["xOffset"] = 0,
				["border"] = false,
				["yOffset"] = 0,
				["regionType"] = "group",
				["borderSize"] = 16,
				["borderColor"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					0.5, -- [4]
				},
				["expanded"] = false,
				["borderOffset"] = 5,
				["selfPoint"] = "BOTTOMLEFT",
				["additional_triggers"] = {
				},
				["anchorPoint"] = "CENTER",
				["frameStrata"] = 1,
				["id"] = "Mage Tier 6 Talents",
				["actions"] = {
					["start"] = {
					},
					["finish"] = {
					},
					["init"] = {
					},
				},
				["borderInset"] = 11,
				["numTriggers"] = 1,
				["animation"] = {
					["start"] = {
						["type"] = "none",
						["duration_type"] = "seconds",
					},
					["main"] = {
						["type"] = "none",
						["duration_type"] = "seconds",
					},
					["finish"] = {
						["type"] = "none",
						["duration_type"] = "seconds",
					},
				},
				["trigger"] = {
					["unit"] = "player",
					["type"] = "aura",
					["spellIds"] = {
					},
					["subeventSuffix"] = "_CAST_START",
					["debuffType"] = "HELPFUL",
					["names"] = {
					},
					["event"] = "Health",
					["subeventPrefix"] = "SPELL",
				},
				["borderEdge"] = "None",
				["load"] = {
					["difficulty"] = {
						["multi"] = {
						},
					},
					["race"] = {
						["multi"] = {
						},
					},
					["use_class"] = "true",
					["talent"] = {
						["multi"] = {
						},
					},
					["class"] = {
						["single"] = "MAGE",
						["multi"] = {
						},
					},
					["spec"] = {
						["multi"] = {
						},
					},
					["role"] = {
						["multi"] = {
						},
					},
					["size"] = {
						["multi"] = {
						},
					},
				},
				["untrigger"] = {
				},
			},
			["Icy Veins Ready"] = {
				["color"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["untrigger"] = {
					["spellName"] = 12472,
				},
				["anchorPoint"] = "CENTER",
				["customTextUpdate"] = "update",
				["icon"] = true,
				["fontFlags"] = "OUTLINE",
				["animation"] = {
					["start"] = {
						["type"] = "preset",
						["preset"] = "spiral",
						["duration_type"] = "seconds",
					},
					["main"] = {
						["type"] = "none",
						["duration_type"] = "seconds",
					},
					["finish"] = {
						["type"] = "none",
						["duration_type"] = "seconds",
					},
				},
				["trigger"] = {
					["type"] = "status",
					["custom_hide"] = "timed",
					["unevent"] = "auto",
					["use_showOn"] = true,
					["spellName"] = 12472,
					["event"] = "Cooldown Progress (Spell)",
					["subeventPrefix"] = "SPELL",
					["unit"] = "player",
					["use_spellName"] = true,
					["spellIds"] = {
					},
					["subeventSuffix"] = "_CAST_START",
					["showOn"] = "showOnReady",
					["names"] = {
					},
					["use_unit"] = true,
					["debuffType"] = "HELPFUL",
				},
				["desaturate"] = false,
				["font"] = "Friz Quadrata TT",
				["height"] = 50,
				["load"] = {
					["talent"] = {
						["multi"] = {
						},
					},
					["spec"] = {
						["single"] = 3,
						["multi"] = {
							true, -- [1]
							[3] = true,
						},
					},
					["difficulty"] = {
						["multi"] = {
						},
					},
					["role"] = {
						["multi"] = {
						},
					},
					["class"] = {
						["single"] = "MAGE",
						["multi"] = {
						},
					},
					["use_spec"] = true,
					["race"] = {
						["multi"] = {
						},
					},
					["use_combat"] = true,
					["use_class"] = true,
					["size"] = {
						["multi"] = {
						},
					},
				},
				["fontSize"] = 12,
				["displayStacks"] = "%c",
				["regionType"] = "icon",
				["init_completed"] = 1,
				["parent"] = "Mage - Frost",
				["cooldown"] = false,
				["stacksContainment"] = "INSIDE",
				["zoom"] = 0,
				["auto"] = true,
				["actions"] = {
					["start"] = {
						["do_glow"] = false,
						["do_sound"] = false,
						["glow_action"] = "show",
						["sound"] = "Interface\\AddOns\\ElvUI\\media\\sounds\\warning.mp3",
						["glow_frame"] = "MultiBarBottomRightButton1",
						["do_custom"] = false,
						["sound_channel"] = "Master",
					},
					["finish"] = {
					},
					["init"] = {
					},
				},
				["additional_triggers"] = {
				},
				["stickyDuration"] = false,
				["frameStrata"] = 1,
				["width"] = 50,
				["yOffset"] = -284.999908447266,
				["numTriggers"] = 1,
				["inverse"] = false,
				["xOffset"] = -305.000610351563,
				["id"] = "Icy Veins Ready",
				["selfPoint"] = "CENTER",
				["stacksPoint"] = "BOTTOMRIGHT",
				["textColor"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
			},
			["gfsdfgsdgf"] = {
				["color"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["untrigger"] = {
				},
				["anchorPoint"] = "CENTER",
				["customTextUpdate"] = "update",
				["actions"] = {
					["start"] = {
						["do_glow"] = false,
						["glow_frame"] = "WeakAuras:Tempus Repit",
						["glow_action"] = "show",
						["sound"] = "Sound\\Spells\\FluteRun.wav",
						["do_sound"] = false,
					},
					["init"] = {
						["do_custom"] = false,
					},
					["finish"] = {
						["sound"] = "Interface\\AddOns\\WeakAuras\\Media\\Sounds\\CatMeow2.mp3",
						["do_sound"] = false,
					},
				},
				["fontFlags"] = "OUTLINE",
				["animation"] = {
					["start"] = {
						["type"] = "none",
						["duration_type"] = "seconds",
					},
					["main"] = {
						["type"] = "none",
						["duration_type"] = "seconds",
					},
					["finish"] = {
						["type"] = "none",
						["duration_type"] = "seconds",
					},
				},
				["trigger"] = {
					["type"] = "aura",
					["subeventSuffix"] = "_CAST_START",
					["event"] = "Health",
					["names"] = {
						"Archmage's Greater Incandescence", -- [1]
					},
					["spellIds"] = {
						177176, -- [1]
					},
					["debuffType"] = "HELPFUL",
					["unit"] = "player",
					["subeventPrefix"] = "SPELL",
					["custom_hide"] = "timed",
				},
				["desaturate"] = false,
				["progressPrecision"] = 0,
				["font"] = "Friz Quadrata TT",
				["height"] = 32,
				["load"] = {
					["use_never"] = false,
					["talent"] = {
						["single"] = 16,
						["multi"] = {
						},
					},
					["spec"] = {
						["single"] = 3,
						["multi"] = {
							[3] = true,
						},
					},
					["use_class"] = true,
					["role"] = {
						["multi"] = {
						},
					},
					["class"] = {
						["single"] = "MAGE",
						["multi"] = {
						},
					},
					["race"] = {
						["multi"] = {
						},
					},
					["difficulty"] = {
						["multi"] = {
						},
					},
					["size"] = {
						["multi"] = {
						},
					},
				},
				["fontSize"] = 15,
				["displayStacks"] = " ",
				["regionType"] = "icon",
				["parent"] = "Mage - General Procs",
				["stacksPoint"] = "CENTER",
				["stacksContainment"] = "INSIDE",
				["zoom"] = 0,
				["auto"] = true,
				["id"] = "gfsdfgsdgf",
				["additional_triggers"] = {
				},
				["yOffset"] = -264.999816894531,
				["frameStrata"] = 1,
				["width"] = 32,
				["stickyDuration"] = false,
				["numTriggers"] = 1,
				["inverse"] = false,
				["xOffset"] = -238,
				["icon"] = true,
				["selfPoint"] = "CENTER",
				["cooldown"] = true,
				["textColor"] = {
					1, -- [1]
					0.756862745098039, -- [2]
					0.0117647058823529, -- [3]
					1, -- [4]
				},
			},
			["Spellsteal"] = {
				["color"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["untrigger"] = {
				},
				["anchorPoint"] = "CENTER",
				["customTextUpdate"] = "update",
				["icon"] = true,
				["fontFlags"] = "OUTLINE",
				["animation"] = {
					["start"] = {
						["type"] = "none",
						["duration_type"] = "seconds",
					},
					["main"] = {
						["type"] = "none",
						["duration_type"] = "seconds",
					},
					["finish"] = {
						["type"] = "preset",
						["preset"] = "grow",
						["duration_type"] = "seconds",
					},
				},
				["trigger"] = {
					["name_operator"] = "match('%s')",
					["subeventSuffix"] = "_CAST_START",
					["fullscan"] = true,
					["custom_hide"] = "timed",
					["event"] = "Health",
					["subeventPrefix"] = "SPELL",
					["autoclone"] = false,
					["use_stealable"] = true,
					["name"] = "*",
					["type"] = "aura",
					["spellIds"] = {
					},
					["names"] = {
					},
					["unit"] = "target",
					["debuffType"] = "HELPFUL",
				},
				["desaturate"] = false,
				["font"] = "Friz Quadrata TT",
				["height"] = 80,
				["load"] = {
					["use_class"] = true,
					["role"] = {
						["multi"] = {
						},
					},
					["difficulty"] = {
						["multi"] = {
						},
					},
					["talent"] = {
						["multi"] = {
						},
					},
					["race"] = {
						["multi"] = {
						},
					},
					["class"] = {
						["single"] = "MAGE",
						["multi"] = {
						},
					},
					["spec"] = {
						["single"] = 3,
						["multi"] = {
							[2] = true,
							[3] = true,
						},
					},
					["size"] = {
						["multi"] = {
						},
					},
				},
				["fontSize"] = 16,
				["displayStacks"] = "%n x%s",
				["regionType"] = "icon",
				["init_completed"] = 1,
				["parent"] = "Mage - General Procs",
				["actions"] = {
					["start"] = {
						["sound"] = "Interface\\Addons\\WeakAuras\\PowerAurasMedia\\Sounds\\sonar.ogg",
						["do_sound"] = true,
					},
					["finish"] = {
					},
					["init"] = {
					},
				},
				["stacksContainment"] = "OUTSIDE",
				["zoom"] = 0,
				["auto"] = true,
				["yOffset"] = -56.9998779296875,
				["additional_triggers"] = {
				},
				["frameStrata"] = 1,
				["alpha"] = 0.5,
				["width"] = 80,
				["stickyDuration"] = false,
				["numTriggers"] = 1,
				["inverse"] = false,
				["xOffset"] = -219.99951171875,
				["id"] = "Spellsteal",
				["selfPoint"] = "CENTER",
				["stacksPoint"] = "LEFT",
				["textColor"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
			},
			["Ice Nova 2 charges"] = {
				["color"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["untrigger"] = {
					["spellName"] = 157997,
				},
				["anchorPoint"] = "CENTER",
				["customTextUpdate"] = "update",
				["actions"] = {
					["start"] = {
						["do_glow"] = false,
						["do_sound"] = true,
						["glow_action"] = "show",
						["sound"] = "Interface\\AddOns\\ElvUI\\media\\sounds\\awwcrap.mp3",
						["glow_frame"] = "MultiBarBottomRightButton1",
						["do_custom"] = false,
						["sound_channel"] = "Master",
					},
					["finish"] = {
					},
					["init"] = {
					},
				},
				["fontFlags"] = "OUTLINE",
				["animation"] = {
					["start"] = {
						["preset"] = "spiral",
						["type"] = "none",
						["duration_type"] = "seconds",
					},
					["main"] = {
						["type"] = "none",
						["duration_type"] = "seconds",
					},
					["finish"] = {
						["type"] = "none",
						["duration_type"] = "seconds",
					},
				},
				["trigger"] = {
					["use_charges"] = true,
					["unit"] = "player",
					["spellName"] = 157997,
					["charges_operator"] = "==",
					["type"] = "status",
					["subeventSuffix"] = "_CAST_START",
					["use_showOn"] = true,
					["custom_hide"] = "timed",
					["event"] = "Cooldown Progress (Spell)",
					["use_unit"] = true,
					["unevent"] = "auto",
					["use_spellName"] = true,
					["spellIds"] = {
					},
					["debuffType"] = "HELPFUL",
					["showOn"] = "showOnReady",
					["charges"] = "2",
					["names"] = {
					},
					["subeventPrefix"] = "SPELL",
				},
				["desaturate"] = false,
				["font"] = "Expressway",
				["height"] = 44,
				["load"] = {
					["talent"] = {
						["single"] = 15,
						["multi"] = {
						},
					},
					["spec"] = {
						["single"] = 3,
						["multi"] = {
							true, -- [1]
							[3] = true,
						},
					},
					["use_talent"] = true,
					["difficulty"] = {
						["multi"] = {
						},
					},
					["race"] = {
						["multi"] = {
						},
					},
					["class"] = {
						["single"] = "MAGE",
						["multi"] = {
						},
					},
					["use_spec"] = true,
					["role"] = {
						["multi"] = {
						},
					},
					["use_combat"] = true,
					["use_class"] = true,
					["size"] = {
						["multi"] = {
						},
					},
				},
				["fontSize"] = 24,
				["displayStacks"] = "%s",
				["regionType"] = "icon",
				["parent"] = "Mage - Frost",
				["stacksPoint"] = "TOP",
				["stacksContainment"] = "OUTSIDE",
				["zoom"] = 0,
				["auto"] = true,
				["icon"] = true,
				["additional_triggers"] = {
				},
				["yOffset"] = -288.000061035156,
				["frameStrata"] = 1,
				["width"] = 44,
				["stickyDuration"] = false,
				["numTriggers"] = 1,
				["inverse"] = false,
				["xOffset"] = -250.999816894531,
				["id"] = "Ice Nova 2 charges",
				["selfPoint"] = "CENTER",
				["cooldown"] = true,
				["textColor"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
			},
			["Ice Nova 1 charge"] = {
				["color"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["untrigger"] = {
					["spellName"] = 157997,
				},
				["anchorPoint"] = "CENTER",
				["customTextUpdate"] = "update",
				["actions"] = {
					["start"] = {
						["do_glow"] = false,
						["glow_action"] = "show",
						["do_sound"] = true,
						["do_custom"] = false,
						["glow_frame"] = "MultiBarBottomRightButton1",
						["sound"] = "Interface\\AddOns\\ElvUI\\media\\sounds\\awwcrap.mp3",
						["sound_channel"] = "Master",
					},
					["finish"] = {
					},
					["init"] = {
					},
				},
				["fontFlags"] = "OUTLINE",
				["animation"] = {
					["start"] = {
						["preset"] = "spiral",
						["type"] = "none",
						["duration_type"] = "seconds",
					},
					["main"] = {
						["type"] = "none",
						["duration_type"] = "seconds",
					},
					["finish"] = {
						["type"] = "none",
						["duration_type"] = "seconds",
					},
				},
				["trigger"] = {
					["use_charges"] = true,
					["unit"] = "player",
					["custom_hide"] = "timed",
					["charges_operator"] = "==",
					["type"] = "status",
					["subeventSuffix"] = "_CAST_START",
					["use_showOn"] = true,
					["spellName"] = 157997,
					["event"] = "Cooldown Progress (Spell)",
					["use_unit"] = true,
					["unevent"] = "auto",
					["use_spellName"] = true,
					["spellIds"] = {
					},
					["debuffType"] = "HELPFUL",
					["showOn"] = "showOnCooldown",
					["charges"] = "1",
					["names"] = {
					},
					["subeventPrefix"] = "SPELL",
				},
				["desaturate"] = false,
				["font"] = "Expressway",
				["height"] = 44,
				["load"] = {
					["talent"] = {
						["single"] = 15,
						["multi"] = {
						},
					},
					["spec"] = {
						["single"] = 3,
						["multi"] = {
							true, -- [1]
							[3] = true,
						},
					},
					["use_talent"] = true,
					["difficulty"] = {
						["multi"] = {
						},
					},
					["race"] = {
						["multi"] = {
						},
					},
					["class"] = {
						["single"] = "MAGE",
						["multi"] = {
						},
					},
					["use_spec"] = true,
					["role"] = {
						["multi"] = {
						},
					},
					["use_combat"] = true,
					["use_class"] = true,
					["size"] = {
						["multi"] = {
						},
					},
				},
				["fontSize"] = 24,
				["displayStacks"] = "%s",
				["regionType"] = "icon",
				["parent"] = "Mage - Frost",
				["cooldown"] = true,
				["stacksContainment"] = "OUTSIDE",
				["zoom"] = 0,
				["auto"] = true,
				["icon"] = true,
				["id"] = "Ice Nova 1 charge",
				["yOffset"] = -288.000091552734,
				["frameStrata"] = 1,
				["width"] = 44,
				["stickyDuration"] = false,
				["numTriggers"] = 1,
				["inverse"] = false,
				["xOffset"] = -251.000061035156,
				["additional_triggers"] = {
				},
				["selfPoint"] = "CENTER",
				["stacksPoint"] = "TOP",
				["textColor"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
			},
			["Mage - Frost"] = {
				["backdropColor"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					0.5, -- [4]
				},
				["controlledChildren"] = {
					"Brain 2", -- [1]
					"Icy Veins", -- [2]
					"Icy Veins Ready", -- [3]
					"Icy Veins Cooldown", -- [4]
					"Frozen Orb Ready", -- [5]
					"Frozen Orb Cooldown", -- [6]
					"Brain Freeze", -- [7]
					" Fingers of Frost", -- [8]
					"Water Elemental", -- [9]
					"Ice Nova 2 charges", -- [10]
					"Ice Nova 1 charge", -- [11]
					"Ice Nova", -- [12]
				},
				["borderBackdrop"] = "Blizzard Tooltip",
				["xOffset"] = 30.9998168945313,
				["border"] = false,
				["yOffset"] = 169.000122070313,
				["regionType"] = "group",
				["borderSize"] = 16,
				["borderColor"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					0.5, -- [4]
				},
				["expanded"] = true,
				["borderOffset"] = 5,
				["selfPoint"] = "BOTTOMLEFT",
				["additional_triggers"] = {
				},
				["anchorPoint"] = "CENTER",
				["frameStrata"] = 1,
				["id"] = "Mage - Frost",
				["actions"] = {
					["start"] = {
					},
					["finish"] = {
					},
					["init"] = {
					},
				},
				["borderInset"] = 11,
				["numTriggers"] = 1,
				["animation"] = {
					["start"] = {
						["type"] = "none",
						["duration_type"] = "seconds",
					},
					["main"] = {
						["type"] = "none",
						["duration_type"] = "seconds",
					},
					["finish"] = {
						["type"] = "none",
						["duration_type"] = "seconds",
					},
				},
				["trigger"] = {
					["unit"] = "player",
					["type"] = "aura",
					["spellIds"] = {
					},
					["subeventSuffix"] = "_CAST_START",
					["debuffType"] = "HELPFUL",
					["names"] = {
					},
					["event"] = "Health",
					["subeventPrefix"] = "SPELL",
				},
				["borderEdge"] = "None",
				["load"] = {
					["difficulty"] = {
						["multi"] = {
						},
					},
					["role"] = {
						["multi"] = {
						},
					},
					["use_class"] = "true",
					["talent"] = {
						["multi"] = {
						},
					},
					["spec"] = {
						["multi"] = {
						},
					},
					["class"] = {
						["single"] = "MAGE",
						["multi"] = {
						},
					},
					["race"] = {
						["multi"] = {
						},
					},
					["size"] = {
						["multi"] = {
						},
					},
				},
				["untrigger"] = {
				},
			},
			["doom trink"] = {
				["color"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["untrigger"] = {
				},
				["anchorPoint"] = "CENTER",
				["customTextUpdate"] = "update",
				["icon"] = true,
				["fontFlags"] = "OUTLINE",
				["animation"] = {
					["start"] = {
						["type"] = "none",
						["duration_type"] = "seconds",
					},
					["main"] = {
						["type"] = "none",
						["duration_type"] = "seconds",
					},
					["finish"] = {
						["type"] = "none",
						["duration_type"] = "seconds",
					},
				},
				["trigger"] = {
					["type"] = "aura",
					["subeventSuffix"] = "_CAST_START",
					["ownOnly"] = true,
					["event"] = "Health",
					["names"] = {
						"Mark of Doom", -- [1]
					},
					["spellIds"] = {
					},
					["debuffType"] = "HARMFUL",
					["unit"] = "target",
					["subeventPrefix"] = "SPELL",
					["custom_hide"] = "timed",
				},
				["desaturate"] = false,
				["font"] = "Friz Quadrata TT",
				["height"] = 32,
				["load"] = {
					["difficulty"] = {
						["multi"] = {
						},
					},
					["race"] = {
						["multi"] = {
						},
					},
					["use_class"] = true,
					["talent"] = {
						["multi"] = {
						},
					},
					["role"] = {
						["multi"] = {
						},
					},
					["spec"] = {
						["multi"] = {
						},
					},
					["class"] = {
						["single"] = "MAGE",
						["multi"] = {
						},
					},
					["size"] = {
						["multi"] = {
						},
					},
				},
				["fontSize"] = 24,
				["displayStacks"] = "%s",
				["regionType"] = "icon",
				["parent"] = "Mage - General Procs",
				["stacksPoint"] = "CENTER",
				["stacksContainment"] = "INSIDE",
				["zoom"] = 0,
				["auto"] = true,
				["actions"] = {
					["start"] = {
					},
					["finish"] = {
					},
					["init"] = {
					},
				},
				["additional_triggers"] = {
				},
				["stickyDuration"] = false,
				["frameStrata"] = 1,
				["width"] = 32,
				["yOffset"] = -265,
				["numTriggers"] = 1,
				["inverse"] = false,
				["xOffset"] = -200,
				["id"] = "doom trink",
				["selfPoint"] = "CENTER",
				["cooldown"] = true,
				["textColor"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
			},
			["Mirror Image Cooldown"] = {
				["color"] = {
					0.286274509803922, -- [1]
					1, -- [2]
					0.101960784313726, -- [3]
					1, -- [4]
				},
				["untrigger"] = {
					["spellName"] = 55342,
				},
				["anchorPoint"] = "CENTER",
				["customTextUpdate"] = "update",
				["actions"] = {
					["start"] = {
						["do_glow"] = false,
						["do_sound"] = false,
						["glow_action"] = "show",
						["sound"] = "Interface\\Addons\\WeakAuras\\PowerAurasMedia\\Sounds\\sonar.ogg",
						["glow_frame"] = "MultiBarBottomRightButton1",
						["do_custom"] = false,
						["sound_channel"] = "Master",
					},
					["finish"] = {
					},
					["init"] = {
					},
				},
				["fontFlags"] = "OUTLINE",
				["animation"] = {
					["start"] = {
						["type"] = "none",
						["duration_type"] = "seconds",
					},
					["main"] = {
						["type"] = "none",
						["duration_type"] = "seconds",
					},
					["finish"] = {
						["type"] = "none",
						["duration_type"] = "seconds",
					},
				},
				["trigger"] = {
					["type"] = "status",
					["spellName"] = 55342,
					["unevent"] = "auto",
					["use_showOn"] = true,
					["custom_hide"] = "timed",
					["event"] = "Cooldown Progress (Spell)",
					["subeventPrefix"] = "SPELL",
					["unit"] = "player",
					["use_spellName"] = true,
					["spellIds"] = {
					},
					["subeventSuffix"] = "_CAST_START",
					["showOn"] = "showOnCooldown",
					["names"] = {
					},
					["use_unit"] = true,
					["debuffType"] = "HELPFUL",
				},
				["desaturate"] = true,
				["progressPrecision"] = 0,
				["font"] = "Friz Quadrata TT",
				["height"] = 50,
				["load"] = {
					["talent"] = {
						["single"] = 16,
						["multi"] = {
						},
					},
					["class"] = {
						["single"] = "MAGE",
						["multi"] = {
						},
					},
					["use_talent"] = true,
					["use_class"] = true,
					["race"] = {
						["multi"] = {
						},
					},
					["spec"] = {
						["single"] = 1,
						["multi"] = {
							true, -- [1]
						},
					},
					["role"] = {
						["multi"] = {
						},
					},
					["difficulty"] = {
						["multi"] = {
						},
					},
					["size"] = {
						["multi"] = {
						},
					},
				},
				["fontSize"] = 24,
				["displayStacks"] = "%c",
				["regionType"] = "icon",
				["parent"] = "Mage Tier 6 Talents",
				["cooldown"] = true,
				["stacksContainment"] = "INSIDE",
				["zoom"] = 0,
				["auto"] = true,
				["icon"] = true,
				["id"] = "Mirror Image Cooldown",
				["yOffset"] = -313.999740600586,
				["frameStrata"] = 1,
				["width"] = 50,
				["stickyDuration"] = false,
				["numTriggers"] = 1,
				["inverse"] = false,
				["xOffset"] = -0.000244140625,
				["additional_triggers"] = {
				},
				["selfPoint"] = "CENTER",
				["stacksPoint"] = "CENTER",
				["textColor"] = {
					0.945098039215686, -- [1]
					1, -- [2]
					0.96078431372549, -- [3]
					1, -- [4]
				},
			},
			["Incanter's Flow 1"] = {
				["color"] = {
					0.286274509803922, -- [1]
					0.286274509803922, -- [2]
					0.286274509803922, -- [3]
					1, -- [4]
				},
				["untrigger"] = {
				},
				["anchorPoint"] = "CENTER",
				["customTextUpdate"] = "update",
				["actions"] = {
					["start"] = {
						["do_glow"] = false,
						["do_sound"] = false,
						["glow_frame"] = "WeakAuras:Incanter's Flow Peak",
						["sound"] = "Interface\\AddOns\\WeakAuras\\Media\\Sounds\\RobotBlip.ogg",
						["do_custom"] = false,
					},
					["finish"] = {
						["sound"] = "Interface\\AddOns\\WeakAuras\\Media\\Sounds\\CatMeow2.mp3",
						["do_sound"] = false,
					},
					["init"] = {
					},
				},
				["fontFlags"] = "OUTLINE",
				["animation"] = {
					["start"] = {
						["type"] = "none",
						["colorR"] = 1,
						["scalex"] = 1,
						["duration"] = "9",
						["alphaType"] = "alphaPulse",
						["duration_type"] = "seconds",
						["alpha"] = 0,
						["x"] = 0,
						["y"] = 0,
						["colorB"] = 1,
						["colorG"] = 1,
						["alphaFunc"] = "return function(progress, start, delta)\n local angle = (progress * 2 * math.pi) - (math.pi / 2)\n return start + (((math.sin(angle) + 1)/2) * delta)\nend\n",
						["colorA"] = 1,
						["rotate"] = 0,
						["scaley"] = 1,
						["use_alpha"] = true,
					},
					["main"] = {
						["duration"] = "1",
						["type"] = "none",
						["duration_type"] = "seconds",
					},
					["finish"] = {
						["type"] = "none",
						["duration_type"] = "seconds",
					},
				},
				["trigger"] = {
					["custom_hide"] = "timed",
					["type"] = "aura",
					["spellId"] = "116267",
					["subeventSuffix"] = "_CAST_START",
					["fullscan"] = true,
					["useCount"] = true,
					["event"] = "Health",
					["subeventPrefix"] = "SPELL",
					["count"] = "1",
					["use_spellId"] = true,
					["name"] = "Incanter's Flow",
					["unit"] = "player",
					["spellIds"] = {
					},
					["names"] = {
						"Incanter's Absorption", -- [1]
					},
					["countOperator"] = "==",
					["debuffType"] = "HELPFUL",
				},
				["desaturate"] = false,
				["progressPrecision"] = 0,
				["font"] = "ElvUI Font",
				["height"] = 44,
				["load"] = {
					["use_never"] = false,
					["talent"] = {
						["single"] = 18,
						["multi"] = {
						},
					},
					["class"] = {
						["single"] = "MAGE",
						["multi"] = {
						},
					},
					["use_talent"] = true,
					["difficulty"] = {
						["multi"] = {
						},
					},
					["race"] = {
						["multi"] = {
						},
					},
					["spec"] = {
						["single"] = 3,
						["multi"] = {
							[3] = true,
						},
					},
					["role"] = {
						["multi"] = {
						},
					},
					["use_class"] = true,
					["size"] = {
						["multi"] = {
						},
					},
				},
				["fontSize"] = 24,
				["displayStacks"] = "%s",
				["regionType"] = "icon",
				["parent"] = "Mage Tier 6 Talents",
				["cooldown"] = false,
				["stacksContainment"] = "INSIDE",
				["zoom"] = 0,
				["auto"] = true,
				["icon"] = true,
				["id"] = "Incanter's Flow 1",
				["yOffset"] = -253.000274658203,
				["frameStrata"] = 1,
				["width"] = 44,
				["additional_triggers"] = {
				},
				["numTriggers"] = 1,
				["inverse"] = false,
				["xOffset"] = 64.999755859375,
				["stickyDuration"] = false,
				["selfPoint"] = "CENTER",
				["stacksPoint"] = "TOPRIGHT",
				["textColor"] = {
					1, -- [1]
					0.976470588235294, -- [2]
					0.211764705882353, -- [3]
					1, -- [4]
				},
			},
			["Incanter's Flow 2"] = {
				["color"] = {
					0.392156862745098, -- [1]
					0.392156862745098, -- [2]
					0.392156862745098, -- [3]
					1, -- [4]
				},
				["untrigger"] = {
				},
				["anchorPoint"] = "CENTER",
				["customTextUpdate"] = "update",
				["actions"] = {
					["start"] = {
						["do_glow"] = false,
						["do_sound"] = false,
						["sound"] = "Interface\\AddOns\\WeakAuras\\Media\\Sounds\\RobotBlip.ogg",
						["do_custom"] = false,
						["glow_frame"] = "WeakAuras:Incanter's Flow Peak",
					},
					["finish"] = {
						["sound"] = "Interface\\AddOns\\WeakAuras\\Media\\Sounds\\CatMeow2.mp3",
						["do_sound"] = false,
					},
					["init"] = {
					},
				},
				["fontFlags"] = "OUTLINE",
				["animation"] = {
					["start"] = {
						["type"] = "none",
						["colorR"] = 1,
						["duration"] = "9",
						["duration_type"] = "seconds",
						["y"] = 0,
						["scalex"] = 1,
						["alpha"] = 0,
						["colorA"] = 1,
						["alphaType"] = "alphaPulse",
						["colorB"] = 1,
						["colorG"] = 1,
						["alphaFunc"] = "return function(progress, start, delta)\n local angle = (progress * 2 * math.pi) - (math.pi / 2)\n return start + (((math.sin(angle) + 1)/2) * delta)\nend\n",
						["x"] = 0,
						["rotate"] = 0,
						["scaley"] = 1,
						["use_alpha"] = true,
					},
					["main"] = {
						["duration"] = "1",
						["type"] = "none",
						["duration_type"] = "seconds",
					},
					["finish"] = {
						["type"] = "none",
						["duration_type"] = "seconds",
					},
				},
				["trigger"] = {
					["fullscan"] = true,
					["type"] = "aura",
					["spellId"] = "116267",
					["subeventSuffix"] = "_CAST_START",
					["custom_hide"] = "timed",
					["use_spellId"] = true,
					["event"] = "Health",
					["subeventPrefix"] = "SPELL",
					["count"] = "2",
					["useCount"] = true,
					["name"] = "Incanter's Flow",
					["unit"] = "player",
					["spellIds"] = {
					},
					["names"] = {
						"Incanter's Absorption", -- [1]
					},
					["countOperator"] = "==",
					["debuffType"] = "HELPFUL",
				},
				["desaturate"] = false,
				["progressPrecision"] = 0,
				["font"] = "ElvUI Font",
				["height"] = 44,
				["load"] = {
					["use_never"] = false,
					["talent"] = {
						["single"] = 18,
						["multi"] = {
						},
					},
					["class"] = {
						["single"] = "MAGE",
						["multi"] = {
						},
					},
					["use_talent"] = true,
					["difficulty"] = {
						["multi"] = {
						},
					},
					["race"] = {
						["multi"] = {
						},
					},
					["spec"] = {
						["single"] = 3,
						["multi"] = {
							[3] = true,
						},
					},
					["role"] = {
						["multi"] = {
						},
					},
					["use_class"] = true,
					["size"] = {
						["multi"] = {
						},
					},
				},
				["fontSize"] = 24,
				["displayStacks"] = "%s",
				["regionType"] = "icon",
				["parent"] = "Mage Tier 6 Talents",
				["stacksPoint"] = "BOTTOMRIGHT",
				["stacksContainment"] = "INSIDE",
				["zoom"] = 0,
				["auto"] = true,
				["icon"] = true,
				["additional_triggers"] = {
				},
				["yOffset"] = -253,
				["frameStrata"] = 1,
				["width"] = 44,
				["selfPoint"] = "CENTER",
				["numTriggers"] = 1,
				["inverse"] = false,
				["xOffset"] = 65,
				["stickyDuration"] = false,
				["id"] = "Incanter's Flow 2",
				["cooldown"] = false,
				["textColor"] = {
					1, -- [1]
					0.976470588235294, -- [2]
					0.211764705882353, -- [3]
					1, -- [4]
				},
			},
			["Mirror Image Ready"] = {
				["color"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["yOffset"] = -314.00032043457,
				["anchorPoint"] = "CENTER",
				["customTextUpdate"] = "update",
				["icon"] = true,
				["fontFlags"] = "OUTLINE",
				["animation"] = {
					["start"] = {
						["type"] = "preset",
						["preset"] = "spiral",
						["duration_type"] = "seconds",
					},
					["main"] = {
						["type"] = "none",
						["duration_type"] = "seconds",
					},
					["finish"] = {
						["type"] = "none",
						["duration_type"] = "seconds",
					},
				},
				["trigger"] = {
					["type"] = "status",
					["spellName"] = 55342,
					["unevent"] = "auto",
					["use_showOn"] = true,
					["custom_hide"] = "timed",
					["event"] = "Cooldown Progress (Spell)",
					["subeventPrefix"] = "SPELL",
					["unit"] = "player",
					["use_spellName"] = true,
					["spellIds"] = {
					},
					["subeventSuffix"] = "_CAST_START",
					["showOn"] = "showOnReady",
					["names"] = {
					},
					["use_unit"] = true,
					["debuffType"] = "HELPFUL",
				},
				["desaturate"] = false,
				["font"] = "Friz Quadrata TT",
				["height"] = 50,
				["load"] = {
					["talent"] = {
						["single"] = 16,
						["multi"] = {
						},
					},
					["class"] = {
						["single"] = "MAGE",
						["multi"] = {
						},
					},
					["use_talent"] = true,
					["difficulty"] = {
						["multi"] = {
						},
					},
					["race"] = {
						["multi"] = {
						},
					},
					["spec"] = {
						["single"] = 1,
						["multi"] = {
							true, -- [1]
						},
					},
					["role"] = {
						["multi"] = {
						},
					},
					["use_combat"] = true,
					["use_class"] = true,
					["size"] = {
						["multi"] = {
						},
					},
				},
				["fontSize"] = 12,
				["displayStacks"] = "%c",
				["regionType"] = "icon",
				["parent"] = "Mage Tier 6 Talents",
				["cooldown"] = false,
				["stacksContainment"] = "INSIDE",
				["zoom"] = 0,
				["auto"] = true,
				["untrigger"] = {
					["spellName"] = 55342,
				},
				["additional_triggers"] = {
				},
				["stickyDuration"] = false,
				["frameStrata"] = 1,
				["width"] = 50,
				["id"] = "Mirror Image Ready",
				["numTriggers"] = 1,
				["inverse"] = false,
				["xOffset"] = 0.00030517578125,
				["selfPoint"] = "CENTER",
				["actions"] = {
					["start"] = {
						["do_glow"] = false,
						["glow_action"] = "show",
						["do_sound"] = false,
						["do_custom"] = false,
						["glow_frame"] = "MultiBarBottomRightButton1",
						["sound"] = "Interface\\AddOns\\ElvUI\\media\\sounds\\warning.mp3",
						["sound_channel"] = "Master",
					},
					["finish"] = {
					},
					["init"] = {
					},
				},
				["stacksPoint"] = "BOTTOMRIGHT",
				["textColor"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
			},
			["Incanter's Flow 4"] = {
				["xOffset"] = 65,
				["untrigger"] = {
				},
				["anchorPoint"] = "CENTER",
				["customTextUpdate"] = "update",
				["actions"] = {
					["start"] = {
						["do_glow"] = false,
						["do_sound"] = false,
						["do_custom"] = false,
						["sound"] = "Interface\\AddOns\\WeakAuras\\Media\\Sounds\\RobotBlip.ogg",
						["glow_frame"] = "WeakAuras:Incanter's Flow Peak",
					},
					["finish"] = {
						["sound"] = "Interface\\AddOns\\WeakAuras\\Media\\Sounds\\CatMeow2.mp3",
						["do_sound"] = false,
					},
					["init"] = {
					},
				},
				["fontFlags"] = "OUTLINE",
				["animation"] = {
					["start"] = {
						["type"] = "none",
						["colorR"] = 1,
						["scalex"] = 1,
						["duration_type"] = "seconds",
						["alphaType"] = "alphaPulse",
						["duration"] = "9",
						["alpha"] = 0,
						["x"] = 0,
						["y"] = 0,
						["colorB"] = 1,
						["colorG"] = 1,
						["alphaFunc"] = "return function(progress, start, delta)\n local angle = (progress * 2 * math.pi) - (math.pi / 2)\n return start + (((math.sin(angle) + 1)/2) * delta)\nend\n",
						["colorA"] = 1,
						["rotate"] = 0,
						["scaley"] = 1,
						["use_alpha"] = true,
					},
					["main"] = {
						["duration"] = "1",
						["type"] = "none",
						["duration_type"] = "seconds",
					},
					["finish"] = {
						["type"] = "none",
						["duration_type"] = "seconds",
					},
				},
				["trigger"] = {
					["fullscan"] = true,
					["type"] = "aura",
					["spellId"] = "116267",
					["subeventSuffix"] = "_CAST_START",
					["custom_hide"] = "timed",
					["useCount"] = true,
					["event"] = "Health",
					["subeventPrefix"] = "SPELL",
					["count"] = "4",
					["use_spellId"] = true,
					["name"] = "Incanter's Flow",
					["unit"] = "player",
					["spellIds"] = {
					},
					["names"] = {
						"Incanter's Absorption", -- [1]
					},
					["countOperator"] = "==",
					["debuffType"] = "HELPFUL",
				},
				["desaturate"] = false,
				["progressPrecision"] = 0,
				["font"] = "ElvUI Font",
				["height"] = 44,
				["load"] = {
					["use_never"] = false,
					["talent"] = {
						["single"] = 18,
						["multi"] = {
						},
					},
					["class"] = {
						["single"] = "MAGE",
						["multi"] = {
						},
					},
					["use_talent"] = true,
					["difficulty"] = {
						["multi"] = {
						},
					},
					["race"] = {
						["multi"] = {
						},
					},
					["spec"] = {
						["single"] = 3,
						["multi"] = {
							[3] = true,
						},
					},
					["role"] = {
						["multi"] = {
						},
					},
					["use_class"] = true,
					["size"] = {
						["multi"] = {
						},
					},
				},
				["fontSize"] = 24,
				["displayStacks"] = " %s",
				["regionType"] = "icon",
				["parent"] = "Mage Tier 6 Talents",
				["stacksPoint"] = "BOTTOMRIGHT",
				["stacksContainment"] = "INSIDE",
				["zoom"] = 0,
				["auto"] = true,
				["icon"] = true,
				["additional_triggers"] = {
				},
				["yOffset"] = -253,
				["frameStrata"] = 1,
				["width"] = 44,
				["selfPoint"] = "CENTER",
				["numTriggers"] = 1,
				["inverse"] = false,
				["color"] = {
					0.764705882352941, -- [1]
					0.764705882352941, -- [2]
					0.764705882352941, -- [3]
					1, -- [4]
				},
				["stickyDuration"] = false,
				["id"] = "Incanter's Flow 4",
				["cooldown"] = false,
				["textColor"] = {
					1, -- [1]
					0.976470588235294, -- [2]
					0.211764705882353, -- [3]
					1, -- [4]
				},
			},
			["Ice Nova"] = {
				["xOffset"] = -251.000244140625,
				["untrigger"] = {
					["spellName"] = 157997,
				},
				["anchorPoint"] = "CENTER",
				["customTextUpdate"] = "update",
				["actions"] = {
					["start"] = {
						["do_glow"] = false,
						["glow_action"] = "show",
						["do_sound"] = false,
						["do_custom"] = false,
						["glow_frame"] = "MultiBarBottomRightButton1",
						["sound"] = "Interface\\Addons\\WeakAuras\\PowerAurasMedia\\Sounds\\sonar.ogg",
						["sound_channel"] = "Master",
					},
					["finish"] = {
					},
					["init"] = {
					},
				},
				["fontFlags"] = "OUTLINE",
				["animation"] = {
					["start"] = {
						["type"] = "none",
						["duration_type"] = "seconds",
					},
					["main"] = {
						["type"] = "none",
						["duration_type"] = "seconds",
					},
					["finish"] = {
						["type"] = "none",
						["duration_type"] = "seconds",
					},
				},
				["trigger"] = {
					["use_charges"] = true,
					["unit"] = "player",
					["spellName"] = 157997,
					["charges_operator"] = "==",
					["charges"] = "0",
					["subeventSuffix"] = "_CAST_START",
					["use_showOn"] = true,
					["custom_hide"] = "timed",
					["event"] = "Cooldown Progress (Spell)",
					["use_unit"] = true,
					["unevent"] = "auto",
					["use_spellName"] = true,
					["spellIds"] = {
					},
					["debuffType"] = "HELPFUL",
					["showOn"] = "showOnCooldown",
					["type"] = "status",
					["names"] = {
					},
					["subeventPrefix"] = "SPELL",
				},
				["desaturate"] = true,
				["progressPrecision"] = 0,
				["font"] = "Friz Quadrata TT",
				["height"] = 44,
				["load"] = {
					["talent"] = {
						["single"] = 15,
						["multi"] = {
						},
					},
					["class"] = {
						["single"] = "MAGE",
						["multi"] = {
						},
					},
					["use_talent"] = true,
					["difficulty"] = {
						["multi"] = {
						},
					},
					["role"] = {
						["multi"] = {
						},
					},
					["use_spec"] = true,
					["spec"] = {
						["single"] = 3,
						["multi"] = {
							true, -- [1]
							[3] = true,
						},
					},
					["race"] = {
						["multi"] = {
						},
					},
					["use_class"] = true,
					["size"] = {
						["multi"] = {
						},
					},
				},
				["fontSize"] = 24,
				["displayStacks"] = "%c",
				["regionType"] = "icon",
				["parent"] = "Mage - Frost",
				["stacksPoint"] = "CENTER",
				["stacksContainment"] = "INSIDE",
				["zoom"] = 0,
				["auto"] = true,
				["icon"] = true,
				["additional_triggers"] = {
				},
				["yOffset"] = -288.000061035156,
				["frameStrata"] = 1,
				["width"] = 44,
				["stickyDuration"] = false,
				["numTriggers"] = 1,
				["inverse"] = false,
				["color"] = {
					0.286274509803922, -- [1]
					1, -- [2]
					0.101960784313726, -- [3]
					1, -- [4]
				},
				["id"] = "Ice Nova",
				["selfPoint"] = "CENTER",
				["cooldown"] = true,
				["textColor"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
			},
			["Brain 2"] = {
				["user_y"] = 0,
				["user_x"] = 0,
				["xOffset"] = -33.387451171875,
				["yOffset"] = 238.211975097656,
				["anchorPoint"] = "CENTER",
				["desaturateBackground"] = false,
				["sameTexture"] = true,
				["desaturateForeground"] = false,
				["animation"] = {
					["start"] = {
						["type"] = "none",
						["duration_type"] = "seconds",
					},
					["main"] = {
						["type"] = "preset",
						["preset"] = "pulse",
						["duration_type"] = "seconds",
					},
					["finish"] = {
						["type"] = "none",
						["duration_type"] = "seconds",
					},
				},
				["trigger"] = {
					["type"] = "aura",
					["subeventSuffix"] = "_CAST_START",
					["countOperator"] = "==",
					["names"] = {
						"Brain Freeze", -- [1]
					},
					["custom_hide"] = "timed",
					["useCount"] = true,
					["count"] = "2",
					["unit"] = "player",
					["spellIds"] = {
					},
					["subeventPrefix"] = "SPELL",
					["event"] = "Health",
					["debuffType"] = "HELPFUL",
				},
				["stickyDuration"] = false,
				["rotation"] = 0,
				["font"] = "Friz Quadrata TT",
				["height"] = 100,
				["load"] = {
					["talent"] = {
						["multi"] = {
						},
					},
					["class"] = {
						["single"] = "MAGE",
						["multi"] = {
						},
					},
					["difficulty"] = {
						["multi"] = {
						},
					},
					["race"] = {
						["multi"] = {
						},
					},
					["use_spec"] = true,
					["spec"] = {
						["single"] = 3,
						["multi"] = {
							[3] = true,
						},
					},
					["role"] = {
						["multi"] = {
						},
					},
					["use_class"] = true,
					["size"] = {
						["multi"] = {
						},
					},
				},
				["fontSize"] = 12,
				["foregroundTexture"] = "Textures\\SpellActivationOverlays\\Brain_Freeze",
				["mirror"] = false,
				["regionType"] = "progresstexture",
				["blendMode"] = "BLEND",
				["parent"] = "Mage - Frost",
				["foregroundColor"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["color"] = {
				},
				["selfPoint"] = "CENTER",
				["actions"] = {
					["start"] = {
						["sound_channel"] = "Master",
						["sound"] = "Sound\\Spells\\SimonGame_Visual_GameStart.wav",
						["do_sound"] = false,
					},
					["finish"] = {
					},
					["init"] = {
					},
				},
				["numTriggers"] = 1,
				["id"] = "Brain 2",
				["compress"] = false,
				["additional_triggers"] = {
				},
				["crop_y"] = 0.41,
				["alpha"] = 1,
				["width"] = 200,
				["frameStrata"] = 1,
				["untrigger"] = {
				},
				["inverse"] = false,
				["backgroundTexture"] = "Textures\\SpellActivationOverlays\\Eclipse_Sun",
				["orientation"] = "HORIZONTAL_INVERSE",
				["crop_x"] = 0.41,
				["backgroundColor"] = {
					0.5, -- [1]
					0.5, -- [2]
					0.5, -- [3]
					0.5, -- [4]
				},
				["backgroundOffset"] = 0,
			},
			["Rune of Power Missing"] = {
				["xOffset"] = -0.00079345703125,
				["untrigger"] = {
				},
				["anchorPoint"] = "CENTER",
				["customTextUpdate"] = "update",
				["actions"] = {
					["start"] = {
						["do_custom"] = false,
						["custom"] = "\n\n",
					},
					["finish"] = {
						["do_custom"] = false,
						["custom"] = "WA_RoP_Number = 1",
					},
					["init"] = {
					},
				},
				["fontFlags"] = "OUTLINE",
				["animation"] = {
					["start"] = {
						["type"] = "none",
						["duration_type"] = "seconds",
					},
					["main"] = {
						["type"] = "preset",
						["preset"] = "alphaPulse",
						["duration_type"] = "seconds",
					},
					["finish"] = {
						["type"] = "none",
						["duration_type"] = "seconds",
					},
				},
				["trigger"] = {
					["rem"] = "2",
					["duration"] = "60",
					["unit"] = "player",
					["custom_hide"] = "timed",
					["type"] = "aura",
					["subeventSuffix"] = "_CAST_START",
					["names"] = {
						"Rune of Power", -- [1]
					},
					["event"] = "Health",
					["custom"] = "function(event, unitId, _, _, _, spellId)\n if(unitId == \"player\" and spellId == 116011) then\n --Implement a 1 turn delay due to weakauras being processed top-down\n if(WA_RoP == 3) then \n WA_RoP = 2\n return false\n elseif(WA_RoP == 2) then\n WA_RoP = 1 \n return true\n end\n else\n return false\n end\nend",
					["inverse"] = true,
					["events"] = "UNIT_SPELLCAST_SUCCEEDED",
					["spellIds"] = {
					},
					["ownOnly"] = true,
					["remOperator"] = ">",
					["custom_type"] = "event",
					["debuffType"] = "HELPFUL",
					["subeventPrefix"] = "SPELL",
				},
				["desaturate"] = false,
				["font"] = "Friz Quadrata TT",
				["height"] = 64,
				["load"] = {
					["talent"] = {
						["single"] = 17,
						["multi"] = {
							[17] = true,
						},
					},
					["class"] = {
						["single"] = "MAGE",
						["multi"] = {
						},
					},
					["use_talent"] = true,
					["use_class"] = true,
					["race"] = {
						["multi"] = {
						},
					},
					["role"] = {
						["multi"] = {
						},
					},
					["difficulty"] = {
						["multi"] = {
						},
					},
					["use_combat"] = true,
					["spec"] = {
						["multi"] = {
						},
					},
					["size"] = {
						["multi"] = {
						},
					},
				},
				["fontSize"] = 12,
				["displayStacks"] = " ",
				["regionType"] = "icon",
				["parent"] = "Mage Tier 6 Talents",
				["selfPoint"] = "CENTER",
				["stacksContainment"] = "OUTSIDE",
				["zoom"] = 0,
				["auto"] = false,
				["additional_triggers"] = {
				},
				["id"] = "Rune of Power Missing",
				["stickyDuration"] = false,
				["frameStrata"] = 1,
				["width"] = 64,
				["yOffset"] = -253,
				["numTriggers"] = 1,
				["inverse"] = false,
				["icon"] = true,
				["color"] = {
					1, -- [1]
					0.0392156862745098, -- [2]
					0.0392156862745098, -- [3]
					0.900000005960465, -- [4]
				},
				["displayIcon"] = "Interface\\Icons\\spell_mage_runeofpower",
				["stacksPoint"] = "TOP",
				["textColor"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
			},
			[" Fingers of Frost"] = {
				["color"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["untrigger"] = {
				},
				["anchorPoint"] = "CENTER",
				["customTextUpdate"] = "update",
				["actions"] = {
					["start"] = {
						["do_glow"] = false,
						["glow_frame"] = "WeakAuras: Fingers of Frost",
						["glow_action"] = "show",
					},
					["finish"] = {
						["sound"] = "Interface\\AddOns\\WeakAuras\\Media\\Sounds\\CatMeow2.mp3",
						["do_sound"] = false,
					},
					["init"] = {
					},
				},
				["fontFlags"] = "OUTLINE",
				["animation"] = {
					["start"] = {
						["type"] = "none",
						["duration_type"] = "seconds",
					},
					["main"] = {
						["type"] = "none",
						["duration_type"] = "seconds",
					},
					["finish"] = {
						["type"] = "none",
						["duration_type"] = "seconds",
					},
				},
				["trigger"] = {
					["type"] = "aura",
					["subeventSuffix"] = "_CAST_START",
					["event"] = "Health",
					["names"] = {
						"Fingers of Frost", -- [1]
					},
					["spellIds"] = {
					},
					["debuffType"] = "HELPFUL",
					["unit"] = "player",
					["subeventPrefix"] = "SPELL",
					["custom_hide"] = "timed",
				},
				["desaturate"] = false,
				["progressPrecision"] = 0,
				["font"] = "Friz Quadrata TT",
				["height"] = 32.0000076293945,
				["load"] = {
					["use_never"] = false,
					["talent"] = {
						["single"] = 16,
						["multi"] = {
						},
					},
					["spec"] = {
						["single"] = 3,
						["multi"] = {
							[3] = true,
						},
					},
					["difficulty"] = {
						["multi"] = {
						},
					},
					["race"] = {
						["multi"] = {
						},
					},
					["use_spec"] = true,
					["class"] = {
						["single"] = "MAGE",
						["multi"] = {
						},
					},
					["role"] = {
						["multi"] = {
						},
					},
					["use_class"] = true,
					["size"] = {
						["multi"] = {
						},
					},
				},
				["fontSize"] = 12,
				["displayStacks"] = " %s",
				["regionType"] = "icon",
				["parent"] = "Mage - Frost",
				["stacksPoint"] = "BOTTOMRIGHT",
				["stacksContainment"] = "INSIDE",
				["zoom"] = 0,
				["auto"] = true,
				["icon"] = true,
				["id"] = " Fingers of Frost",
				["yOffset"] = -253.999938964844,
				["frameStrata"] = 1,
				["width"] = 32.0000076293945,
				["stickyDuration"] = false,
				["numTriggers"] = 1,
				["inverse"] = false,
				["xOffset"] = 81.9998168945313,
				["selfPoint"] = "CENTER",
				["additional_triggers"] = {
				},
				["cooldown"] = true,
				["textColor"] = {
					1, -- [1]
					0.756862745098039, -- [2]
					0.0117647058823529, -- [3]
					1, -- [4]
				},
			},
			["Icy Veins"] = {
				["color"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["untrigger"] = {
				},
				["anchorPoint"] = "CENTER",
				["customTextUpdate"] = "update",
				["actions"] = {
					["start"] = {
						["do_glow"] = true,
						["glow_frame"] = "WeakAuras:Icy Veins",
						["glow_action"] = "show",
					},
					["finish"] = {
						["sound"] = "Interface\\AddOns\\WeakAuras\\Media\\Sounds\\CatMeow2.mp3",
						["do_sound"] = false,
					},
					["init"] = {
					},
				},
				["fontFlags"] = "OUTLINE",
				["animation"] = {
					["start"] = {
						["type"] = "none",
						["duration_type"] = "seconds",
					},
					["main"] = {
						["type"] = "none",
						["duration_type"] = "seconds",
					},
					["finish"] = {
						["type"] = "none",
						["duration_type"] = "seconds",
					},
				},
				["trigger"] = {
					["type"] = "aura",
					["subeventSuffix"] = "_CAST_START",
					["event"] = "Health",
					["names"] = {
						"Icy Veins", -- [1]
					},
					["spellIds"] = {
					},
					["debuffType"] = "HELPFUL",
					["unit"] = "player",
					["subeventPrefix"] = "SPELL",
					["custom_hide"] = "timed",
				},
				["desaturate"] = false,
				["progressPrecision"] = 0,
				["font"] = "Friz Quadrata TT",
				["height"] = 32,
				["load"] = {
					["use_never"] = false,
					["talent"] = {
						["single"] = 16,
						["multi"] = {
						},
					},
					["class"] = {
						["single"] = "MAGE",
						["multi"] = {
						},
					},
					["use_talent"] = false,
					["use_class"] = true,
					["role"] = {
						["multi"] = {
						},
					},
					["use_spec"] = true,
					["difficulty"] = {
						["multi"] = {
						},
					},
					["race"] = {
						["multi"] = {
						},
					},
					["spec"] = {
						["single"] = 3,
						["multi"] = {
							[3] = true,
						},
					},
					["size"] = {
						["multi"] = {
						},
					},
				},
				["fontSize"] = 15,
				["displayStacks"] = " %c",
				["regionType"] = "icon",
				["parent"] = "Mage - Frost",
				["cooldown"] = true,
				["stacksContainment"] = "INSIDE",
				["zoom"] = 0,
				["auto"] = true,
				["additional_triggers"] = {
				},
				["id"] = "Icy Veins",
				["yOffset"] = -254.000152587891,
				["frameStrata"] = 1,
				["width"] = 32,
				["stickyDuration"] = false,
				["numTriggers"] = 1,
				["inverse"] = false,
				["xOffset"] = -31.9999389648438,
				["icon"] = true,
				["selfPoint"] = "CENTER",
				["stacksPoint"] = "CENTER",
				["textColor"] = {
					1, -- [1]
					0.756862745098039, -- [2]
					0.0117647058823529, -- [3]
					1, -- [4]
				},
			},
			["Rune of Power"] = {
				["color"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["untrigger"] = {
				},
				["anchorPoint"] = "CENTER",
				["customTextUpdate"] = "update",
				["actions"] = {
					["start"] = {
					},
					["finish"] = {
						["sound"] = "Interface\\AddOns\\WeakAuras\\Media\\Sounds\\CatMeow2.mp3",
						["do_sound"] = false,
					},
					["init"] = {
					},
				},
				["fontFlags"] = "OUTLINE",
				["animation"] = {
					["start"] = {
						["type"] = "none",
						["duration_type"] = "seconds",
					},
					["main"] = {
						["type"] = "none",
						["duration_type"] = "seconds",
					},
					["finish"] = {
						["type"] = "none",
						["duration_type"] = "seconds",
					},
				},
				["trigger"] = {
					["type"] = "aura",
					["spellId"] = "116014",
					["subeventSuffix"] = "_CAST_START",
					["event"] = "Health",
					["names"] = {
						"Rune of Power", -- [1]
					},
					["custom_hide"] = "timed",
					["use_spellId"] = true,
					["name"] = "Rune of Power",
					["fullscan"] = true,
					["unit"] = "player",
					["spellIds"] = {
					},
					["subeventPrefix"] = "SPELL",
					["debuffType"] = "HELPFUL",
				},
				["desaturate"] = false,
				["progressPrecision"] = 0,
				["font"] = "Friz Quadrata TT",
				["height"] = 44,
				["load"] = {
					["use_never"] = false,
					["talent"] = {
						["single"] = 17,
						["multi"] = {
						},
					},
					["spec"] = {
						["single"] = 3,
						["multi"] = {
							[3] = true,
						},
					},
					["use_talent"] = true,
					["difficulty"] = {
						["multi"] = {
						},
					},
					["race"] = {
						["multi"] = {
						},
					},
					["class"] = {
						["single"] = "MAGE",
						["multi"] = {
						},
					},
					["role"] = {
						["multi"] = {
						},
					},
					["use_class"] = true,
					["size"] = {
						["multi"] = {
						},
					},
				},
				["fontSize"] = 24,
				["displayStacks"] = " ",
				["regionType"] = "icon",
				["parent"] = "Mage Tier 6 Talents",
				["stacksPoint"] = "CENTER",
				["stacksContainment"] = "INSIDE",
				["zoom"] = 0,
				["auto"] = true,
				["additional_triggers"] = {
				},
				["id"] = "Rune of Power",
				["yOffset"] = -253.000183105469,
				["frameStrata"] = 1,
				["width"] = 44,
				["stickyDuration"] = false,
				["numTriggers"] = 1,
				["inverse"] = false,
				["xOffset"] = -66.0000610351563,
				["icon"] = true,
				["selfPoint"] = "CENTER",
				["cooldown"] = true,
				["textColor"] = {
					1, -- [1]
					0.756862745098039, -- [2]
					0.0117647058823529, -- [3]
					1, -- [4]
				},
			},
			["RoP Missing"] = {
				["xOffset"] = -66,
				["untrigger"] = {
				},
				["anchorPoint"] = "CENTER",
				["customTextUpdate"] = "update",
				["actions"] = {
					["start"] = {
						["do_glow"] = true,
						["glow_action"] = "show",
						["glow_frame"] = "WeakAuras:RoP Missing",
					},
					["finish"] = {
						["do_glow"] = false,
						["do_sound"] = false,
						["glow_action"] = "hide",
						["sound"] = "Interface\\AddOns\\WeakAuras\\Media\\Sounds\\CatMeow2.mp3",
						["glow_frame"] = "WeakAuras:Invocation Missing",
					},
					["init"] = {
					},
				},
				["fontFlags"] = "OUTLINE",
				["animation"] = {
					["start"] = {
						["type"] = "none",
						["duration_type"] = "seconds",
					},
					["main"] = {
						["type"] = "none",
						["duration_type"] = "seconds",
					},
					["finish"] = {
						["type"] = "none",
						["duration_type"] = "seconds",
					},
				},
				["trigger"] = {
					["type"] = "aura",
					["spellId"] = "116014",
					["subeventSuffix"] = "_CAST_START",
					["fullscan"] = true,
					["event"] = "Health",
					["subeventPrefix"] = "SPELL",
					["inverse"] = true,
					["use_spellId"] = true,
					["name"] = "Rune of Power",
					["custom_hide"] = "timed",
					["unit"] = "player",
					["spellIds"] = {
					},
					["names"] = {
						"Rune of Power", -- [1]
					},
					["debuffType"] = "HELPFUL",
				},
				["desaturate"] = false,
				["progressPrecision"] = 0,
				["font"] = "Friz Quadrata TT",
				["height"] = 44,
				["load"] = {
					["use_never"] = false,
					["talent"] = {
						["single"] = 17,
						["multi"] = {
						},
					},
					["spec"] = {
						["single"] = 3,
						["multi"] = {
							[3] = true,
						},
					},
					["use_talent"] = true,
					["difficulty"] = {
						["multi"] = {
						},
					},
					["race"] = {
						["multi"] = {
						},
					},
					["class"] = {
						["single"] = "MAGE",
						["multi"] = {
						},
					},
					["role"] = {
						["multi"] = {
						},
					},
					["use_combat"] = true,
					["use_class"] = true,
					["size"] = {
						["multi"] = {
						},
					},
				},
				["fontSize"] = 24,
				["displayStacks"] = " ",
				["regionType"] = "icon",
				["parent"] = "Mage Tier 6 Talents",
				["stacksPoint"] = "CENTER",
				["color"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					0.4200000166893, -- [4]
				},
				["stacksContainment"] = "INSIDE",
				["zoom"] = 0,
				["auto"] = true,
				["id"] = "RoP Missing",
				["additional_triggers"] = {
				},
				["icon"] = true,
				["frameStrata"] = 1,
				["width"] = 44,
				["numTriggers"] = 1,
				["selfPoint"] = "CENTER",
				["inverse"] = false,
				["yOffset"] = -253,
				["stickyDuration"] = false,
				["displayIcon"] = "Interface\\Icons\\spell_mage_runeofpower",
				["cooldown"] = false,
				["textColor"] = {
					1, -- [1]
					0.756862745098039, -- [2]
					0.0117647058823529, -- [3]
					1, -- [4]
				},
			},
			["Incanter's Flow Peak"] = {
				["color"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["untrigger"] = {
				},
				["anchorPoint"] = "CENTER",
				["customTextUpdate"] = "update",
				["actions"] = {
					["start"] = {
						["do_glow"] = false,
						["do_sound"] = false,
						["glow_frame"] = "WeakAuras:Incanter's Flow Peak",
						["sound"] = "Interface\\AddOns\\WeakAuras\\Media\\Sounds\\RobotBlip.ogg",
						["do_custom"] = false,
					},
					["finish"] = {
						["sound"] = "Interface\\AddOns\\WeakAuras\\Media\\Sounds\\CatMeow2.mp3",
						["do_sound"] = false,
					},
					["init"] = {
					},
				},
				["fontFlags"] = "OUTLINE",
				["animation"] = {
					["start"] = {
						["type"] = "none",
						["colorR"] = 1,
						["duration"] = "9",
						["duration_type"] = "seconds",
						["alphaType"] = "alphaPulse",
						["scalex"] = 1,
						["alpha"] = 0,
						["colorB"] = 1,
						["y"] = 0,
						["colorA"] = 1,
						["colorG"] = 1,
						["alphaFunc"] = "return function(progress, start, delta)\n local angle = (progress * 2 * math.pi) - (math.pi / 2)\n return start + (((math.sin(angle) + 1)/2) * delta)\nend\n",
						["x"] = 0,
						["rotate"] = 0,
						["scaley"] = 1,
						["use_alpha"] = true,
					},
					["main"] = {
						["duration"] = "1",
						["type"] = "none",
						["duration_type"] = "seconds",
					},
					["finish"] = {
						["type"] = "none",
						["duration_type"] = "seconds",
					},
				},
				["trigger"] = {
					["custom_hide"] = "timed",
					["type"] = "aura",
					["spellId"] = "116267",
					["subeventSuffix"] = "_CAST_START",
					["fullscan"] = true,
					["useCount"] = true,
					["event"] = "Health",
					["subeventPrefix"] = "SPELL",
					["count"] = "5",
					["use_spellId"] = true,
					["name"] = "Incanter's Flow",
					["unit"] = "player",
					["spellIds"] = {
					},
					["names"] = {
						"Incanter's Absorption", -- [1]
					},
					["countOperator"] = "==",
					["debuffType"] = "HELPFUL",
				},
				["desaturate"] = false,
				["progressPrecision"] = 0,
				["font"] = "ElvUI Font",
				["height"] = 44,
				["load"] = {
					["use_never"] = false,
					["talent"] = {
						["single"] = 18,
						["multi"] = {
						},
					},
					["class"] = {
						["single"] = "MAGE",
						["multi"] = {
						},
					},
					["use_talent"] = true,
					["difficulty"] = {
						["multi"] = {
						},
					},
					["race"] = {
						["multi"] = {
						},
					},
					["spec"] = {
						["single"] = 3,
						["multi"] = {
							[3] = true,
						},
					},
					["role"] = {
						["multi"] = {
						},
					},
					["use_class"] = true,
					["size"] = {
						["multi"] = {
						},
					},
				},
				["fontSize"] = 24,
				["displayStacks"] = "%s",
				["regionType"] = "icon",
				["parent"] = "Mage Tier 6 Talents",
				["cooldown"] = false,
				["stacksContainment"] = "INSIDE",
				["zoom"] = 0,
				["auto"] = true,
				["icon"] = true,
				["id"] = "Incanter's Flow Peak",
				["yOffset"] = -253,
				["frameStrata"] = 1,
				["width"] = 44,
				["additional_triggers"] = {
				},
				["numTriggers"] = 1,
				["inverse"] = false,
				["xOffset"] = 65,
				["stickyDuration"] = false,
				["selfPoint"] = "CENTER",
				["stacksPoint"] = "BOTTOMRIGHT",
				["textColor"] = {
					1, -- [1]
					0.976470588235294, -- [2]
					0.211764705882353, -- [3]
					1, -- [4]
				},
			},
			["Cauterize"] = {
				["textFlags"] = "None",
				["stacksSize"] = 12,
				["xOffset"] = 2.999755859375,
				["stacksFlags"] = "None",
				["yOffset"] = -151.000122070313,
				["anchorPoint"] = "CENTER",
				["sparkRotation"] = 0,
				["rotateText"] = "NONE",
				["backgroundColor"] = {
					0, -- [1]
					0, -- [2]
					0, -- [3]
					0.5, -- [4]
				},
				["fontFlags"] = "OUTLINE",
				["icon_color"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["selfPoint"] = "CENTER",
				["barColor"] = {
					1, -- [1]
					0, -- [2]
					0.0274509803921569, -- [3]
					1, -- [4]
				},
				["desaturate"] = false,
				["sparkOffsetY"] = 0,
				["load"] = {
					["use_class"] = true,
					["role"] = {
						["multi"] = {
						},
					},
					["difficulty"] = {
						["multi"] = {
						},
					},
					["talent"] = {
						["multi"] = {
						},
					},
					["race"] = {
						["multi"] = {
						},
					},
					["class"] = {
						["single"] = "MAGE",
						["multi"] = {
						},
					},
					["spec"] = {
						["single"] = 3,
						["multi"] = {
							[3] = true,
						},
					},
					["size"] = {
						["multi"] = {
						},
					},
				},
				["timerColor"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["regionType"] = "aurabar",
				["stacks"] = false,
				["texture"] = "KkthnxTex",
				["textFont"] = "Friz Quadrata TT",
				["borderOffset"] = 5,
				["spark"] = false,
				["timerFont"] = "Friz Quadrata TT",
				["alpha"] = 1,
				["borderInset"] = 4,
				["textColor"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["borderBackdrop"] = "Blizzard Tooltip",
				["parent"] = "Mage - General Procs",
				["barInFront"] = true,
				["sparkRotationMode"] = "AUTO",
				["displayTextLeft"] = "%n",
				["animation"] = {
					["start"] = {
						["type"] = "none",
						["duration_type"] = "seconds",
					},
					["main"] = {
						["type"] = "none",
						["duration_type"] = "seconds",
					},
					["finish"] = {
						["type"] = "none",
						["duration_type"] = "seconds",
					},
				},
				["trigger"] = {
					["rem"] = "10",
					["subeventSuffix"] = "_CAST_START",
					["ownOnly"] = true,
					["event"] = "Health",
					["names"] = {
						"Cauterize", -- [1]
					},
					["debuffType"] = "HARMFUL",
					["useRem"] = true,
					["spellIds"] = {
					},
					["subeventPrefix"] = "SPELL",
					["remOperator"] = "<=",
					["unit"] = "player",
					["type"] = "aura",
					["custom_hide"] = "timed",
				},
				["text"] = true,
				["stickyDuration"] = false,
				["height"] = 19.0000095367432,
				["timerFlags"] = "None",
				["sparkBlendMode"] = "ADD",
				["backdropColor"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					0.5, -- [4]
				},
				["actions"] = {
					["start"] = {
						["message"] = "I'm Cauterizing!! HELP!!! ",
						["do_sound"] = true,
						["message_type"] = "SAY",
						["sound"] = "Interface\\AddOns\\WeakAuras\\Media\\Sounds\\BoxingArenaSound.mp3",
						["do_message"] = true,
						["sound_channel"] = "Master",
					},
					["finish"] = {
					},
					["init"] = {
					},
				},
				["untrigger"] = {
				},
				["sparkWidth"] = 10,
				["icon"] = true,
				["border"] = true,
				["borderEdge"] = "Blizzard Tooltip",
				["textSize"] = 20,
				["borderSize"] = 16,
				["numTriggers"] = 1,
				["icon_side"] = "RIGHT",
				["timer"] = true,
				["customTextUpdate"] = "update",
				["sparkHeight"] = 30,
				["borderColor"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["sparkColor"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["stacksColor"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["displayTextRight"] = "%p",
				["additional_triggers"] = {
				},
				["id"] = "Cauterize",
				["timerSize"] = 23,
				["frameStrata"] = 1,
				["width"] = 258.000091552734,
				["auto"] = true,
				["sparkOffsetX"] = 0,
				["inverse"] = false,
				["sparkDesature"] = false,
				["orientation"] = "HORIZONTAL",
				["stacksFont"] = "Friz Quadrata TT",
				["sparkTexture"] = "Interface\\CastingBar\\UI-CastingBar-Spark",
				["zoom"] = 0,
			},
			["Toxic Power"] = {
				["color"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["untrigger"] = {
				},
				["anchorPoint"] = "CENTER",
				["customTextUpdate"] = "update",
				["actions"] = {
					["start"] = {
						["do_glow"] = true,
						["glow_action"] = "show",
						["do_sound"] = true,
						["sound"] = "Interface\\Addons\\WeakAuras\\PowerAurasMedia\\Sounds\\ESPARK1.ogg",
						["glow_frame"] = "WeakAuras:Toxic Power",
					},
					["finish"] = {
						["sound"] = "Interface\\AddOns\\WeakAuras\\Media\\Sounds\\CatMeow2.mp3",
						["do_sound"] = false,
					},
					["init"] = {
					},
				},
				["fontFlags"] = "OUTLINE",
				["animation"] = {
					["start"] = {
						["type"] = "none",
						["duration_type"] = "seconds",
					},
					["main"] = {
						["type"] = "none",
						["duration_type"] = "seconds",
					},
					["finish"] = {
						["type"] = "none",
						["duration_type"] = "seconds",
					},
				},
				["trigger"] = {
					["type"] = "aura",
					["subeventSuffix"] = "_CAST_START",
					["event"] = "Health",
					["names"] = {
						"Toxic Power", -- [1]
					},
					["spellIds"] = {
					},
					["debuffType"] = "HELPFUL",
					["unit"] = "player",
					["subeventPrefix"] = "SPELL",
					["custom_hide"] = "timed",
				},
				["desaturate"] = false,
				["progressPrecision"] = 0,
				["font"] = "Friz Quadrata TT",
				["height"] = 32,
				["load"] = {
					["use_never"] = true,
					["talent"] = {
						["single"] = 16,
						["multi"] = {
						},
					},
					["class"] = {
						["single"] = "MAGE",
						["multi"] = {
						},
					},
					["use_talent"] = false,
					["difficulty"] = {
						["multi"] = {
						},
					},
					["race"] = {
						["multi"] = {
						},
					},
					["spec"] = {
						["single"] = 3,
						["multi"] = {
							[3] = true,
						},
					},
					["use_class"] = true,
					["role"] = {
						["multi"] = {
						},
					},
					["size"] = {
						["multi"] = {
						},
					},
				},
				["fontSize"] = 15,
				["displayStacks"] = " %c",
				["regionType"] = "icon",
				["parent"] = "Mage - General Procs",
				["stacksPoint"] = "CENTER",
				["stacksContainment"] = "INSIDE",
				["zoom"] = 0,
				["auto"] = true,
				["additional_triggers"] = {
				},
				["id"] = "Toxic Power",
				["yOffset"] = -265,
				["frameStrata"] = 1,
				["width"] = 32,
				["stickyDuration"] = false,
				["numTriggers"] = 1,
				["inverse"] = false,
				["xOffset"] = -160,
				["icon"] = true,
				["selfPoint"] = "CENTER",
				["cooldown"] = true,
				["textColor"] = {
					1, -- [1]
					0.756862745098039, -- [2]
					0.0117647058823529, -- [3]
					1, -- [4]
				},
			},
			["Greater Invisibility"] = {
				["color"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["untrigger"] = {
				},
				["anchorPoint"] = "CENTER",
				["customTextUpdate"] = "update",
				["actions"] = {
					["start"] = {
						["do_glow"] = true,
						["glow_frame"] = "WeakAuras:Greater Invisibility",
						["glow_action"] = "show",
					},
					["finish"] = {
						["sound"] = "Interface\\AddOns\\WeakAuras\\Media\\Sounds\\CatMeow2.mp3",
						["do_sound"] = false,
					},
					["init"] = {
					},
				},
				["fontFlags"] = "OUTLINE",
				["animation"] = {
					["start"] = {
						["type"] = "none",
						["duration_type"] = "seconds",
					},
					["main"] = {
						["type"] = "none",
						["duration_type"] = "seconds",
					},
					["finish"] = {
						["type"] = "none",
						["duration_type"] = "seconds",
					},
				},
				["trigger"] = {
					["type"] = "aura",
					["spellId"] = "110960",
					["subeventSuffix"] = "_CAST_START",
					["event"] = "Health",
					["names"] = {
						"Greater Invisibility", -- [1]
					},
					["custom_hide"] = "timed",
					["use_spellId"] = true,
					["name"] = "Greater Invisibility",
					["fullscan"] = true,
					["unit"] = "player",
					["spellIds"] = {
					},
					["subeventPrefix"] = "SPELL",
					["debuffType"] = "HELPFUL",
				},
				["desaturate"] = false,
				["progressPrecision"] = 0,
				["font"] = "Friz Quadrata TT",
				["height"] = 32,
				["load"] = {
					["use_never"] = false,
					["talent"] = {
						["single"] = 16,
						["multi"] = {
						},
					},
					["class"] = {
						["single"] = "MAGE",
						["multi"] = {
						},
					},
					["use_talent"] = false,
					["difficulty"] = {
						["multi"] = {
						},
					},
					["race"] = {
						["multi"] = {
						},
					},
					["spec"] = {
						["single"] = 3,
						["multi"] = {
							[3] = true,
						},
					},
					["role"] = {
						["multi"] = {
						},
					},
					["use_class"] = true,
					["size"] = {
						["multi"] = {
						},
					},
				},
				["fontSize"] = 15,
				["displayStacks"] = " %c",
				["regionType"] = "icon",
				["parent"] = "Mage - General Procs",
				["stacksPoint"] = "CENTER",
				["stacksContainment"] = "INSIDE",
				["zoom"] = 0,
				["auto"] = true,
				["id"] = "Greater Invisibility",
				["additional_triggers"] = {
				},
				["yOffset"] = -265.000030517578,
				["frameStrata"] = 1,
				["width"] = 32,
				["stickyDuration"] = false,
				["numTriggers"] = 1,
				["inverse"] = false,
				["xOffset"] = -308.999938964844,
				["icon"] = true,
				["selfPoint"] = "CENTER",
				["cooldown"] = true,
				["textColor"] = {
					1, -- [1]
					0.756862745098039, -- [2]
					0.0117647058823529, -- [3]
					1, -- [4]
				},
			},
			["Incanter's Flow 3"] = {
				["color"] = {
					0.56078431372549, -- [1]
					0.56078431372549, -- [2]
					0.56078431372549, -- [3]
					1, -- [4]
				},
				["untrigger"] = {
				},
				["anchorPoint"] = "CENTER",
				["customTextUpdate"] = "update",
				["actions"] = {
					["start"] = {
						["do_glow"] = false,
						["do_sound"] = false,
						["glow_frame"] = "WeakAuras:Incanter's Flow Peak",
						["do_custom"] = false,
						["sound"] = "Interface\\AddOns\\WeakAuras\\Media\\Sounds\\RobotBlip.ogg",
					},
					["finish"] = {
						["sound"] = "Interface\\AddOns\\WeakAuras\\Media\\Sounds\\CatMeow2.mp3",
						["do_sound"] = false,
					},
					["init"] = {
					},
				},
				["fontFlags"] = "OUTLINE",
				["animation"] = {
					["start"] = {
						["type"] = "none",
						["colorR"] = 1,
						["scalex"] = 1,
						["duration_type"] = "seconds",
						["y"] = 0,
						["scaley"] = 1,
						["alpha"] = 0,
						["colorB"] = 1,
						["alphaType"] = "alphaPulse",
						["x"] = 0,
						["colorG"] = 1,
						["alphaFunc"] = "return function(progress, start, delta)\n local angle = (progress * 2 * math.pi) - (math.pi / 2)\n return start + (((math.sin(angle) + 1)/2) * delta)\nend\n",
						["colorA"] = 1,
						["rotate"] = 0,
						["duration"] = "9",
						["use_alpha"] = true,
					},
					["main"] = {
						["duration"] = "1",
						["type"] = "none",
						["duration_type"] = "seconds",
					},
					["finish"] = {
						["type"] = "none",
						["duration_type"] = "seconds",
					},
				},
				["trigger"] = {
					["custom_hide"] = "timed",
					["type"] = "aura",
					["spellId"] = "116267",
					["subeventSuffix"] = "_CAST_START",
					["fullscan"] = true,
					["use_spellId"] = true,
					["event"] = "Health",
					["subeventPrefix"] = "SPELL",
					["count"] = "3",
					["useCount"] = true,
					["name"] = "Incanter's Flow",
					["unit"] = "player",
					["spellIds"] = {
					},
					["names"] = {
						"Incanter's Absorption", -- [1]
					},
					["countOperator"] = "==",
					["debuffType"] = "HELPFUL",
				},
				["desaturate"] = false,
				["progressPrecision"] = 0,
				["font"] = "ElvUI Font",
				["height"] = 44,
				["load"] = {
					["use_never"] = false,
					["talent"] = {
						["single"] = 18,
						["multi"] = {
						},
					},
					["class"] = {
						["single"] = "MAGE",
						["multi"] = {
						},
					},
					["use_talent"] = true,
					["difficulty"] = {
						["multi"] = {
						},
					},
					["race"] = {
						["multi"] = {
						},
					},
					["spec"] = {
						["single"] = 3,
						["multi"] = {
							[3] = true,
						},
					},
					["role"] = {
						["multi"] = {
						},
					},
					["use_class"] = true,
					["size"] = {
						["multi"] = {
						},
					},
				},
				["fontSize"] = 24,
				["displayStacks"] = "%s",
				["regionType"] = "icon",
				["parent"] = "Mage Tier 6 Talents",
				["stacksPoint"] = "BOTTOMRIGHT",
				["stacksContainment"] = "INSIDE",
				["zoom"] = 0,
				["auto"] = true,
				["icon"] = true,
				["id"] = "Incanter's Flow 3",
				["yOffset"] = -253,
				["frameStrata"] = 1,
				["width"] = 44,
				["selfPoint"] = "CENTER",
				["numTriggers"] = 1,
				["inverse"] = false,
				["xOffset"] = 65,
				["stickyDuration"] = false,
				["additional_triggers"] = {
				},
				["cooldown"] = false,
				["textColor"] = {
					1, -- [1]
					0.976470588235294, -- [2]
					0.211764705882353, -- [3]
					1, -- [4]
				},
			},
			["Icy Veins Cooldown"] = {
				["color"] = {
					0.286274509803922, -- [1]
					1, -- [2]
					0.101960784313726, -- [3]
					1, -- [4]
				},
				["untrigger"] = {
					["spellName"] = 12472,
				},
				["anchorPoint"] = "CENTER",
				["customTextUpdate"] = "update",
				["actions"] = {
					["start"] = {
						["do_glow"] = false,
						["glow_action"] = "show",
						["do_sound"] = false,
						["do_custom"] = false,
						["glow_frame"] = "MultiBarBottomRightButton1",
						["sound"] = "Interface\\Addons\\WeakAuras\\PowerAurasMedia\\Sounds\\sonar.ogg",
						["sound_channel"] = "Master",
					},
					["finish"] = {
					},
					["init"] = {
					},
				},
				["fontFlags"] = "OUTLINE",
				["animation"] = {
					["start"] = {
						["type"] = "none",
						["duration_type"] = "seconds",
					},
					["main"] = {
						["type"] = "none",
						["duration_type"] = "seconds",
					},
					["finish"] = {
						["type"] = "none",
						["duration_type"] = "seconds",
					},
				},
				["trigger"] = {
					["type"] = "status",
					["custom_hide"] = "timed",
					["unevent"] = "auto",
					["use_showOn"] = true,
					["spellName"] = 12472,
					["event"] = "Cooldown Progress (Spell)",
					["subeventPrefix"] = "SPELL",
					["unit"] = "player",
					["use_spellName"] = true,
					["spellIds"] = {
					},
					["subeventSuffix"] = "_CAST_START",
					["showOn"] = "showOnCooldown",
					["names"] = {
					},
					["use_unit"] = true,
					["debuffType"] = "HELPFUL",
				},
				["desaturate"] = true,
				["progressPrecision"] = 0,
				["font"] = "Friz Quadrata TT",
				["height"] = 50,
				["load"] = {
					["talent"] = {
						["multi"] = {
						},
					},
					["spec"] = {
						["single"] = 3,
						["multi"] = {
							true, -- [1]
							[3] = true,
						},
					},
					["difficulty"] = {
						["multi"] = {
						},
					},
					["race"] = {
						["multi"] = {
						},
					},
					["use_spec"] = true,
					["class"] = {
						["single"] = "MAGE",
						["multi"] = {
						},
					},
					["role"] = {
						["multi"] = {
						},
					},
					["use_class"] = true,
					["size"] = {
						["multi"] = {
						},
					},
				},
				["fontSize"] = 24,
				["displayStacks"] = "%c",
				["regionType"] = "icon",
				["init_completed"] = 1,
				["parent"] = "Mage - Frost",
				["stacksPoint"] = "CENTER",
				["stacksContainment"] = "INSIDE",
				["zoom"] = 0,
				["auto"] = true,
				["additional_triggers"] = {
				},
				["id"] = "Icy Veins Cooldown",
				["yOffset"] = -284.999938964844,
				["frameStrata"] = 1,
				["width"] = 50,
				["icon"] = true,
				["numTriggers"] = 1,
				["inverse"] = false,
				["stickyDuration"] = false,
				["xOffset"] = -305.000183105469,
				["selfPoint"] = "CENTER",
				["cooldown"] = true,
				["textColor"] = {
					0.945098039215686, -- [1]
					1, -- [2]
					0.96078431372549, -- [3]
					1, -- [4]
				},
			},
			["Frozen Orb Cooldown"] = {
				["color"] = {
					0.286274509803922, -- [1]
					1, -- [2]
					0.101960784313726, -- [3]
					1, -- [4]
				},
				["untrigger"] = {
					["spellName"] = 84714,
				},
				["anchorPoint"] = "CENTER",
				["customTextUpdate"] = "update",
				["actions"] = {
					["start"] = {
						["do_glow"] = false,
						["do_sound"] = false,
						["glow_action"] = "show",
						["sound"] = "Interface\\Addons\\WeakAuras\\PowerAurasMedia\\Sounds\\sonar.ogg",
						["glow_frame"] = "MultiBarBottomRightButton1",
						["do_custom"] = false,
						["sound_channel"] = "Master",
					},
					["finish"] = {
					},
					["init"] = {
					},
				},
				["fontFlags"] = "OUTLINE",
				["animation"] = {
					["start"] = {
						["type"] = "none",
						["duration_type"] = "seconds",
					},
					["main"] = {
						["type"] = "none",
						["duration_type"] = "seconds",
					},
					["finish"] = {
						["type"] = "none",
						["duration_type"] = "seconds",
					},
				},
				["trigger"] = {
					["type"] = "status",
					["spellName"] = 84714,
					["unevent"] = "auto",
					["use_showOn"] = true,
					["custom_hide"] = "timed",
					["event"] = "Cooldown Progress (Spell)",
					["subeventPrefix"] = "SPELL",
					["unit"] = "player",
					["use_spellName"] = true,
					["spellIds"] = {
					},
					["subeventSuffix"] = "_CAST_START",
					["showOn"] = "showOnCooldown",
					["names"] = {
					},
					["use_unit"] = true,
					["debuffType"] = "HELPFUL",
				},
				["desaturate"] = true,
				["progressPrecision"] = 0,
				["font"] = "Friz Quadrata TT",
				["height"] = 50,
				["load"] = {
					["talent"] = {
						["multi"] = {
						},
					},
					["spec"] = {
						["single"] = 3,
						["multi"] = {
							true, -- [1]
							[3] = true,
						},
					},
					["difficulty"] = {
						["multi"] = {
						},
					},
					["race"] = {
						["multi"] = {
						},
					},
					["use_spec"] = true,
					["class"] = {
						["single"] = "MAGE",
						["multi"] = {
						},
					},
					["role"] = {
						["multi"] = {
						},
					},
					["use_class"] = true,
					["size"] = {
						["multi"] = {
						},
					},
				},
				["fontSize"] = 24,
				["displayStacks"] = "%c",
				["regionType"] = "icon",
				["init_completed"] = 1,
				["parent"] = "Mage - Frost",
				["cooldown"] = true,
				["stacksContainment"] = "INSIDE",
				["zoom"] = 0,
				["auto"] = true,
				["icon"] = true,
				["additional_triggers"] = {
				},
				["yOffset"] = -285.000122070313,
				["frameStrata"] = 1,
				["width"] = 50,
				["stickyDuration"] = false,
				["numTriggers"] = 1,
				["inverse"] = false,
				["xOffset"] = -196.000427246094,
				["id"] = "Frozen Orb Cooldown",
				["selfPoint"] = "CENTER",
				["stacksPoint"] = "CENTER",
				["textColor"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
			},
			["Greater Invisibility 2"] = {
				["color"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["untrigger"] = {
				},
				["anchorPoint"] = "CENTER",
				["customTextUpdate"] = "update",
				["actions"] = {
					["start"] = {
						["do_glow"] = true,
						["glow_frame"] = "WeakAuras:Greater Invisibility 2",
						["glow_action"] = "show",
					},
					["finish"] = {
						["sound"] = "Interface\\AddOns\\WeakAuras\\Media\\Sounds\\CatMeow2.mp3",
						["do_sound"] = false,
					},
					["init"] = {
					},
				},
				["fontFlags"] = "OUTLINE",
				["animation"] = {
					["start"] = {
						["type"] = "none",
						["duration_type"] = "seconds",
					},
					["main"] = {
						["type"] = "none",
						["duration_type"] = "seconds",
					},
					["finish"] = {
						["type"] = "none",
						["duration_type"] = "seconds",
					},
				},
				["trigger"] = {
					["type"] = "aura",
					["spellId"] = "113862",
					["subeventSuffix"] = "_CAST_START",
					["event"] = "Health",
					["names"] = {
						"Greater Invisibility", -- [1]
					},
					["fullscan"] = true,
					["use_spellId"] = true,
					["name"] = "Greater Invisibility",
					["custom_hide"] = "timed",
					["unit"] = "player",
					["spellIds"] = {
					},
					["subeventPrefix"] = "SPELL",
					["debuffType"] = "HELPFUL",
				},
				["desaturate"] = false,
				["progressPrecision"] = 0,
				["font"] = "Friz Quadrata TT",
				["height"] = 32,
				["load"] = {
					["use_never"] = false,
					["talent"] = {
						["single"] = 16,
						["multi"] = {
						},
					},
					["class"] = {
						["single"] = "MAGE",
						["multi"] = {
						},
					},
					["use_talent"] = false,
					["difficulty"] = {
						["multi"] = {
						},
					},
					["race"] = {
						["multi"] = {
						},
					},
					["spec"] = {
						["single"] = 3,
						["multi"] = {
							[3] = true,
						},
					},
					["role"] = {
						["multi"] = {
						},
					},
					["use_class"] = true,
					["size"] = {
						["multi"] = {
						},
					},
				},
				["fontSize"] = 15,
				["displayStacks"] = " %c",
				["regionType"] = "icon",
				["parent"] = "Mage - General Procs",
				["cooldown"] = true,
				["stacksContainment"] = "INSIDE",
				["zoom"] = 0,
				["auto"] = true,
				["id"] = "Greater Invisibility 2",
				["additional_triggers"] = {
				},
				["yOffset"] = -265,
				["frameStrata"] = 1,
				["width"] = 32,
				["stickyDuration"] = false,
				["numTriggers"] = 1,
				["inverse"] = false,
				["xOffset"] = -309,
				["icon"] = true,
				["selfPoint"] = "CENTER",
				["stacksPoint"] = "CENTER",
				["textColor"] = {
					1, -- [1]
					0.756862745098039, -- [2]
					0.0117647058823529, -- [3]
					1, -- [4]
				},
			},
			["Expanded Mind"] = {
				["color"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["untrigger"] = {
				},
				["anchorPoint"] = "CENTER",
				["customTextUpdate"] = "update",
				["actions"] = {
					["start"] = {
						["do_glow"] = false,
						["glow_action"] = "show",
						["do_sound"] = false,
						["sound"] = "Interface\\Addons\\WeakAuras\\PowerAurasMedia\\Sounds\\ESPARK1.ogg",
						["glow_frame"] = "WeakAuras:Expanded Mind",
					},
					["finish"] = {
						["sound"] = "Interface\\AddOns\\WeakAuras\\Media\\Sounds\\CatMeow2.mp3",
						["do_sound"] = false,
					},
					["init"] = {
					},
				},
				["fontFlags"] = "OUTLINE",
				["animation"] = {
					["start"] = {
						["type"] = "none",
						["duration_type"] = "seconds",
					},
					["main"] = {
						["type"] = "none",
						["duration_type"] = "seconds",
					},
					["finish"] = {
						["type"] = "none",
						["duration_type"] = "seconds",
					},
				},
				["trigger"] = {
					["type"] = "aura",
					["subeventSuffix"] = "_CAST_START",
					["event"] = "Health",
					["names"] = {
						"Intellect", -- [1]
					},
					["spellIds"] = {
						60234, -- [1]
					},
					["debuffType"] = "HELPFUL",
					["unit"] = "player",
					["subeventPrefix"] = "SPELL",
					["custom_hide"] = "timed",
				},
				["desaturate"] = false,
				["progressPrecision"] = 0,
				["font"] = "Friz Quadrata TT",
				["height"] = 32,
				["load"] = {
					["use_never"] = false,
					["talent"] = {
						["single"] = 16,
						["multi"] = {
						},
					},
					["spec"] = {
						["single"] = 3,
						["multi"] = {
							[3] = true,
						},
					},
					["use_class"] = true,
					["role"] = {
						["multi"] = {
						},
					},
					["class"] = {
						["single"] = "MAGE",
						["multi"] = {
						},
					},
					["race"] = {
						["multi"] = {
						},
					},
					["difficulty"] = {
						["multi"] = {
						},
					},
					["size"] = {
						["multi"] = {
						},
					},
				},
				["fontSize"] = 15,
				["displayStacks"] = " %c",
				["regionType"] = "icon",
				["parent"] = "Mage - General Procs",
				["cooldown"] = true,
				["stacksContainment"] = "INSIDE",
				["zoom"] = 0,
				["auto"] = true,
				["additional_triggers"] = {
				},
				["id"] = "Expanded Mind",
				["yOffset"] = -265,
				["frameStrata"] = 1,
				["width"] = 32,
				["stickyDuration"] = false,
				["numTriggers"] = 1,
				["inverse"] = false,
				["xOffset"] = -199.999938964844,
				["icon"] = true,
				["selfPoint"] = "CENTER",
				["stacksPoint"] = "CENTER",
				["textColor"] = {
					1, -- [1]
					0.756862745098039, -- [2]
					0.0117647058823529, -- [3]
					1, -- [4]
				},
			},
		},
		["frame"] = {
			["xOffset"] = -114.99951171875,
			["width"] = 629.999938964844,
			["height"] = 492,
			["yOffset"] = -47,
		},
	}
end

StaticPopupDialogs.SETTINGS_ALL = {
	text = L_POPUP_SETTINGS_ALL,
	button1 = ACCEPT,
	button2 = CANCEL,
	OnAccept = function()
		if IsAddOnLoaded("DBM-Core") and C.skins.dbm then K.UploadDBM() end
		if IsAddOnLoaded("Bartender4") then UploadBartender4() end
		if IsAddOnLoaded("BigWigs") then UploadBigWigs() end
		if IsAddOnLoaded("!ClassColors") then UploadColor() end
		if IsAddOnLoaded("Mapster") then UploadMapster() end
		if IsAddOnLoaded("Masque") then UploadBFacade() end
		if IsAddOnLoaded("MikScrollingBattleText") then UploadMSBT() end
		if IsAddOnLoaded("Skada") then UploadSkada() end
		if IsAddOnLoaded("WeakAuras") then UploadWeakAuras() end
		if IsAddOnLoaded("XLoot") then UploadXLoot() end
		if IsAddOnLoaded("Nameplates") then UploadPlates() end
		ReloadUI()
	end,
	timeout = 0,
	whileDead = 1,
	hideOnEscape = true,
	preferredIndex = 3,
}

SlashCmdList.SETTINGS = function(msg)
	if msg == "nameplates" then
		if IsAddOnLoaded("Nameplates") then
			UploadPlates()
			ReloadUI()
		else
			print("|cffffff00Nameplates"..L_INFO_NOT_INSTALLED.."|r")
		end
	elseif msg == "bfacade" then
		if IsAddOnLoaded("ButtonFacade") then
			UploadBFacade()
			ReloadUI()
		else
			print("|cffffff00ButtonFacade"..L_INFO_NOT_INSTALLED.."|r")
		end
	elseif msg == "color" then
		if IsAddOnLoaded("!ClassColors") then
			UploadColor()
			ReloadUI()
		else
			print("|cffffff00!ClassColors"..L_INFO_NOT_INSTALLED.."|r")
		end
	elseif msg == "mapster" then
		if IsAddOnLoaded("Mapster") then
			UploadMapster()
			ReloadUI()
		else
			print("|cffffff00Mapster"..L_INFO_NOT_INSTALLED.."|r")
		end
	elseif msg == "weakauras" then
		if IsAddOnLoaded("WeakAuras") then
			UploadWeakAuras()
			ReloadUI()
		else
			print("|cffffff00WeakAuras"..L_INFO_NOT_INSTALLED.."|r")
		end
	elseif msg == "bartender4" then
		if IsAddOnLoaded("Bartender4") then
			UploadBartender4()
			ReloadUI()
		else
			print("|cffffff00Bartender4"..L_INFO_NOT_INSTALLED.."|r")
		end
	elseif msg == "xloot" then
		if IsAddOnLoaded("XLoot") then
			UploadXLoot()
			ReloadUI()
		else
			print("|cffffff00XLoot"..L_INFO_NOT_INSTALLED.."|r")
		end
	elseif msg == "skada" then
		if IsAddOnLoaded("Skada") then
			UploadSkada()
			ReloadUI()
		else
			print("|cffffff00Skada"..L_INFO_NOT_INSTALLED.."|r")
		end
	elseif msg == "msbt" then
		if IsAddOnLoaded("MikScrollingBattleText") then
			UploadMSBT()
			ReloadUI()
		else
			print("|cffffff00MikScrollingBattleText"..L_INFO_NOT_INSTALLED.."|r")
		end
	elseif msg == "bigwigs" then
		if IsAddOnLoaded("BigWigs") then
			UploadBigWigs()
			ReloadUI()
		else
			print("|cffffff00Bigwigs"..L_INFO_NOT_INSTALLED.."|r")
		end
	elseif msg == "all" then
		StaticPopup_Show("SETTINGS_ALL")
	else
		print("|cffffff00"..L_INFO_SETTINGS_PLATES.."|r")
		print("|cffffff00"..L_INFO_SETTINGS_ALL.."|r")
		print("|cffffff00"..L_INFO_SETTINGS_BIGWIGS.."|r")
		print("|cffffff00"..L_INFO_SETTINGS_CLASSCOLOR.."|r")
		print("|cffffff00"..L_INFO_SETTINGS_BT4.."|r")
		print("|cffffff00"..L_INFO_SETTINGS_MAPSTER.."|r")
		print("|cffffff00"..L_INFO_SETTINGS_BUTTONFACADE.."|r")
		print("|cffffff00"..L_INFO_SETTINGS_MSBT.."|r")
		print("|cffffff00"..L_INFO_SETTINGS_SKADA.."|r")
		print("|cffffff00"..L_INFO_SETTINGS_WEAKAURAS.."|r")
		print("|cffffff00"..L_INFO_SETTINGS_XLOOT.."|r")
	end
end
SLASH_SETTINGS1 = "/settings"
SLASH_SETTINGS2 = "/profiles"