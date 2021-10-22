---@class PPI : module
local M = {}


--#region Constants
local call = remote.call
--#endregion


--#region Settings
local update_tick = settings.global["PPI_update_tick"].value
local income = settings.global["PPI_income"].value
--#endregion


--#region Functions of events

local function add_money()
	for player_index, money in pairs(call("EasyAPI", "get_online_players_money")) do
		call("EasyAPI", "set_online_player_money_by_index", player_index, money + income)
	end
end

local mod_settings = {
	["PPI_income"] = function(value) income = value end,
	["PPI_update_tick"] = function(value)
		script.on_nth_tick(update_tick, nil)
		M.on_nth_tick[update_tick] = nil
		update_tick = value
		if update_tick > 0 then
			M.on_nth_tick[value] = add_money
			script.on_nth_tick(value, add_money)
		end
	end
}
local function on_runtime_mod_setting_changed(event)
	local f = mod_settings[event.setting]
	if f then f(settings.global[event.setting].value) end
end

--#endregion


--#region Pre-game stage

local function add_remote_interface()
	-- https://lua-api.factorio.com/latest/LuaRemote.html
	remote.remove_interface("passive_player_income") -- For safety
	remote.add_interface("passive_player_income", {})
end

M.add_remote_interface = add_remote_interface

--#endregion


M.events = {
	[defines.events.on_runtime_mod_setting_changed] = on_runtime_mod_setting_changed
}

M.on_nth_tick = {}
if update_tick > 0 then
	M.on_nth_tick[update_tick] = add_money
end

return M
