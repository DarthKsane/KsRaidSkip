local _G = getfenv(0)

local MODNAME	= "KsRaidSkip"
local addon = LibStub("AceAddon-3.0"):NewAddon(MODNAME, "AceEvent-3.0")


local ldb = LibStub:GetLibrary("LibDataBroker-1.1")
local L = LibStub("AceLocale-3.0"):GetLocale(MODNAME)
--local addonName, addon = ...
--local L = addon.L

local ICON_DONE = "|TInterface\\RaidFrame\\ReadyCheck-Ready:0|t"
local ICON_NOTDONE = "|TInterface\\RaidFrame\\ReadyCheck-NotReady:0|t"
local ICON_PROGRESS = "|TInterface\\RaidFrame\\ReadyCheck-Waiting:0|t"
local ICON_QUEST = "|TInterface\\Minimap\\Tracking\\TrivialQuests:0|t"

local q_status_icon = {
	[0] = ICON_NOTDONE, [1] = ICON_PROGRESS, [2] = ICON_DONE
}

local stored_quest_statuses = {}
local mythic_done_count = {}

local function showConfig()
  InterfaceOptionsFrame_OpenToCategory(MODNAME)
  InterfaceOptionsFrame_OpenToCategory(MODNAME)
end

local function normal(text)
  if not text then return "" end
  return NORMAL_FONT_COLOR_CODE..text..FONT_COLOR_CODE_CLOSE;
end

local function highlight(text)
  if not text then return "" end
  return HIGHLIGHT_FONT_COLOR_CODE..text..FONT_COLOR_CODE_CLOSE;
end

local function muted(text)
  if not text then return "" end
  return DISABLED_FONT_COLOR_CODE..text..FONT_COLOR_CODE_CLOSE;
end

local function yellow_text(text)
  if not text then return "" end
  return YELLOW_FONT_COLOR_CODE..text..FONT_COLOR_CODE_CLOSE;
end

local function green_text(text)
  if not text then return "" end
  return GREEN_FONT_COLOR_CODE..text..FONT_COLOR_CODE_CLOSE;
end

local function bn_text(text)
  if not text then return "" end
  return BATTLENET_FONT_COLOR_CODE..text..FONT_COLOR_CODE_CLOSE;
end

local function q_status(questID)
	local st=0
	if C_QuestLog.IsOnQuest(questID) then
		st=1
	else
		if C_QuestLog.IsQuestFlaggedCompleted(questID) then
			st=2
		else
			st=0
		end
	end
	return st
end

local function calc_quests()
	addon.info.mythic_total = 0
	addon.info.mythic_done = 0
	for i,exp in ipairs(questlist) do
		--print(i, exp.expname)
		for j,theraid in ipairs(exp.raids) do
			--print("  ", j,theraid.raidname)
			for k,rdif in ipairs(theraid.rqs) do
				--print("    ", k,rdif.dif)
				for l,thequest in ipairs(rdif.qs) do
					--print("      ", l,thequest.id,q_status(thequest.id), thequest.boss)
					stored_quest_statuses[thequest.id] = q_status(thequest.id)
					if (rdif.dif=="Mythic") then
						addon.info.mythic_total = addon.info.mythic_total + 1
						--print("      ", l,thequest.id,stored_quest_statuses[thequest.id], thequest.boss)

						if (stored_quest_statuses[thequest.id]==2) then
							addon.info.mythic_done = addon.info.mythic_done + 1
						end
					end
				end
			end
		end
	end
end

local function fmt_quest(questID)
	local qtitle = C_QuestLog.GetTitleForQuestID(questID)
	local t = ICON_QUEST
	if (qtitle~=nil) then 
		t=t..qtitle
	else
		t=t..questID
	end
	if (stored_quest_statuses[questID]~=nil) then
		t = t..q_status_icon[stored_quest_statuses[questID]]
	end
	return t
end



local function fmt_boss(bossID)
	local t = ""
	if bossID then
		local info = EJ_GetEncounterInfo(bossID)
		if (info~=nil) then
			t = info
		else
			t = "BossID:"..bossID
		end
	end
	return t
end


local function fmt_icon(icon)
	local text
	if not icon then icon = [[Interface\Icons\Temp]] end
	text = "  |T"..icon..":0:4|t ";
	-- |Tpath:0:aspectRatio|t
	return text;
