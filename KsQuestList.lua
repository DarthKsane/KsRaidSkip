--0 LE_EXPANSION_CLASSIC	Classic
--1 LE_EXPANSION_BURNING_CRUSADE	The Burning Crusade
--2 LE_EXPANSION_WRATH_OF_THE_LICH_KING	Wrath of the Lich King
--3 LE_EXPANSION_CATACLYSM	Cataclysm
--4 LE_EXPANSION_MISTS_OF_PANDARIA	Mists of Pandaria
--5 LE_EXPANSION_WARLORDS_OF_DRAENOR	Warlords of Draenor
--6 LE_EXPANSION_LEGION	Legion
--7 LE_EXPANSION_BATTLE_FOR_AZEROTH	Battle for Azeroth
--8 LE_EXPANSION_SHADOWLANDS	Shadowlands
--9 LE_EXPANSION_10_0	
--10 LE_EXPANSION_11_0	

questlist = {
	[1] = {
		["expname"] = "Warlords of Draenor",
		["expid"] = LE_EXPANSION_WARLORDS_OF_DRAENOR,
		["raids"] = {
			[1] = {
				["raidname"] = "BRF",
				["raidid"] = 1205,
				["rqs"] = {
					[1] = {
						["dif"] = "Mythic",
						["qs"] = { [1]={["id"]=37031, ["boss"]=nil},},
					},
					[2] = {
						["dif"] = "Heroic",
						["qs"] = { [1]={["id"]=37030, ["boss"]=nil},},
					},
					[3] = {
						["dif"] = "Normal",
						["qs"] = { [1]={["id"]=37029, ["boss"]=nil},},
					},
				},
			}, --raid1 end

			[2] = {
				["raidname"] = "HFC",
				["raidid"] = 1448,
				["rqs"] = {
					[1] = {
						["dif"] = "Mythic",
						["qs"] = { [1]={["id"]=39501, ["boss"]=1372},[2]={["id"]=39505, ["boss"]=1395},},
					},
					[2] = {
						["dif"] = "Heroic",
						["qs"] = { [1]={["id"]=39500, ["boss"]=1372},[2]={["id"]=39504, ["boss"]=1395},},
					},
					[3] = {
						["dif"] = "Normal",
						["qs"] = { [1]={["id"]=39499, ["boss"]=1372},[2]={["id"]=39502, ["boss"]=1395},},
					},
				},
			}, --raid2 end
		},-- raidlist end
	}, -- exp end
	[2] = {
		["expname"] = "Legion",
		["expid"] = LE_EXPANSION_LEGION,
		["raids"] = {
			[1] = {
				["raidname"] = "EN",
				["raidid"] = 1520,
				["rqs"] = {
					[1] = {
						["dif"] = "Mythic",
						["qs"] = { [1]={["id"]=44285, ["boss"]=1750},},
					},
					[2] = {
						["dif"] = "Heroic",
						["qs"] = { [1]={["id"]=44284, ["boss"]=1750},},
					},
					[3] = {
						["dif"] = "Normal",
						["qs"] = { [1]={["id"]=44283, ["boss"]=1750},},
					},
				},
			}, --raid1 end

			[2] = {
				["raidname"] = "NH",
				["raidid"] = 1530,
				["rqs"] = {
					[1] = {
						["dif"] = "Mythic",
						["qs"] = { [1]={["id"]=45383, ["boss"]=1743},},
					},
					[2] = {
						["dif"] = "Heroic",
						["qs"] = { [1]={["id"]=45382, ["boss"]=1743},},
					},
					[3] = {
						["dif"] = "Normal",
						["qs"] = { [1]={["id"]=45381, ["boss"]=1743},},
					},
				},
			}, --raid2 end

			[3] = {
				["raidname"] = "ToS",
				["raidid"] = 1676,
				["rqs"] = {
					[1] = {
						["dif"] = "Mythic",
						["qs"] = { [1]={["id"]=47727, ["boss"]=1897},},
					},
					[2] = {
						["dif"] = "Heroic",
						["qs"] = { [1]={["id"]=47726, ["boss"]=1897},},
					},
					[3] = {
						["dif"] = "Normal",
						["qs"] = { [1]={["id"]=47725, ["boss"]=1897},},
					},
				},
			}, --raid2 end

			[4] = {
				["raidname"] = "Antorus",
				["raidid"] = 1712,
				["rqs"] = {
					[1] = {
						["dif"] = "Mythic",
						["qs"] = { [1]={["id"]=49076, ["boss"]=2009},[2]={["id"]=49135, ["boss"]=1984},},
					},
					[2] = {
						["dif"] = "Heroic",
						["qs"] = { [1]={["id"]=49075, ["boss"]=2009},[2]={["id"]=49134, ["boss"]=1984},},
					},
					[3] = {
						["dif"] = "Normal",
						["qs"] = { [1]={["id"]=49032, ["boss"]=2009},[2]={["id"]=49133, ["boss"]=1984},},
					},
				},
			}, --raid2 end


		},-- raidlist end
	}, -- exp end	
-- LE_EXPANSION_BATTLE_FOR_AZEROTH
	[3] = {
		["expname"] = "Battle for Azeroth",
		["expid"] = LE_EXPANSION_BATTLE_FOR_AZEROTH,
		["raids"] = {
			[1] = {
				["raidname"] = "NYA",
				["raidid"] = 2217,
				["rqs"] = {
					[1] = {
						["dif"] = "Mythic",
						["qs"] = { [1]={["id"]=58375, ["boss"]=nil},},
					},
					[2] = {
						["dif"] = "Heroic",
						["qs"] = { [1]={["id"]=58374, ["boss"]=nil},},
					},
					[3] = {
						["dif"] = "Normal",
						["qs"] = { [1]={["id"]=58373, ["boss"]=nil},},
					},
				},
			}, --raid1 end
		},-- raidlist end
	}, -- exp end

} --list end

-- HFC 1448 : normal - 39499 (gore), 39502 (mann) , heroic - 39500, 39504 , mythic - 39501, 39505
-- gore /dump EJ_GetEncounterInfo(1372)
-- mann /dump EJ_GetEncounterInfo(1395)
-- EN 1520 : normal 44283 (ken 1750), heroic 44284, mythic 44285
-- NH 1530: normal 45381 (eli 1743), heroic 45382, mythic 45383
-- ToS 1676: normal 47725 (maid 1897), heroic 47726, mythic 47727
-- Ant 1712: normal 49032 (imonar 2009), 49133 (aggramar 1984), heroic 49075, 49134, mythic 49076, 49135
-- Nya 2217: normal 58373, heroic 58374, mythic 58375