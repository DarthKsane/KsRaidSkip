local addonName, addon = ...
local L = addon.L
local ldbi = LibStub('LibDBIcon-1.0', true)

local function build()
  local t = {
    name = "KsRaidSkip",
    handler = KsRaidSkip,
    type = 'group',
    args = {
      showMinimapIcon = {
        type = 'toggle',
        name = "Show minimap button",
        desc = "Show the KsRaidSkip minimap button",
        order = 0,
        get = function(info) 
          --local config = addon:getDB("minimap")
          return false --not config.hide 
        end,
        set = function(info, value)
--          local config = addon:getDB("minimap")
--          config.hide = not value
--          addon:setDB("minimap", config)
--          ldbi:Refresh(addonName)
        end,
      },
    },
  }

  -- return our new table
  return t
end

LibStub("AceConfig-3.0"):RegisterOptionsTable("KsRaidSkip", build, nil)
addon.optionsFrame = LibStub("AceConfigDialog-3.0"):AddToBlizOptions(addonName, "KsRaidSkip")
LibStub("AceConsole-3.0"):RegisterChatCommand("ksrs", function() InterfaceOptionsFrame_OpenToCategory(addon.optionsFrame) end)