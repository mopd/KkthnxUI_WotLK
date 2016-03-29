local K, C, L = unpack(select(2, ...));

-- ButtonFacade Settings
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

-- ChatFilter Settings
local UploadChatFilter = function()
	if ChatConsolidateDB then table.wipe(ChatConsolidateDB) end
	
end

-- ThreatPlates
local UploadThreatPlates = function()
	if ThreatPlates3BetaDB then table.wipe(ThreatPlates3BetaDB) end
	ThreatPlates3BetaDB = {
		["char"] = {
			["Kkthnx - Lordaeron"] = {
				["specInfo"] = {
					{
						nil, -- [1]
						51, -- [2]
					}, -- [1]
				},
				["specName"] = {
					"Beast Mastery", -- [1]
					"Marksmanship", -- [2]
					"Survival", -- [3]
				},
				["welcome"] = true,
			},
		},
		["profileKeys"] = {
			["Kkthnx - Lordaeron"] = "Default",
		},
		["profiles"] = {
			["Default"] = {
				["OldSetting"] = false,
				["friendlyClass"] = {
					["toggle"] = false,
				},
				["threat"] = {
					["nonCombat"] = false,
					["useAlpha"] = false,
					["useScale"] = false,
					["useType"] = false,
					["toggle"] = {
						["Elite"] = false,
						["Boss"] = false,
						["Neutral"] = false,
						["Normal"] = false,
					},
					["useHPColor"] = false,
					["ON"] = false,
				},
				["nHPbarColor"] = {
					["r"] = 0.6509803921568628,
					["g"] = 0.6313725490196078,
					["b"] = 0.3490196078431372,
				},
				["eliteWidget"] = {
					["ON"] = false,
				},
				["cache"] = {
				},
				["customColor"] = {
					["toggle"] = true,
				},
				["settings"] = {
					["specialText"] = {
						["typeface"] = "KkUI Unitframe",
						["y"] = 0,
						["size"] = 10,
					},
					["level"] = {
						["y"] = 1,
						["x"] = 47,
						["typeface"] = "KkUI Unitframe",
						["vertical"] = "CENTER",
						["size"] = 11,
					},
					["normal"] = {
						["threatcolor"] = {
							["MEDIUM"] = {
								["a"] = 0,
							},
							["LOW"] = {
								["a"] = 0,
							},
							["HIGH"] = {
								["a"] = 0,
							},
						},
					},
					["dangerskull"] = {
						["anchor"] = "RIGHT",
						["x"] = -3,
						["scale"] = 12,
					},
					["specialText2"] = {
						["typeface"] = "KkUI Unitframe",
						["y"] = -40,
						["size"] = 11,
					},
					["name"] = {
						["y"] = 14,
						["typeface"] = "KkUI Unitframe",
						["size"] = 11,
					},
					["castbar"] = {
						["texture"] = "KkUI StatusBar",
					},
					["healthbar"] = {
						["texture"] = "KkUI StatusBar",
					},
				},
				["theme"] = "none",
				["targetWidget"] = {
					["level"] = 20,
				},
				["nameplate"] = {
					["scale"] = {
						["Elite"] = 1,
						["Boss"] = 1.2,
						["Neutral"] = 1,
					},
					["toggle"] = {
						["Totem"] = true,
					},
				},
				["blizzFade"] = {
					["toggle"] = false,
					["amount"] = -0.5,
				},
				["HPbarColor"] = {
					["r"] = 0.78,
					["g"] = 0.25,
					["b"] = 0.25,
				},
				["classWidget"] = {
					["y"] = 0,
					["x"] = -22,
					["scale"] = 20,
					["anchor"] = "LEFT",
				},
				["fHPbarColor"] = {
					["r"] = 0.3098039215686275,
					["g"] = 0.4509803921568628,
					["b"] = 0.6313725490196078,
				},
				["debuffWidget"] = {
					["mode"] = "all",
				},
				["uniqueWidget"] = {
					["y"] = -27,
					["x"] = 9,
					["scale"] = 14,
					["anchor"] = "LEFT",
				},
			},
		},
	}
end

-- Bartender 4
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