end

-- C_QuestLog.GetTitleForQuestID(questID)
-- C_QuestLog.GetLogIndexForQuestID(questID)
-- isOnQuest = C_QuestLog.IsOnQuest(questID)
--  C_QuestLog.ReadyForTurnIn(questID)
-- API C QuestLog.IsQuestFlaggedCompleted


function addon:OnInitialize()
	self.info = {
		mythic_done = 0,
		mythic_total = 0,
		quests = {},
	}


	self:RegisterEvent("QUEST_TURNED_IN", "UpdateInfo_QTI")
	self:RegisterEvent("PLAYER_ENTERING_WORLD", "UpdateInfo_Load")

	self:UpdateInfo()
	self:MainUpdate()
end


function addon:OnEnable()
	self:UpdateInfo()
end

-- LDB object
addon.obj = ldb:NewDataObject(MODNAME, {
	type = "data source",
	label = "KsRaidSkip",
	text = "Sample text",
	icon = "Interface\\Icons\\spell_frost_stun",
	OnTooltipShow = function(tooltip)
		if not tooltip or not tooltip.AddLine then return end
		tooltip:AddLine(MODNAME.." v"..GetAddOnMetadata(MODNAME, "Version"))

		--iterate all questlist
		for i,exp in ipairs(questlist) do
			--print(i, exp.expname)
			local info = GetExpansionDisplayInfo(exp.expid)

			tooltip:AddLine(fmt_icon(info.logo).." "..bn_text(exp.expname))
--			tooltip:AddDoubleLine(bn_text(exp.expname), fmt_icon(info.logo))

			for j,theraid in ipairs(exp.raids) do
				--print("  ", j,theraid.raidname)
				local raidinfo = GetRealZoneText(theraid.raidid)

				tooltip:AddLine(highlight(raidinfo))
				local highdone = {[1]=0,[2]=0}
				for k,rdif in ipairs(theraid.rqs) do
					--print("    ", k,rdif.dif)
					--tooltip:AddLine(rdif.dif)
					for l,thequest in ipairs(rdif.qs) do
						--print("      ", l,thequest.id, thequest.boss)
						
						if highdone[l] < 2 then
							-- если квест выше сложностью не сдела, значит квест текущей сложности - самый топ
							-- значит, сохраняем статус квеста текущей сложности
							highdone[l] = stored_quest_statuses[thequest.id]
							tooltip:AddDoubleLine("["..L[rdif.dif].."] "..fmt_quest(thequest.id), fmt_boss(thequest.boss))
						else
							-- если квест выше сложностью сделан, значит квест текущей сложности не нужен
							--tooltip:AddLine("NOT NEEDED")
							tooltip:AddDoubleLine(muted("["..L[rdif.dif].."] "..fmt_quest(thequest.id)), fmt_boss(thequest.boss))
						end
						--tooltip:AddLine("["..L[rdif.dif].."] ")
						--tooltip:AddLine(fmt_quest(thequest.id))
					end
				end
			end
		end



		--tooltip:AddDoubleLine("DONE", ICON_DONE)
		--tooltip:AddDoubleLine("PROGRESS", ICON_PROGRESS)
		--tooltip:AddDoubleLine("NOTDONE", ICON_NOTDONE)


	end,
	OnClick = function(self, button)
      if button == "RightButton" then
        showConfig()
--      else
--        ToggleCharacter("TokenFrame");
      end
    end,
})



-- Main update function
function addon:MainUpdate()
	self.obj.text =  L["Mythic"]..": "..(string.format("%d / %d", self.info.mythic_done, self.info.mythic_total))
end


function addon:UpdateInfo_QTI(event, questID)
--	print(MODNAME.." - updated "..event.." "..questID)
	if stored_quest_statuses[questID] ~= nil then
		print(MODNAME..": "..questID.." - OUR QUEST! DO UPDATE")
		self:UpdateInfo()
--	else
--		print(MODNAME.." - not our quest ")
	end
end

function addon:UpdateInfo_Load()
	-- update on loading screen (any cause), to be sure
	self:UpdateInfo()
end



function addon:UpdateInfo()
	--here we store all quests' statuses
--	print(MODNAME.." - updated")

	calc_quests()
	self:MainUpdate()
end