-- BigWigs settings
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
						["font"] = "KkUI Normal",
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
						["texture"] = "KkUI StatusBar",
						["barStyle"] = "BeautyCase",
						["BigWigsAnchor_width"] = 205.999908447266,
						["BigWigsEmphasizeAnchor_width"] = 240,
						["BigWigsEmphasizeAnchor_x"] = 257.422271858322,
						["font"] = "KkUI Normal",
					},
				},
			},
			["BigWigs_Plugins_Super Emphasize"] = {
				["profiles"] = {
					["Default"] = {
						["outline"] = "OUTLINE",
						["font"] = "KkUI Normal",
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
						["font"] = "KkUI Normal",
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
						["font"] = "KkUI Normal",
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

-- Nameplate settings
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
					["name"] = "KkUI Normal",
					["shadowEnabled"] = true,
					["size"] = 10,
				},
				["textureName"] = "KkUI StatusBar",
				["name"] = {
					["name"] = "KkUI Normal",
					["size"] = 11,
					["border"] = "OUTLINE",
					["shadowEnabled"] = true,
				},
				["level"] = {
					["name"] = "KkUI Normal",
					["border"] = "OUTLINE",
					["shadowEnabled"] = true,
				},
			},
			["Kkthnx - Lordaeron"] = {
			},
		},
	}
	
end

-- ClassTimer settings
local UploadClassTimer = function()
	if ClassTimerDB then table.wipe(ClassTimerDB) end
	ClassTimerDB = {
		["profileKeys"] = {
			["Kkthnx - Lordaeron"] = "Kkthnx - Lordaeron",
		},
		["profiles"] = {
			["Kkthnx - Lordaeron"] = {
				["Units"] = {
					["player"] = {
						["growup"] = true,
						["y"] = 347.0005207688285,
						["font"] = "KkUI Normal",
						["fontsize"] = 11,
						["differentColors"] = true,
						["x"] = 431.9998238344712,
					},
					["general"] = {
						["differentColors"] = true,
						["growup"] = true,
						["font"] = "KkUI Normal",
						["fontsize"] = 11,
					},
					["focus"] = {
						["debuffs"] = false,
						["growup"] = true,
						["icons"] = false,
						["y"] = 106.9988017871774,
						["x"] = 1234.99982212479,
						["height"] = 4,
						["buffs"] = false,
						["enable"] = false,
						["fontsize"] = 11,
						["click"] = false,
						["differentColors"] = true,
						["alpha"] = 0,
						["width"] = 50,
						["scale"] = 0.1,
						["spacing"] = -5,
						["font"] = "KkUI Normal",
					},
					["target"] = {
						["Poisoncolor"] = {
							0.2901960784313725, -- [1]
							0.7803921568627451, -- [2]
							0.2627450980392157, -- [3]
						},
						["reversed"] = false,
						["Diseasecolor"] = {
							0.7803921568627451, -- [1]
							0.2509803921568627, -- [2]
							0.2509803921568627, -- [3]
						},
						["growup"] = true,
						["y"] = 347.0003106832289,
						["font"] = "KkUI Normal",
						["Cursecolor"] = {
							0.7803921568627451, -- [1]
							0.3372549019607843, -- [2]
							0.7254901960784314, -- [3]
						},
						["fontsize"] = 11,
						["iconSide"] = "RIGHT",
						["Magiccolor"] = {
							0.3098039215686275, -- [1]
							0.4509803921568628, -- [2]
							0.6313725490196078, -- [3]
						},
						["differentColors"] = true,
						["reverseSort"] = false,
						["buffcolor"] = {
							0.1372549019607843, -- [1]
							0.4705882352941176, -- [2]
							0.6509803921568628, -- [3]
						},
						["alwaysshowndebuffcolor"] = {
							0.7725490196078432, -- [1]
							0.6745098039215687, -- [2]
							0.4235294117647059, -- [3]
						},
						["debuffcolor"] = {
							0.6509803921568628, -- [1]
							0.6313725490196078, -- [2]
							0.3490196078431372, -- [3]
						},
						["x"] = 1337.000722511185,
					},
					["sticky"] = {
						["differentColors"] = true,
						["growup"] = true,
						["font"] = "KkUI Normal",
						["fontsize"] = 11,
					},
					["pet"] = {
						["debuffs"] = false,
						["growup"] = true,
						["y"] = 96.99882353431956,
						["font"] = "KkUI Normal",
						["height"] = 4,
						["buffs"] = false,
						["enable"] = false,
						["fontsize"] = 11,
						["differentColors"] = true,
						["alpha"] = 0,
						["width"] = 50,
						["scale"] = 0.1,
						["spacing"] = -5,
						["x"] = 555.0000054025919,
					},
				},
			},
		},
	}
end

-- !ClassColor settings
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

-- XLoot settings
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
				["skin"] = "|cff69ccf0Kkthnx|r|cffffa500UI|r",
			},
		},
	}
end

-- Mapster settings
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

-- Skada settings
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

-- MSBT settings
local UploadMSBT = function()
	if MSBTProfiles_SavedVars then table.wipe(MSBTProfiles_SavedVars) end
	MSBTProfiles_SavedVars = {
	["profiles"] = {
		["Default"] = {
			["critFontName"] = "KkUI Damage",
			["stickyCritsDisabled"] = true,
			["animationSpeed"] = 70,
			["normalFontSize"] = 12.90480709075928,
			["textShadowingDisabled"] = true,
			["creationVersion"] = "5.4.78",
			["critFontSize"] = 24.23818206787109,
			["critOutlineIndex"] = 2,
			["events"] = {
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
				["NOTIFICATION_HOLY_POWER_FULL"] = {
					["disabled"] = true,
				},
				["NOTIFICATION_MONSTER_EMOTE"] = {
					["disabled"] = true,
				},
				["NOTIFICATION_REP_GAIN"] = {
					["disabled"] = true,
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
			["normalFontName"] = "KkUI Normal",
			["normalOutlineIndex"] = 2,
			["triggers"] = {
				["MSBT_TRIGGER_LOW_HEALTH"] = {
					["soundFile"] = "Omen: Aoogah!",
					["iconSkill"] = "3273",
					["mainEvents"] = "UNIT_HEALTH{unitID;;eq;;player;;threshold;;lt;;25}",
					["disabled"] = true,
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
					["disabled"] = true,
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
MSBT_SavedMedia = {
	["fonts"] = {
	},
	["sounds"] = {
	},
}
end

StaticPopupDialogs.SETTINGS_ALL = {
	text = L_POPUP_SETTINGS_ALL,
	button1 = ACCEPT,
	button2 = CANCEL,
	OnAccept = function()
		if IsAddOnLoaded("DBM-Core") and C["skins"].dbm then K.UploadDBM() end
		if IsAddOnLoaded("Bartender4") then UploadBartender4() end
		if IsAddOnLoaded("BigWigs") then UploadBigWigs() end
		if IsAddOnLoaded("ClassTimer") then UploadClassTimer() end		
		if IsAddOnLoaded("!ClassColors") then UploadColor() end
		if IsAddOnLoaded("Mapster") then UploadMapster() end
		if IsAddOnLoaded("Masque") then UploadBFacade() end
		if IsAddOnLoaded("MikScrollingBattleText") then UploadMSBT() end
		if IsAddOnLoaded("Skada") then UploadSkada() end
		if IsAddOnLoaded("ChatConsolidate") then UploadChatFilter() end
		if IsAddOnLoaded("XLoot") then UploadXLoot() end
		if IsAddOnLoaded("Nameplates") then UploadPlates() end
		if IsAddOnLoaded("TidyPlates_ThreatPlates") then UploadThreatPlates() end
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
	elseif msg == "threatplates" then
		if IsAddOnLoaded("TidyPlates_ThreatPlates") then
			UploadThreatPlates()
			ReloadUI()
		else
			print("|cffffff00TidyPlates_ThreatPlates"..L_INFO_NOT_INSTALLED.."|r")
		end
	elseif msg == "classtimer" then
		if IsAddOnLoaded("ClassTimer") then
			UploadClassTimer()
			ReloadUI()
		else
			print("|cffffff00ClassTimer"..L_INFO_NOT_INSTALLED.."|r")
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
	elseif msg == "chatfilter" then
		if IsAddOnLoaded("ChatConsolidate") then
			UploadChatFilter()
			ReloadUI()
		else
			print("|cffffff00ChatConsolidate"..L_INFO_NOT_INSTALLED.."|r")
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
		print("|cffffff00"..L_INFO_SETTINGS_CLASSTIMER.."|r")
		print("|cffffff00"..L_INFO_SETTINGS_CLASSCOLOR.."|r")
		print("|cffffff00"..L_INFO_SETTINGS_BT4.."|r")
		print("|cffffff00"..L_INFO_SETTINGS_MAPSTER.."|r")
		print("|cffffff00"..L_INFO_SETTINGS_BUTTONFACADE.."|r")
		print("|cffffff00"..L_INFO_SETTINGS_MSBT.."|r")
		print("|cffffff00"..L_INFO_SETTINGS_SKADA.."|r")
		print("|cffffff00"..L_INFO_SETTINGS_CHATCONSOLIDATE.."|r")
		print("|cffffff00"..L_INFO_SETTINGS_XLOOT.."|r")
		print("|cffffff00"..L_INFO_SETTINGS_THREATPLATES.."|r")
	end
end
SLASH_SETTINGS1 = "/settings"
SLASH_SETTINGS2 = "/profiles"