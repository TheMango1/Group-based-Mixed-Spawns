if not GBMS then

	GBMS = {
		mod_path = ModPath,
		save_path = SavePath .. "group_based_mixed_spawns.json",
		settings = {
			is_enabled = true,
			spawn_group_set = 1,
		},
		values = {
			spawn_group_set = {
				"gbms_spawn_group_set_housewarming_fixed",
				"gbms_spawn_group_set_housewarming",
				"gbms_spawn_group_set_old",
			},
		},
	}

	function GBMS:error(...)
		log("[GroupBasedMixedSpawns][Error] " .. table.concat({...}, " "))
	end

	function GBMS:get_spawn_group_set()
		return self.values.spawn_group_set[self.settings.spawn_group_set]:gsub("^gbms_spawn_group_set_", "")
	end

	function GBMS:swap_groups(group_ai, new_groups)
		for _, task in pairs({ "assault", "recon", "reenforce" }) do
			local groups = group_ai.besiege[task] and group_ai.besiege[task].groups
			local new_groups = new_groups[task]

			if groups then
				for group, _ in pairs(groups) do
					groups[group] = { 0, 0, 0 }
				end

				for group, weights in pairs(new_groups) do
					groups[group] = weights
				end
			end
		end
	end

	function GBMS.task_data_housewarming_fixed(group_ai, difficulty_index)
		local new_groups = {
			assault = {},
			reenforce = {},
			recon = {}
		}

		local function weight_static(n)
			return { n, n, n }
		end
		local function weight_inc(n)
			return { 0, n * 0.5, n }
		end
		local function weight_dec(n)
			return { n, n * 0.5, 0 }
		end

		if difficulty_index <= 2 then
			new_groups.assault = {
				mpdc_swat_shotgun_rush = weight_static(0.05),
				mpdc_swat_shotgun_flank = weight_static(0.05),
				mpdc_swat_rifle = weight_static(0.05),
				mpdc_swat_rifle_flank = weight_static(0.05),
				mpdc_shield_wall_ranged = weight_static(0.1),
				mpdc_shield_wall_charge = weight_static(0.1),
			}
			new_groups.reenforce = {
				mpdc_swat_shotgun_rush = weight_static(0),
				mpdc_swat_shotgun_flank = weight_static(0),
				mpdc_swat_rifle = weight_static(0),
				mpdc_swat_rifle_flank = weight_static(0),
			}
			new_groups.recon = {
				mpdc_swat_shotgun_rush = weight_static(0.1),
				mpdc_swat_shotgun_flank = weight_static(0.1),
				mpdc_swat_rifle = weight_static(0.1),
				mpdc_swat_rifle_flank = weight_static(0.1),
			}
		elseif difficulty_index == 3 then
			new_groups.assault = {
				mpdc_swat_shotgun_rush = weight_static(0.05),
				mpdc_swat_shotgun_flank = weight_static(0.05),
				mpdc_swat_rifle = weight_static(0.05),
				mpdc_swat_rifle_flank = weight_static(0.05),
				mpdc_shield_wall_ranged = weight_static(0.1),
				mpdc_shield_wall_charge = weight_static(0.1),
				mpdc_shield_wall = weight_static(0.1),
				mpdc_tazer_flanking = weight_static(0.1),
				mpdc_tazer_charge = weight_static(0.1),
			}
			new_groups.reenforce = {
				mpdc_swat_shotgun_rush = weight_static(0),
				mpdc_swat_shotgun_flank = weight_static(0),
				mpdc_swat_rifle = weight_static(0),
				mpdc_swat_rifle_flank = weight_static(0),
			}
			new_groups.recon = {
				mpdc_swat_shotgun_rush = weight_static(0.1),
				mpdc_swat_shotgun_flank = weight_static(0.1),
				mpdc_swat_rifle = weight_static(0.1),
				mpdc_swat_rifle_flank = weight_static(0.1),
			}
		elseif difficulty_index == 4 then
			new_groups.assault = {
				mpdc_swat_shotgun_rush = weight_dec(0.05),
				fbi_swat_shotgun_rush = weight_inc(0.05),
				mpdc_swat_shotgun_flank = weight_dec(0.05),
				fbi_swat_shotgun_flank = weight_inc(0.05),
				mpdc_swat_rifle = weight_dec(0.05),
				fbi_swat_rifle = weight_inc(0.05),
				mpdc_swat_rifle_flank = weight_dec(0.05),
				fbi_swat_rifle_flank = weight_inc(0.05),
				mpdc_shield_wall_ranged = weight_dec(0.03),
				fbi_shield_wall_ranged = weight_inc(0.03),
				mpdc_shield_wall_charge = weight_dec(0.03),
				fbi_shield_wall_charge = weight_inc(0.03),
				mpdc_shield_wall = weight_dec(0.03),
				fbi_shield_wall = weight_inc(0.03),
				mpdc_tazer_flanking = weight_dec(0.045),
				fbi_tazer_flanking = weight_inc(0.045),
				mpdc_tazer_charge = weight_dec(0.045),
				fbi_tazer_charge = weight_inc(0.045),
				FBI_spoocs = weight_static(0.02),
				mpdc_bull_rush = weight_dec(0.04),
				fbi_bull_rush = weight_inc(0.04),
			}
			new_groups.reenforce = {
				mpdc_swat_shotgun_rush = weight_static(0),
				mpdc_swat_shotgun_flank = weight_static(0),
				mpdc_swat_rifle = weight_static(0),
				mpdc_swat_rifle_flank = weight_static(0),
			}
			new_groups.recon = {
				mpdc_swat_shotgun_rush = weight_static(0.1),
				mpdc_swat_shotgun_flank = weight_static(0.1),
				mpdc_swat_rifle = weight_static(0.1),
				mpdc_swat_rifle_flank = weight_static(0.1),
			}
		elseif difficulty_index == 5 then
			new_groups.assault = {
				fbi_swat_shotgun_rush = weight_static(0.05),
				fbi_swat_shotgun_flank = weight_static(0.05),
				fbi_swat_rifle = weight_static(0.05),
				fbi_swat_rifle_flank = weight_static(0.05),
				fbi_shield_wall_ranged = weight_static(0.03),
				fbi_shield_wall_charge = weight_static(0.03),
				fbi_shield_wall = weight_static(0.03),
				fbi_tazer_flanking = weight_static(0.045),
				fbi_tazer_charge = weight_static(0.045),
				FBI_spoocs = weight_static(0.02),
				fbi_bull_rush = weight_static(0.04),
			}
			new_groups.reenforce = {
				fbi_swat_shotgun_rush = weight_static(0),
				fbi_swat_shotgun_flank = weight_static(0),
				fbi_swat_rifle = weight_static(0),
				fbi_swat_rifle_flank = weight_static(0),
			}
			new_groups.recon = {
				fbi_swat_shotgun_rush = weight_static(0.1),
				fbi_swat_shotgun_flank = weight_static(0.1),
				fbi_swat_rifle = weight_static(0.1),
				fbi_swat_rifle_flank = weight_static(0.1),
			}
		elseif difficulty_index == 6 then
			new_groups.assault = {
				fbi_swat_shotgun_rush = weight_dec(0.045),
				city_swat_shotgun_rush = weight_inc(0.045),
				fbi_swat_shotgun_flank = weight_dec(0.045),
				city_swat_shotgun_flank = weight_inc(0.045),
				fbi_swat_rifle = weight_dec(0.045),
				city_swat_rifle = weight_inc(0.045),
				fbi_swat_rifle_flank = weight_dec(0.045),
				city_swat_rifle_flank = weight_inc(0.045),
				fbi_shield_wall_ranged = weight_dec(0.033),
				city_shield_wall_ranged = weight_inc(0.033),
				fbi_shield_wall_charge = weight_dec(0.033),
				city_shield_wall_charge = weight_inc(0.033),
				fbi_shield_wall = weight_dec(0.033),
				city_shield_wall = weight_inc(0.033),
				fbi_tazer_flanking = weight_dec(0.05),
				city_tazer_flanking = weight_inc(0.05),
				fbi_tazer_charge = weight_dec(0.05),
				city_tazer_charge = weight_inc(0.05),
				FBI_spoocs = weight_static(0.03),
				fbi_bull_rush = weight_dec(0.025),
				city_bull_rush = weight_inc(0.025),
			}
			new_groups.reenforce = {
				fbi_swat_shotgun_rush = weight_static(0),
				fbi_swat_shotgun_flank = weight_static(0),
				fbi_swat_rifle = weight_static(0),
				fbi_swat_rifle_flank = weight_static(0),
			}
			new_groups.recon = {
				fbi_swat_shotgun_rush = weight_static(0.1),
				fbi_swat_shotgun_flank = weight_static(0.1),
				fbi_swat_rifle = weight_static(0.1),
				fbi_swat_rifle_flank = weight_static(0.1),
			}
		elseif difficulty_index == 7 then
			new_groups.assault = {
				city_swat_shotgun_rush = weight_static(0.045),
				city_swat_shotgun_flank = weight_static(0.045),
				city_swat_rifle = weight_static(0.045),
				city_swat_rifle_flank = weight_static(0.045),
				city_shield_wall_ranged = weight_static(0.033),
				city_shield_wall_charge = weight_static(0.033),
				city_shield_wall = weight_static(0.033),
				city_tazer_flanking = weight_static(0.05),
				city_tazer_charge = weight_static(0.05),
				FBI_spoocs = weight_static(0.03),
				city_bull_rush = weight_static(0.05),
			}
			new_groups.reenforce = {
				city_swat_shotgun_rush = weight_static(0),
				city_swat_shotgun_flank = weight_static(0),
				city_swat_rifle = weight_static(0),
				city_swat_rifle_flank = weight_static(0),
			}
			new_groups.recon = {
				city_swat_shotgun_rush = weight_static(0.1),
				city_swat_shotgun_flank = weight_static(0.1),
				city_swat_rifle = weight_static(0.1),
				city_swat_rifle_flank = weight_static(0.1),
			}
		else
			new_groups.assault = {
				zeal_swat_shotgun_rush = weight_static(0.045),
				zeal_swat_shotgun_flank = weight_static(0.045),
				zeal_swat_rifle = weight_static(0.045),
				zeal_swat_rifle_flank = weight_static(0.045),
				zeal_shield_wall_ranged = weight_static(0.033),
				zeal_shield_wall_charge = weight_static(0.033),
				zeal_shield_wall = weight_static(0.033),
				zeal_tazer_flanking = weight_static(0.05),
				zeal_tazer_charge = weight_static(0.05),
				ZEAL_spoocs = weight_static(0.05),
				zeal_bull_rush = weight_static(0.05),
			}
			new_groups.reenforce = {
				zeal_swat_shotgun_rush = weight_static(0),
				zeal_swat_shotgun_flank = weight_static(0),
				zeal_swat_rifle = weight_static(0),
				zeal_swat_rifle_flank = weight_static(0),
			}
			new_groups.recon = {
				zeal_swat_shotgun_rush = weight_static(0.1),
				zeal_swat_shotgun_flank = weight_static(0.1),
				zeal_swat_rifle = weight_static(0.1),
				zeal_swat_rifle_flank = weight_static(0.1),
			}
		end

		return new_groups
	end

	function GBMS.task_data_housewarming(group_ai, difficulty_index)
		local new_groups = GBMS.task_data_housewarming_fixed(group_ai, difficulty_index)

		for task, task_groups in pairs(new_groups) do
			for id, data in pairs(task_groups) do
				if id:match("shotgun") or id:match("rifle") and not id:match("flank") then
					task_groups[id] = { 0, 0, 0 }
				elseif id:match("rifle_flank") then
					task_groups[id] = table.collect(clone(data), function(val) return val * 4 end)
				end
			end
		end

		return new_groups
	end

	function GBMS.task_data_old(group_ai, difficulty_index)
		local new_groups = {
			assault = {},
			reenforce = {},
			recon = {}
		}

		if difficulty_index <= 2 then
			new_groups.assault = {
				CS_swats = { 0, 1, 0.85 },
				CS_shields = { 0, 0, 0.15 },
			}
			new_groups.reenforce = {
				CS_defend_a = { 1, 0.2, 0 },
				CS_defend_b = { 0, 1, 1 },
			}
			new_groups.recon = {
				CS_stealth_a = { 1, 1, 0 },
				CS_swats = { 0, 1, 1 },
			}
		elseif difficulty_index == 3 then
			new_groups.assault = {
				CS_swats = { 0, 1, 0 },
				CS_heavys = { 0, 0.2, 0.7 },
				CS_shields = { 0, 0.02, 0.2 },
				CS_tazers = { 0, 0.05, 0.15 },
				CS_tanks = { 0, 0.01, 0.05 },
			}
			new_groups.reenforce = {
				CS_defend_a = { 1, 0, 0 },
				CS_defend_b = { 2, 1, 0 },
				CS_defend_c = { 0, 0, 1 },
			}
			new_groups.recon = {
				CS_stealth_a = { 1, 0, 0 },
				CS_swats = { 0, 1, 1 },
				CS_tazers = { 0, 0.1, 0.15 },
				FBI_stealth_b = { 0, 0, 0.1 },
			}
		elseif difficulty_index == 4 then
			new_groups.assault = {
				-- FBI_swats = { 0.1, 1, 1 },
				CS_swats = { 0.1, 0.5, 0 },
				FBI_swats = { 0, 0.5, 1 },
				-- FBI_heavys = { 0.05, 0.25, 0.5 },
				CS_heavys = { 0.05, 0.125, 0 },
				FBI_heavys = { 0, 0.125, 0.5 },
				-- FBI_shields = { 0.1, 0.2, 0.2 },
				CS_shields = { 0.1, 0.1, 0 },
				FBI_shields = { 0, 0.1, 0.2 },
				-- FBI_tanks = { 0, 0.1, 0.15 },
				CS_tanks = { 0, 0.05, 0 },
				FBI_tanks = { 0, 0.05, 0.15 },
				FBI_spoocs = { 0, 0.1, 0.2 },
				-- CS_tazers = { 0.05, 0.15, 0.2 },
				CS_tazers = { 0.05, 0.075, 0 },
				FBI_tazers = { 0, 0.075, 0.2 },
			}
			new_groups.reenforce = {
				CS_defend_a = { 1, 0, 0 },
				CS_defend_b = { 2, 1, 0 },
				CS_defend_c = { 0, 0, 1 },
				FBI_defend_a = { 0, 1, 0 },
				FBI_defend_b = { 0, 0, 1 },
			}
			new_groups.recon = {
				FBI_stealth_a = { 1, 0.5, 0 },
				FBI_stealth_b = { 0, 0, 1 },
			}
		elseif difficulty_index == 5 then
			new_groups.assault = {
				FBI_swats = { 0.2, 1, 1 },
				FBI_heavys = { 0.1, 0.5, 0.75 },
				FBI_shields = { 0.1, 0.3, 0.4 },
				FBI_tanks = { 0, 0.25, 0.3 },
				FBI_tazers = { 0.1, 0.25, 0.25 },
			}
			new_groups.reenforce = {
				CS_defend_a = { 0.1, 0, 0 },
				FBI_defend_b = { 1, 1, 0 },
				FBI_defend_c = { 0, 1, 0 },
				FBI_defend_d = { 0, 0, 1 },
			}
			new_groups.recon = {
				FBI_stealth_a = { 0.5, 1, 1 },
				FBI_stealth_b = { 0.25, 0.5, 1 },
			}
		elseif difficulty_index == 6 then
			new_groups.assault = {
				-- FBI_swats = { 0.2, 0.8, 0.8 },
				FBI_swats = { 0.2, 0.4, 0 },
				CITY_swats = { 0, 0.4, 0.8 },
				-- FBI_heavys = { 0.1, 0.3, 0.4 },
				FBI_heavys = { 0.1, 0.15, 0 },
				CITY_heavys = { 0, 0.15, 0.4 },
				-- FBI_shields = { 0.1, 0.5, 0.4 },
				FBI_shields = { 0.1, 0.25, 0 },
				CITY_shields = { 0, 0.25, 0.4 },
				-- FBI_tanks = { 0.1, 0.5, 0.5 },
				FBI_tanks = { 0.1, 0.25, 0 },
				CITY_tanks = { 0, 0.25, 0.5 },
				-- CS_tazers = { 0.1, 0.5, 0.45 },
				FBI_tazers = { 0.1, 0.25, 0 },
				CITY_tazers = { 0, 0.25, 0.45 },
				FBI_spoocs = { 0, 0.45, 0.45 },
			}
			new_groups.reenforce = {
				CS_defend_a = { 0.1, 0, 0 },
				-- FBI_defend_b = { 1, 1, 0 },
				FBI_defend_b = { 1, 0.5, 0 },
				CITY_defend_b = { 0, 0.5, 0 },
				-- FBI_defend_c = { 0, 1, 0 },
				FBI_defend_c = { 0, 0.5, 0 },
				CITY_defend_c = { 0, 0.5, 0 },
				-- FBI_defend_d = { 0, 0, 1 }
				FBI_defend_d = { 0, 0, 0 },
				CITY_defend_d = { 0, 0, 1 },
			}
			new_groups.recon = {
				-- FBI_stealth_a = { 0.5, 1, 1 },
				FBI_stealth_a = { 0.5, 0.5, 0 },
				CITY_stealth_a = { 0, 0.5, 1 },
				-- FBI_stealth_b = { 0.25, 0.5, 1 },
				FBI_stealth_b = { 0.25, 0.25, 0 },
				CITY_stealth_b = { 0, 0.25, 1 },
			}
		elseif difficulty_index == 7 then
			new_groups.assault = {
				CITY_swats = { 0.2, 0.8, 0.8 },
				CITY_heavys = { 0.1, 0.3, 0.4 },
				CITY_shields = { 0.1, 0.5, 0.4 },
				CITY_tanks = { 0.1, 0.5, 0.5 },
				CITY_tazers = { 0.1, 0.5, 0.45 },
				FBI_spoocs = { 0, 0.45, 0.45 },
			}
			new_groups.reenforce = {
				CS_defend_a = { 0.1, 0, 0 },
				CITY_defend_b = { 1, 1, 0 },
				CITY_defend_c = { 0, 1, 0 },
				CITY_defend_d = { 0, 0, 1 },
			}
			new_groups.recon = {
				CITY_stealth_a = { 0.5, 1, 1 },
				CITY_stealth_b = { 0.25, 0.5, 1 },
			}
		else
			new_groups.assault = {
				ZEAL_swats = { 0.2, 0.8, 0.8 },
				ZEAL_heavys = { 0.1, 0.3, 0.4 },
				ZEAL_shields = { 0.1, 0.5, 0.4 },
				ZEAL_tanks = { 0.1, 0.5, 0.5 },
				ZEAL_tazers = { 0.1, 0.5, 0.45 },
				ZEAL_spoocs = { 0, 0.45, 0.45 },
			}
			new_groups.reenforce = {
				CS_defend_a = { 0.1, 0, 0 },
				ZEAL_defend_b = { 1, 1, 0 },
				ZEAL_defend_c = { 0, 1, 0 },
				ZEAL_defend_d = { 0, 0, 1 },
			}
			new_groups.recon = {
				ZEAL_stealth_a = { 0.5, 1, 1 },
				ZEAL_stealth_b = { 0.25, 0.5, 1 },
			}
		end

		return new_groups
	end

	Hooks:Add( "LocalizationManagerPostInit", "LocalizationManagerPostInitGroupBasedMixedSpawns", function(loc)
		loc:load_localization_file(GBMS.mod_path .. "loc/english.json")
	end )

	Hooks:Add( "MenuManagerBuildCustomMenus", "MenuManagerBuildCustomMenusGroupBasedMixedSpawns", function(_, nodes)

		local menu_id = "gbms_menu"
		MenuHelper:NewMenu(menu_id)

		MenuCallbackHandler.gbms_setting_toggle = function(self, item)
			GBMS.settings[item:name()] = (item:value() == "on")
		end

		MenuCallbackHandler.gbms_setting_value = function(self, item)
			GBMS.settings[item:name()] = item:value()
		end

		MenuCallbackHandler.gbms_save = function()
			io.save_as_json(GBMS.settings, GBMS.save_path)
		end

		local priority = 0
		local divider_id = 1

		local function add_toggle(value)
			MenuHelper:AddToggle({
				id = value,
				title = "gbms_menu_" .. value,
				desc = "gbms_menu_" .. value .. "_desc",
				callback = "gbms_setting_toggle",
				value = GBMS.settings[value],
				menu_id = menu_id,
				priority = priority
			})

			priority = priority - 1
		end

		local function add_divider()
			MenuHelper:AddDivider({
				id = "gbms_divider_" .. divider_id,
				size = 16,
				menu_id = menu_id,
				priority = priority,
			})

			priority = priority - 1
			divider_id = divider_id + 1
		end

		local function add_multiple_choice(value)
			MenuHelper:AddMultipleChoice({
				id = value,
				title = "gbms_menu_" .. value,
				desc = "gbms_menu_" .. value .. "_desc",
				callback = "gbms_setting_value",
				value = GBMS.settings[value],
				items = GBMS.values[value],
				menu_id = menu_id,
				priority = priority
			})

			priority = priority - 1
		end

		local function add_button(id)
			MenuHelper:AddButton({
				id = id,
				title = "gbms_menu_" .. id,
				desc = "gbms_menu_" .. id .. "_desc",
				callback = "gbms_" .. id,
				menu_id = menu_id,
				priority = priority
			})

			priority = priority - 1
		end

		add_toggle("is_enabled")
		add_divider()
		add_multiple_choice("spawn_group_set")

		nodes[menu_id] = MenuHelper:BuildMenu(menu_id, { back_callback = "gbms_save" })

		MenuHelper:AddMenuItem(nodes["blt_options"], menu_id, "gbms_menu_main")

	end )

	-- Load settings
	if io.file_is_readable(GBMS.save_path) then
		local data = io.load_as_json(GBMS.save_path)
		if data then
			local function merge(tbl1, tbl2)
				for k, v in pairs(tbl2) do
					if type(tbl1[k]) == type(v) then
						if type(v) == "table" then
							merge(tbl1[k], v)
						else
							tbl1[k] = v
						end
					end
				end
			end
			merge(GBMS.settings, data)
		end
	end

end


Hooks:PostHook( GroupAITweakData, "_init_unit_categories", "gbms__init_unit_categories", function(self, difficulty_index)

	local faction_reference = {}
	for faction in pairs(self.unit_categories.spooc.unit_types) do
		faction_reference[faction] = true
	end
	local supported_factions = {
		america = true,
		russia = true,
		zombie = true,
		murkywater = true,
		federales = true
	}

	local limits_shield = { 0, 2, 4, 4, 4, 4, 4, 4 }
	local limits_medic = { 0, 0, 0, 0, 3, 3, 3, 3 }
	local limits_taser = { 0, 0, 2, 2, 2, 3, 3, 3 }
	local limits_tank = { 0, 0, 0, 2, 2, 2, 2, 3 }
	local limits_spooc = { 0, 0, 0, 2, 2, 2, 2, 2 }
	self.special_unit_spawn_limits.shield = limits_shield[difficulty_index]
	self.special_unit_spawn_limits.medic = limits_medic[difficulty_index]
	self.special_unit_spawn_limits.taser = limits_taser[difficulty_index]
	self.special_unit_spawn_limits.tank = limits_tank[difficulty_index]
	self.special_unit_spawn_limits.spooc = limits_spooc[difficulty_index]

	local is_death_sentence = difficulty_index > 7
	local is_death_wish = difficulty_index > 6
	local is_mayhem = difficulty_index > 5
	local is_overkill = difficulty_index > 4
	local is_very_hard = difficulty_index > 3
	local is_hard = difficulty_index > 2

	local new_unit_categories = {
		CITY_swat_G36 = "FBI_swat_M4",
		CITY_swat_BEN = "FBI_swat_R870",
		CITY_swat_UMP = "FBI_swat_M4",
		CITY_swat_BEN_UMP = "FBI_swat_R870",
		CITY_heavy_G36 = "FBI_heavy_G36",
		CITY_heavy_BEN = "FBI_heavy_R870",
		CITY_heavy_G36_w = "FBI_heavy_G36_w",
		CITY_shield = "FBI_shield",
		ZEAL_swat = "FBI_swat_M4",
		ZEAL_heavy = "FBI_heavy_G36",
		ZEAL_heavy_w = "FBI_heavy_G36_w",
		ZEAL_shield = "FBI_shield",
		ZEAL_tazer = "CS_tazer",
		ZEAL_tank = "FBI_tank",
		ZEAL_spooc = "spooc",
	}
	for new_category, based_on in pairs(new_unit_categories) do
		local based_on_category = self.unit_categories[based_on]

		if based_on_category then
			self.unit_categories[new_category] = deep_clone(based_on_category)
		end
	end

	self.unit_categories.CS_swat_MP5.unit_types = {
		america = { Idstring("units/payday2/characters/ene_swat_1/ene_swat_1") },
		russia = { Idstring("units/pd2_dlc_mad/characters/ene_akan_cs_swat_ak47_ass/ene_akan_cs_swat_ak47_ass") },
		zombie = { Idstring("units/pd2_dlc_hvh/characters/ene_swat_hvh_1/ene_swat_hvh_1") },
		murkywater = { Idstring("units/pd2_dlc_bph/characters/ene_murkywater_light/ene_murkywater_light") },
		federales = { Idstring("units/pd2_dlc_bex/characters/ene_swat_policia_federale/ene_swat_policia_federale") }
	}
	self.unit_categories.CS_swat_R870.unit_types = {
		america = { Idstring("units/payday2/characters/ene_swat_2/ene_swat_2") },
		russia = { Idstring("units/pd2_dlc_mad/characters/ene_akan_cs_swat_r870/ene_akan_cs_swat_r870") },
		zombie = { Idstring("units/pd2_dlc_hvh/characters/ene_swat_hvh_2/ene_swat_hvh_2") },
		murkywater = { Idstring("units/pd2_dlc_bph/characters/ene_murkywater_light_r870/ene_murkywater_light_r870") },
		federales = { Idstring("units/pd2_dlc_bex/characters/ene_swat_policia_federale_r870/ene_swat_policia_federale_r870") }
	}
	self.unit_categories.CS_heavy_M4.unit_types = {
		america = { Idstring("units/payday2/characters/ene_swat_heavy_1/ene_swat_heavy_1") },
		russia = { Idstring("units/pd2_dlc_mad/characters/ene_akan_cs_heavy_ak47_ass/ene_akan_cs_heavy_ak47_ass") },
		zombie = { Idstring("units/pd2_dlc_hvh/characters/ene_swat_heavy_hvh_1/ene_swat_heavy_hvh_1") },
		murkywater = { Idstring("units/pd2_dlc_bph/characters/ene_murkywater_heavy/ene_murkywater_heavy") },
		federales = { Idstring("units/pd2_dlc_bex/characters/ene_swat_heavy_policia_federale/ene_swat_heavy_policia_federale") }
	}
	self.unit_categories.CS_heavy_M4_w.unit_types = deep_clone(self.unit_categories.CS_heavy_M4.unit_types)
	self.unit_categories.CS_heavy_R870.unit_types = {
		america = { Idstring("units/payday2/characters/ene_swat_heavy_r870/ene_swat_heavy_r870") },
		russia = { Idstring("units/pd2_dlc_mad/characters/ene_akan_cs_heavy_r870/ene_akan_cs_heavy_r870") },
		zombie = { Idstring("units/pd2_dlc_hvh/characters/ene_swat_heavy_hvh_r870/ene_swat_heavy_hvh_r870") },
		murkywater = { Idstring("units/pd2_dlc_bph/characters/ene_murkywater_heavy_shotgun/ene_murkywater_heavy_shotgun") },
		federales = { Idstring("units/pd2_dlc_bex/characters/ene_swat_heavy_policia_federale_r870/ene_swat_heavy_policia_federale_r870") }
	}
	self.unit_categories.CS_shield.unit_types = {
		america = { Idstring("units/payday2/characters/ene_shield_2/ene_shield_2") },
		russia = { Idstring("units/pd2_dlc_mad/characters/ene_akan_cs_shield_c45/ene_akan_cs_shield_c45") },
		zombie = { Idstring("units/pd2_dlc_hvh/characters/ene_shield_hvh_2/ene_shield_hvh_2") },
		murkywater = { Idstring("units/pd2_dlc_bph/characters/ene_murkywater_shield/ene_murkywater_shield") },
		federales = { Idstring("units/pd2_dlc_bex/characters/ene_swat_shield_policia_federale_c45/ene_swat_shield_policia_federale_c45") }
	}
	self.unit_categories.FBI_swat_M4.unit_types = {
		america = { Idstring("units/payday2/characters/ene_fbi_swat_1/ene_fbi_swat_1") },
		russia = { Idstring("units/pd2_dlc_mad/characters/ene_akan_fbi_swat_ak47_ass/ene_akan_fbi_swat_ak47_ass") },
		zombie = { Idstring("units/pd2_dlc_hvh/characters/ene_fbi_swat_hvh_1/ene_fbi_swat_hvh_1") },
		murkywater = { Idstring("units/pd2_dlc_bph/characters/ene_murkywater_light_fbi/ene_murkywater_light_fbi") },
		federales = { Idstring("units/pd2_dlc_bex/characters/ene_swat_policia_federale_fbi/ene_swat_policia_federale_fbi") }
	}
	self.unit_categories.FBI_swat_R870.unit_types = {
		america = { Idstring("units/payday2/characters/ene_fbi_swat_2/ene_fbi_swat_2") },
		russia = { Idstring("units/pd2_dlc_mad/characters/ene_akan_fbi_swat_r870/ene_akan_fbi_swat_r870") },
		zombie = { Idstring("units/pd2_dlc_hvh/characters/ene_fbi_swat_hvh_2/ene_fbi_swat_hvh_2") },
		murkywater = { Idstring("units/pd2_dlc_bph/characters/ene_murkywater_light_fbi_r870/ene_murkywater_light_fbi_r870") },
		federales = { Idstring("units/pd2_dlc_bex/characters/ene_swat_policia_federale_fbi_r870/ene_swat_policia_federale_fbi_r870") }
	}
	self.unit_categories.FBI_heavy_G36.unit_types = {
		america = { Idstring("units/payday2/characters/ene_fbi_heavy_1/ene_fbi_heavy_1") },
		russia = { Idstring("units/pd2_dlc_mad/characters/ene_akan_fbi_heavy_g36/ene_akan_fbi_heavy_g36") },
		zombie = { Idstring("units/pd2_dlc_hvh/characters/ene_fbi_heavy_hvh_1/ene_fbi_heavy_hvh_1") },
		murkywater = { Idstring("units/pd2_dlc_bph/characters/ene_murkywater_heavy_g36/ene_murkywater_heavy_g36") },
		federales = { Idstring("units/pd2_dlc_bex/characters/ene_swat_heavy_policia_federale_fbi/ene_swat_heavy_policia_federale_fbi") }
	}
	self.unit_categories.FBI_heavy_G36_w.unit_types = deep_clone(self.unit_categories.FBI_heavy_G36.unit_types)
	self.unit_categories.FBI_heavy_R870.unit_types = {
		america = { Idstring("units/payday2/characters/ene_fbi_heavy_r870/ene_fbi_heavy_r870") },
		russia = { Idstring("units/pd2_dlc_mad/characters/ene_akan_fbi_heavy_r870/ene_akan_fbi_heavy_r870") },
		zombie = { Idstring("units/pd2_dlc_hvh/characters/ene_fbi_heavy_hvh_r870/ene_fbi_heavy_hvh_r870") },
		murkywater = { Idstring("units/pd2_dlc_bph/characters/ene_murkywater_heavy_shotgun/ene_murkywater_heavy_shotgun") },
		federales = { Idstring("units/pd2_dlc_bex/characters/ene_swat_heavy_policia_federale_fbi_r870/ene_swat_heavy_policia_federale_fbi_r870") }
	}
	self.unit_categories.FBI_shield.unit_types = {
		america = { Idstring("units/payday2/characters/ene_shield_1/ene_shield_1") },
		russia = { Idstring("units/pd2_dlc_mad/characters/ene_akan_fbi_shield_sr2_smg/ene_akan_fbi_shield_sr2_smg") },
		zombie = { Idstring("units/pd2_dlc_hvh/characters/ene_shield_hvh_1/ene_shield_hvh_1") },
		murkywater = { Idstring("units/pd2_dlc_bph/characters/ene_murkywater_shield/ene_murkywater_shield") },
		federales = { Idstring("units/pd2_dlc_bex/characters/ene_swat_shield_policia_federale_mp9/ene_swat_shield_policia_federale_mp9") }
	}
	self.unit_categories.CITY_swat_G36.unit_types = {
		america = { Idstring("units/payday2/characters/ene_city_swat_1/ene_city_swat_1") },
		russia = { Idstring("units/pd2_dlc_mad/characters/ene_akan_fbi_swat_dw_ak47_ass/ene_akan_fbi_swat_dw_ak47_ass") },
		zombie = { Idstring("units/pd2_dlc_hvh/characters/ene_fbi_swat_hvh_1/ene_fbi_swat_hvh_1") },
		murkywater = { Idstring("units/pd2_dlc_bph/characters/ene_murkywater_light_city/ene_murkywater_light_city") },
		federales = { Idstring("units/pd2_dlc_bex/characters/ene_swat_policia_federale_city/ene_swat_policia_federale_city") }
	}
	self.unit_categories.CITY_swat_BEN.unit_types = {
		america = { Idstring("units/payday2/characters/ene_city_swat_2/ene_city_swat_2") },
		russia = { Idstring("units/pd2_dlc_mad/characters/ene_akan_fbi_swat_dw_r870/ene_akan_fbi_swat_dw_r870") },
		zombie = { Idstring("units/pd2_dlc_hvh/characters/ene_fbi_swat_hvh_2/ene_fbi_swat_hvh_2") },
		murkywater = { Idstring("units/pd2_dlc_bph/characters/ene_murkywater_light_city_r870/ene_murkywater_light_city_r870") },
		federales = { Idstring("units/pd2_dlc_bex/characters/ene_swat_policia_federale_city_r870/ene_swat_policia_federale_city_r870") }
	}
	self.unit_categories.CITY_swat_UMP.unit_types = {
		america = { Idstring("units/payday2/characters/ene_city_swat_3/ene_city_swat_3") },
		russia = { Idstring("units/pd2_dlc_mad/characters/ene_akan_fbi_swat_dw_r870/ene_akan_fbi_swat_dw_r870") },
		zombie = { Idstring("units/pd2_dlc_hvh/characters/ene_fbi_swat_hvh_2/ene_fbi_swat_hvh_2") },
		murkywater = { Idstring("units/pd2_dlc_bph/characters/ene_murkywater_light_city_r870/ene_murkywater_light_city_r870") },
		federales = { Idstring("units/pd2_dlc_bex/characters/ene_swat_policia_federale_city_r870/ene_swat_policia_federale_city_r870") }
	}
	self.unit_categories.CITY_swat_BEN_UMP.unit_types = {
		america = {
			Idstring("units/payday2/characters/ene_city_swat_2/ene_city_swat_2"),
			Idstring("units/payday2/characters/ene_city_swat_3/ene_city_swat_3")
		},
		russia = { Idstring("units/pd2_dlc_mad/characters/ene_akan_fbi_swat_dw_r870/ene_akan_fbi_swat_dw_r870") },
		zombie = { Idstring("units/pd2_dlc_hvh/characters/ene_fbi_swat_hvh_2/ene_fbi_swat_hvh_2") },
		murkywater = { Idstring("units/pd2_dlc_bph/characters/ene_murkywater_light_city_r870/ene_murkywater_light_city_r870") },
		federales = { Idstring("units/pd2_dlc_bex/characters/ene_swat_policia_federale_city_r870/ene_swat_policia_federale_city_r870") }
	}
	self.unit_categories.CITY_heavy_G36.unit_types = {
		america = { Idstring("units/payday2/characters/ene_city_heavy_g36/ene_city_heavy_g36") },
		russia = { Idstring("units/pd2_dlc_mad/characters/ene_akan_fbi_heavy_g36/ene_akan_fbi_heavy_g36") },
		zombie = { Idstring("units/pd2_dlc_hvh/characters/ene_fbi_heavy_hvh_1/ene_fbi_heavy_hvh_1") },
		murkywater = { Idstring("units/pd2_dlc_bph/characters/ene_murkywater_heavy_g36/ene_murkywater_heavy_g36") },
		federales = { Idstring("units/pd2_dlc_bex/characters/ene_swat_heavy_policia_federale_fbi_g36/ene_swat_heavy_policia_federale_fbi_g36") }
	}
	self.unit_categories.CITY_heavy_BEN.unit_types = {
		america = { Idstring("units/payday2/characters/ene_city_heavy_r870/ene_city_heavy_r870") },
		russia = { Idstring("units/pd2_dlc_mad/characters/ene_akan_fbi_heavy_r870/ene_akan_fbi_heavy_r870") },
		zombie = { Idstring("units/pd2_dlc_hvh/characters/ene_fbi_heavy_hvh_r870/ene_fbi_heavy_hvh_r870") },
		murkywater = { Idstring("units/pd2_dlc_bph/characters/ene_murkywater_heavy_shotgun/ene_murkywater_heavy_shotgun") },
		federales = { Idstring("units/pd2_dlc_bex/characters/ene_swat_heavy_policia_federale_fbi_r870/ene_swat_heavy_policia_federale_fbi_r870") }
	}
	self.unit_categories.CITY_heavy_G36_w.unit_types = deep_clone(self.unit_categories.CITY_heavy_G36.unit_types)
	self.unit_categories.CITY_shield.unit_types = {
		america = { Idstring("units/payday2/characters/ene_city_shield/ene_city_shield") },
		russia = { Idstring("units/pd2_dlc_mad/characters/ene_akan_fbi_shield_dw_sr2_smg/ene_akan_fbi_shield_dw_sr2_smg") },
		zombie = { Idstring("units/pd2_dlc_hvh/characters/ene_shield_hvh_1/ene_shield_hvh_1") },
		murkywater = { Idstring("units/pd2_dlc_bph/characters/ene_murkywater_shield/ene_murkywater_shield") },
		federales = { Idstring("units/pd2_dlc_bex/characters/ene_swat_shield_policia_federale_mp9/ene_swat_shield_policia_federale_mp9") }
	}
	self.unit_categories.ZEAL_swat.unit_types = {
		america = is_death_sentence and { Idstring("units/pd2_dlc_gitgud/characters/ene_zeal_swat/ene_zeal_swat") }
			or clone(self.unit_categories.CS_swat_MP5.unit_types.america),
		russia = { Idstring("units/pd2_dlc_mad/characters/ene_akan_cs_swat_ak47_ass/ene_akan_cs_swat_ak47_ass") },
		zombie = { Idstring("units/pd2_dlc_hvh/characters/ene_swat_hvh_1/ene_swat_hvh_1") },
		murkywater = { Idstring("units/pd2_dlc_bph/characters/ene_murkywater_light_fbi/ene_murkywater_light_fbi") },
		federales = { Idstring("units/pd2_dlc_bex/characters/ene_swat_policia_federale/ene_swat_policia_federale") }
	}
	self.unit_categories.ZEAL_heavy.unit_types = {
		america = is_death_sentence and { Idstring("units/pd2_dlc_gitgud/characters/ene_zeal_swat_heavy/ene_zeal_swat_heavy") }
			or clone(self.unit_categories.CS_heavy_M4.unit_types.america),
		russia = { Idstring("units/pd2_dlc_mad/characters/ene_akan_cs_heavy_ak47_ass/ene_akan_cs_heavy_ak47_ass") },
		zombie = { Idstring("units/pd2_dlc_hvh/characters/ene_swat_heavy_hvh_1/ene_swat_heavy_hvh_1") },
		murkywater = { Idstring("units/pd2_dlc_bph/characters/ene_murkywater_heavy/ene_murkywater_heavy") },
		federales = { Idstring("units/pd2_dlc_bex/characters/ene_swat_heavy_policia_federale/ene_swat_heavy_policia_federale") }
	}
	self.unit_categories.ZEAL_heavy_w.unit_types = deep_clone(self.unit_categories.ZEAL_heavy.unit_types)
	self.unit_categories.ZEAL_shield.unit_types = {
		america = is_death_sentence and { Idstring("units/pd2_dlc_gitgud/characters/ene_zeal_swat_shield/ene_zeal_swat_shield") }
			or clone(self.unit_categories.CS_shield.unit_types.america),
		russia = { Idstring("units/pd2_dlc_mad/characters/ene_akan_fbi_shield_dw_sr2_smg/ene_akan_fbi_shield_dw_sr2_smg") },
		zombie = { Idstring("units/pd2_dlc_hvh/characters/ene_shield_hvh_1/ene_shield_hvh_1") },
		murkywater = { Idstring("units/pd2_dlc_bph/characters/ene_murkywater_shield/ene_murkywater_shield") },
		federales = { Idstring("units/pd2_dlc_bex/characters/ene_swat_shield_policia_federale_mp9/ene_swat_shield_policia_federale_mp9") }
	}
	self.unit_categories.ZEAL_tazer.unit_types.america = is_death_sentence and { Idstring("units/pd2_dlc_gitgud/characters/ene_zeal_tazer/ene_zeal_tazer") }
		or clone(self.unit_categories.CS_tazer.unit_types.america)
	self.unit_categories.spooc.unit_types.america = { Idstring("units/payday2/characters/ene_spook_1/ene_spook_1") }
	self.unit_categories.ZEAL_spooc.unit_types.america = is_death_sentence and { Idstring("units/pd2_dlc_gitgud/characters/ene_zeal_cloaker/ene_zeal_cloaker") }
		or clone(self.unit_categories.spooc.unit_types.america)

	self.unit_categories.FBI_suit_C45_M4.unit_types.murkywater = self.unit_categories.FBI_suit_C45_M4.unit_types.america
	self.unit_categories.FBI_suit_C45_M4.unit_types.federales = self.unit_categories.FBI_suit_C45_M4.unit_types.america
	self.unit_categories.FBI_suit_M4_MP5.unit_types.murkywater = self.unit_categories.FBI_suit_M4_MP5.unit_types.america
	self.unit_categories.FBI_suit_M4_MP5.unit_types.federales = self.unit_categories.FBI_suit_M4_MP5.unit_types.america

	local FBI_tank = self.unit_categories.FBI_tank.unit_types
	FBI_tank.america = { Idstring("units/payday2/characters/ene_bulldozer_1/ene_bulldozer_1") }
	FBI_tank.russia = { Idstring("units/pd2_dlc_mad/characters/ene_akan_fbi_tank_r870/ene_akan_fbi_tank_r870") }
	FBI_tank.zombie = { Idstring("units/pd2_dlc_hvh/characters/ene_bulldozer_hvh_1/ene_bulldozer_hvh_1") }
	FBI_tank.murkywater = { Idstring("units/pd2_dlc_bph/characters/ene_murkywater_bulldozer_2/ene_murkywater_bulldozer_2") }
	FBI_tank.federales = { Idstring("units/pd2_dlc_bex/characters/ene_swat_dozer_policia_federale_saiga/ene_swat_dozer_policia_federale_saiga") }

	if is_overkill then
		table.insert(FBI_tank.america, Idstring("units/payday2/characters/ene_bulldozer_2/ene_bulldozer_2"))
		table.insert(FBI_tank.russia, Idstring("units/pd2_dlc_mad/characters/ene_akan_fbi_tank_saiga/ene_akan_fbi_tank_saiga"))
		table.insert(FBI_tank.zombie, Idstring("units/pd2_dlc_hvh/characters/ene_bulldozer_hvh_2/ene_bulldozer_hvh_2"))
		table.insert(FBI_tank.murkywater, Idstring("units/pd2_dlc_bph/characters/ene_murkywater_bulldozer_3/ene_murkywater_bulldozer_3"))
		table.insert(FBI_tank.federales, Idstring("units/pd2_dlc_bex/characters/ene_swat_dozer_policia_federale_saiga/ene_swat_dozer_policia_federale_saiga"))
	end

	if is_mayhem then
		table.insert(FBI_tank.america, Idstring("units/payday2/characters/ene_bulldozer_3/ene_bulldozer_3"))
		table.insert(FBI_tank.russia, Idstring("units/pd2_dlc_mad/characters/ene_akan_fbi_tank_rpk_lmg/ene_akan_fbi_tank_rpk_lmg"))
		table.insert(FBI_tank.zombie, Idstring("units/pd2_dlc_hvh/characters/ene_bulldozer_hvh_3/ene_bulldozer_hvh_3"))
		table.insert(FBI_tank.murkywater, Idstring("units/pd2_dlc_bph/characters/ene_murkywater_bulldozer_4/ene_murkywater_bulldozer_4"))
		table.insert(FBI_tank.federales, Idstring("units/pd2_dlc_bex/characters/ene_swat_dozer_policia_federale_m249/ene_swat_dozer_policia_federale_m249"))
	end

	if is_death_wish then
		table.insert(FBI_tank.america, Idstring("units/pd2_dlc_drm/characters/ene_bulldozer_minigun_classic/ene_bulldozer_minigun_classic"))
		table.insert(FBI_tank.russia, Idstring("units/pd2_dlc_drm/characters/ene_bulldozer_minigun_classic/ene_bulldozer_minigun_classic"))
		table.insert(FBI_tank.zombie, Idstring("units/pd2_dlc_drm/characters/ene_bulldozer_minigun_classic/ene_bulldozer_minigun_classic"))
		table.insert(FBI_tank.murkywater, Idstring("units/pd2_dlc_bph/characters/ene_murkywater_bulldozer_1/ene_murkywater_bulldozer_1"))
		table.insert(FBI_tank.federales, Idstring("units/pd2_dlc_bex/characters/ene_swat_dozer_policia_federale_minigun/ene_swat_dozer_policia_federale_minigun"))
	end

	if is_death_sentence then
		table.insert(FBI_tank.america, Idstring("units/pd2_dlc_drm/characters/ene_bulldozer_medic/ene_bulldozer_medic"))
		table.insert(FBI_tank.russia, Idstring("units/pd2_dlc_drm/characters/ene_bulldozer_medic/ene_bulldozer_medic"))
		table.insert(FBI_tank.zombie, Idstring("units/pd2_dlc_drm/characters/ene_bulldozer_medic/ene_bulldozer_medic"))
		table.insert(FBI_tank.murkywater, Idstring("units/pd2_dlc_bph/characters/ene_murkywater_bulldozer_medic/ene_murkywater_bulldozer_medic"))
		table.insert(FBI_tank.federales, Idstring("units/pd2_dlc_bex/characters/ene_swat_dozer_medic_policia_federale/ene_swat_dozer_medic_policia_federale"))
	end

	self.unit_categories.ZEAL_tank.unit_types = {
		america = is_death_sentence and {
			Idstring("units/pd2_dlc_gitgud/characters/ene_zeal_bulldozer/ene_zeal_bulldozer"),
			Idstring("units/pd2_dlc_gitgud/characters/ene_zeal_bulldozer_2/ene_zeal_bulldozer_2"),
			Idstring("units/pd2_dlc_gitgud/characters/ene_zeal_bulldozer_3/ene_zeal_bulldozer_3"),
			Idstring("units/pd2_dlc_drm/characters/ene_bulldozer_medic/ene_bulldozer_medic"),
			Idstring("units/pd2_dlc_drm/characters/ene_bulldozer_minigun/ene_bulldozer_minigun")
		} or {
			Idstring("units/payday2/characters/ene_bulldozer_1/ene_bulldozer_1"),
			Idstring("units/payday2/characters/ene_bulldozer_2/ene_bulldozer_2"),
			Idstring("units/payday2/characters/ene_bulldozer_3/ene_bulldozer_3"),
			Idstring("units/pd2_dlc_drm/characters/ene_bulldozer_medic/ene_bulldozer_medic"),
			Idstring("units/pd2_dlc_drm/characters/ene_bulldozer_minigun/ene_bulldozer_minigun")
		},
		russia = {
			Idstring("units/pd2_dlc_mad/characters/ene_akan_fbi_tank_r870/ene_akan_fbi_tank_r870"),
			Idstring("units/pd2_dlc_mad/characters/ene_akan_fbi_tank_saiga/ene_akan_fbi_tank_saiga"),
			Idstring("units/pd2_dlc_mad/characters/ene_akan_fbi_tank_rpk_lmg/ene_akan_fbi_tank_rpk_lmg"),
			Idstring("units/pd2_dlc_drm/characters/ene_bulldozer_medic/ene_bulldozer_medic"),
			Idstring("units/pd2_dlc_drm/characters/ene_bulldozer_minigun/ene_bulldozer_minigun")
		},
		zombie = {
			Idstring("units/pd2_dlc_hvh/characters/ene_bulldozer_hvh_1/ene_bulldozer_hvh_1"),
			Idstring("units/pd2_dlc_hvh/characters/ene_bulldozer_hvh_2/ene_bulldozer_hvh_2"),
			Idstring("units/pd2_dlc_hvh/characters/ene_bulldozer_hvh_3/ene_bulldozer_hvh_3"),
			Idstring("units/pd2_dlc_drm/characters/ene_bulldozer_medic/ene_bulldozer_medic"),
			Idstring("units/pd2_dlc_drm/characters/ene_bulldozer_minigun/ene_bulldozer_minigun")
		},
		murkywater = {
			Idstring("units/pd2_dlc_bph/characters/ene_murkywater_bulldozer_1/ene_murkywater_bulldozer_1"),
			Idstring("units/pd2_dlc_bph/characters/ene_murkywater_bulldozer_2/ene_murkywater_bulldozer_2"),
			Idstring("units/pd2_dlc_bph/characters/ene_murkywater_bulldozer_3/ene_murkywater_bulldozer_3"),
			Idstring("units/pd2_dlc_bph/characters/ene_murkywater_bulldozer_4/ene_murkywater_bulldozer_4"),
			Idstring("units/pd2_dlc_bph/characters/ene_murkywater_bulldozer_medic/ene_murkywater_bulldozer_medic")
		},
		federales = {
			Idstring("units/pd2_dlc_bex/characters/ene_swat_dozer_policia_federale_r870/ene_swat_dozer_policia_federale_r870"),
			Idstring("units/pd2_dlc_bex/characters/ene_swat_dozer_policia_federale_saiga/ene_swat_dozer_policia_federale_saiga"),
			Idstring("units/pd2_dlc_bex/characters/ene_swat_dozer_policia_federale_m249/ene_swat_dozer_policia_federale_m249"),
			Idstring("units/pd2_dlc_bex/characters/ene_swat_dozer_policia_federale_minigun/ene_swat_dozer_policia_federale_minigun"),
			Idstring("units/pd2_dlc_bex/characters/ene_swat_dozer_medic_policia_federale/ene_swat_dozer_medic_policia_federale")
		}
	}

	for faction, _ in pairs(faction_reference) do
		if not supported_factions[faction] then
			for _, category in pairs(self.unit_categories) do
				if category.unit_types and category.unit_types.america then
					category.unit_types[faction] = clone(category.unit_types.america)
				end
			end
		end
	end
end )


Hooks:PostHook( GroupAITweakData, "_init_enemy_spawn_groups", "gbms__init_enemy_spawn_groups", function(self, difficulty_index)

	--[[
		valid tactics are:
		"flank",
			might as well do nothing with vanilla ai, but with fixed ai, group leaders with this tactic will have their group find an alternate route
		"ranged_fire",
			might as well do nothing with vanilla ai, but with fixed ai, group leaders with this tactic will have their group open fire from a nearby position before moving in
		"charge",
			throws grenades on player location rather than in doorways, ai mods may make this do more
		"smoke_grenade",
			groups who have members with this tactic can use smoke bombs
		"flash_grenade",
			groups who have members with this tactic can use flashbangs
		"deathguard",
			all groups on the map with a member possessing this tactic will move to and camp downed/tased players
		"murder",
			does nothing with vanilla ai, but with fixed ai, causes enemies with this tactic to shoot players in bleedout regardless of player shooting first
		"shield",
			does nothing with vanilla ai, but with fixed ai, causes enemies to shield group members with "shield_cover"
		"shield_cover",
			does nothing with vanilla ai, but with fixed ai, causes enemies to cover themselves using group members with "shield"
		"provide_coverfire",
			does nothing and was meant to be removed, ai mods may make it do something
		"provide_support",
			does nothing and was meant to be removed, ai mods may make it do something
	]]

	-- fix a typo
	self._tactics.tazer_flanking = { "flank", "provide_coverfire", "smoke_grenade", "murder" }

	-- add old tactics
	self._tactics.CS_cop = { "provide_coverfire", "provide_support", "ranged_fire" }
	self._tactics.CS_cop_stealth = { "flank", "provide_coverfire", "provide_support" }
	self._tactics.CS_swat_rifle = { "smoke_grenade", "charge", "provide_coverfire", "provide_support", "ranged_fire" }
	self._tactics.CS_swat_shotgun = { "smoke_grenade", "charge", "provide_coverfire", "provide_support", "shield_cover" }
	self._tactics.CS_swat_heavy = { "smoke_grenade", "charge", "flash_grenade", "provide_coverfire", "provide_support" }
	self._tactics.CS_shield = { "charge", "provide_coverfire", "provide_support", "shield", "deathguard" }
	self._tactics.CS_swat_rifle_flank = { "flank", "flash_grenade", "smoke_grenade", "charge", "provide_coverfire", "provide_support" }
	self._tactics.CS_swat_shotgun_flank = { "flank", "flash_grenade", "smoke_grenade", "charge", "provide_coverfire", "provide_support" }
	self._tactics.CS_swat_heavy_flank = { "flank", "flash_grenade", "smoke_grenade", "charge", "provide_coverfire", "provide_support", "shield_cover" }
	self._tactics.CS_shield_flank = { "flank", "charge", "flash_grenade", "provide_coverfire", "provide_support", "shield" }
	self._tactics.CS_tazer = { "flank", "charge", "flash_grenade", "shield_cover", "murder" }
	self._tactics.CS_sniper = { "ranged_fire", "provide_coverfire", "provide_support" }
	self._tactics.FBI_suit = { "flank", "ranged_fire", "flash_grenade" }
	self._tactics.FBI_suit_stealth = { "provide_coverfire", "provide_support", "flash_grenade", "flank" }
	self._tactics.FBI_swat_rifle = { "smoke_grenade", "flash_grenade", "provide_coverfire", "charge", "provide_support", "ranged_fire" }
	self._tactics.FBI_swat_shotgun = { "smoke_grenade", "flash_grenade", "charge", "provide_coverfire", "provide_support" }
	self._tactics.FBI_heavy = { "smoke_grenade", "flash_grenade", "charge", "provide_coverfire", "provide_support", "shield_cover", "deathguard" }
	self._tactics.FBI_shield = { "smoke_grenade", "charge", "provide_coverfire", "provide_support", "shield", "deathguard" }
	self._tactics.FBI_swat_rifle_flank = { "flank", "smoke_grenade", "flash_grenade", "charge", "provide_coverfire", "provide_support" }
	self._tactics.FBI_swat_shotgun_flank = { "flank", "smoke_grenade", "flash_grenade", "charge", "provide_coverfire", "provide_support" }
	self._tactics.FBI_heavy_flank = { "flank", "smoke_grenade", "flash_grenade", "charge", "provide_coverfire", "provide_support", "shield_cover" }
	self._tactics.FBI_shield_flank = { "flank", "smoke_grenade", "flash_grenade", "charge", "provide_coverfire", "provide_support", "shield" }
	self._tactics.FBI_tank = { "charge", "deathguard", "shield_cover", "smoke_grenade" }
	self._tactics.spooc = { "charge", "shield_cover", "smoke_grenade", "flash_grenade" }

	local swat_spawn = table.set("tac_swat_rifle_flank")
	local shield_spawn = table.set("tac_shield_wall_ranged", "tac_shield_wall", "tac_shield_wall_charge")
	local taser_spawn = table.set("tac_tazer_flanking", "tac_tazer_charge")
	local bulldozer_spawn = table.set("tac_bull_rush")
	local cloaker_spawn = table.set("FBI_spoocs")

	self.enemy_spawn_groups.mpdc_swat_shotgun_rush = {
		amount = { 3, 3 },
		spawn = {
			{ rank = 2, unit = "CS_swat_R870", tactics = self._tactics.swat_shotgun_rush, amount_min = 2, amount_max = 2, freq = 1 },
			{ rank = 3, unit = "CS_heavy_R870", tactics = self._tactics.swat_shotgun_rush, amount_min = 1, amount_max = 1, freq = 1 }
		},
		spawn_point_chk_ref = swat_spawn
	}
	self.enemy_spawn_groups.fbi_swat_shotgun_rush = {
		amount = { 4, 5 },
		spawn = {
			{ rank = 2, unit = "FBI_swat_R870", tactics = self._tactics.swat_shotgun_rush, amount_min = 3, amount_max = 3, freq = 3 },
			{ rank = 3, unit = "FBI_heavy_R870", tactics = self._tactics.swat_shotgun_rush, amount_min = 1, amount_max = 1, freq = 1 },
			{ rank = 2, unit = "medic_R870", tactics = self._tactics.swat_shotgun_rush, amount_min = 0, amount_max = 1, freq = 0.2 }
		},
		spawn_point_chk_ref = swat_spawn
	}
	self.enemy_spawn_groups.city_swat_shotgun_rush = {
		amount = { 4, 5 },
		spawn = {
			{ rank = 2, unit = "CITY_swat_BEN", tactics = self._tactics.swat_shotgun_rush, amount_min = 2, amount_max = 2, freq = 2 },
			{ rank = 3, unit = "CITY_heavy_BEN", tactics = self._tactics.swat_shotgun_rush, amount_min = 2, amount_max = 2, freq = 2 },
			{ rank = 2, unit = "medic_R870", tactics = self._tactics.swat_shotgun_rush, amount_min = 0, amount_max = 1, freq = 0.35 }
		},
		spawn_point_chk_ref = swat_spawn
	}
	self.enemy_spawn_groups.zeal_swat_shotgun_rush = {
		amount = { 4, 5 },
		spawn = {
			{ rank = 2, unit = "ZEAL_swat", tactics = self._tactics.swat_shotgun_rush, amount_min = 1, amount_max = 1, freq = 1 },
			{ rank = 3, unit = "ZEAL_heavy", tactics = self._tactics.swat_shotgun_rush, amount_min = 3, amount_max = 3, freq = 3 },
			{ rank = 2, unit = "medic_R870", tactics = self._tactics.swat_shotgun_rush, amount_min = 0, amount_max = 1, freq = 0.35 }
		},
		spawn_point_chk_ref = swat_spawn
	}

	self.enemy_spawn_groups.mpdc_swat_shotgun_flank = {
		amount = { 4, 4 },
		spawn = {
			{ rank = 2, unit = "CS_swat_R870", tactics = self._tactics.swat_shotgun_flank, amount_min = 2, amount_max = 2, freq = 1 },
			{ rank = 3, unit = "CS_heavy_R870", tactics = self._tactics.swat_shotgun_flank, amount_min = 2, amount_max = 2, freq = 1 }
		},
		spawn_point_chk_ref = swat_spawn
	}
	self.enemy_spawn_groups.fbi_swat_shotgun_flank = {
		amount = { 4, 5 },
		spawn = {
			{ rank = 2, unit = "FBI_swat_R870", tactics = self._tactics.swat_shotgun_flank, amount_min = 3, amount_max = 3, freq = 3 },
			{ rank = 3, unit = "FBI_heavy_R870", tactics = self._tactics.swat_shotgun_flank, amount_min = 1, amount_max = 1, freq = 1 },
			{ rank = 2, unit = "medic_R870", tactics = self._tactics.swat_shotgun_flank, amount_min = 0, amount_max = 1, freq = 0.2 }
		},
		spawn_point_chk_ref = swat_spawn
	}
	self.enemy_spawn_groups.city_swat_shotgun_flank = {
		amount = { 4, 5 },
		spawn = {
			{ rank = 2, unit = "CITY_swat_BEN", tactics = self._tactics.swat_shotgun_flank, amount_min = 2, amount_max = 2, freq = 2 },
			{ rank = 3, unit = "CITY_heavy_BEN", tactics = self._tactics.swat_shotgun_flank, amount_min = 2, amount_max = 2, freq = 2 },
			{ rank = 2, unit = "medic_R870", tactics = self._tactics.swat_shotgun_flank, amount_min = 0, amount_max = 1, freq = 0.35 }
		},
		spawn_point_chk_ref = swat_spawn
	}
	self.enemy_spawn_groups.zeal_swat_shotgun_flank = {
		amount = { 4, 5 },
		spawn = {
			{ rank = 2, unit = "ZEAL_swat", tactics = self._tactics.swat_shotgun_flank, amount_min = 1, amount_max = 1, freq = 1 },
			{ rank = 3, unit = "ZEAL_heavy", tactics = self._tactics.swat_shotgun_flank, amount_min = 3, amount_max = 3, freq = 3 },
			{ rank = 2, unit = "medic_R870", tactics = self._tactics.swat_shotgun_flank, amount_min = 0, amount_max = 1, freq = 0.35 }
		},
		spawn_point_chk_ref = swat_spawn
	}

	self.enemy_spawn_groups.mpdc_swat_rifle = {
		amount = { 4, 4 },
		spawn = {
			{ rank = 2, unit = "CS_swat_MP5", tactics = self._tactics.swat_rifle, amount_min = 2, amount_max = 2, freq = 1 },
			{ rank = 3, unit = "CS_heavy_M4", tactics = self._tactics.swat_rifle, amount_min = 2, amount_max = 2, freq = 1 }
		},
		spawn_point_chk_ref = swat_spawn
	}
	self.enemy_spawn_groups.fbi_swat_rifle = {
		amount = { 4, 5 },
		spawn = {
			{ rank = 2, unit = "FBI_swat_M4", tactics = self._tactics.swat_rifle, amount_min = 3, amount_max = 3, freq = 3 },
			{ rank = 3, unit = "FBI_heavy_G36", tactics = self._tactics.swat_rifle, amount_min = 1, amount_max = 1, freq = 1 },
			{ rank = 2, unit = "medic_M4", tactics = self._tactics.swat_rifle, amount_min = 0, amount_max = 1, freq = 0.2 }
		},
		spawn_point_chk_ref = swat_spawn
	}
	self.enemy_spawn_groups.city_swat_rifle = {
		amount = { 4, 5 },
		spawn = {
			{ rank = 2, unit = "CITY_swat_G36", tactics = self._tactics.swat_rifle, amount_min = 2, amount_max = 2, freq = 2 },
			{ rank = 3, unit = "CITY_heavy_G36", tactics = self._tactics.swat_rifle, amount_min = 2, amount_max = 2, freq = 2 },
			{ rank = 2, unit = "medic_M4", tactics = self._tactics.swat_rifle, amount_min = 0, amount_max = 1, freq = 0.35 }
		},
		spawn_point_chk_ref = swat_spawn
	}
	self.enemy_spawn_groups.zeal_swat_rifle = {
		amount = { 4, 5 },
		spawn = {
			{ rank = 2, unit = "ZEAL_swat", tactics = self._tactics.swat_rifle, amount_min = 1, amount_max = 1, freq = 1 },
			{ rank = 3, unit = "ZEAL_heavy", tactics = self._tactics.swat_rifle, amount_min = 3, amount_max = 3, freq = 3 },
			{ rank = 2, unit = "medic_M4", tactics = self._tactics.swat_rifle, amount_min = 0, amount_max = 1, freq = 0.35 }
		},
		spawn_point_chk_ref = swat_spawn
	}

	self.enemy_spawn_groups.mpdc_swat_rifle_flank = {
		amount = { 4, 4 },
		spawn = {
			{ rank = 2, unit = "CS_swat_MP5", tactics = self._tactics.swat_rifle_flank, amount_min = 2, amount_max = 2, freq = 1 },
			{ rank = 3, unit = "CS_heavy_M4", tactics = self._tactics.swat_rifle_flank, amount_min = 2, amount_max = 2, freq = 1 }
		},
		spawn_point_chk_ref = swat_spawn
	}
	self.enemy_spawn_groups.fbi_swat_rifle_flank = {
		amount = { 4, 5 },
		spawn = {
			{ rank = 2, unit = "FBI_swat_M4", tactics = self._tactics.swat_rifle_flank, amount_min = 3, amount_max = 3, freq = 3 },
			{ rank = 3, unit = "FBI_heavy_G36", tactics = self._tactics.swat_rifle_flank, amount_min = 1, amount_max = 1, freq = 1 },
			{ rank = 2, unit = "medic_M4", tactics = self._tactics.swat_rifle_flank, amount_min = 0, amount_max = 1, freq = 0.2 }
		},
		spawn_point_chk_ref = swat_spawn
	}
	self.enemy_spawn_groups.city_swat_rifle_flank = {
		amount = { 4, 5 },
		spawn = {
			{ rank = 2, unit = "CITY_swat_G36", tactics = self._tactics.swat_rifle_flank, amount_min = 2, amount_max = 2, freq = 2 },
			{ rank = 3, unit = "CITY_heavy_G36", tactics = self._tactics.swat_rifle_flank, amount_min = 2, amount_max = 2, freq = 2 },
			{ rank = 2, unit = "medic_M4", tactics = self._tactics.swat_rifle_flank, amount_min = 0, amount_max = 1, freq = 0.35 }
		},
		spawn_point_chk_ref = swat_spawn
	}
	self.enemy_spawn_groups.zeal_swat_rifle_flank = {
		amount = { 4, 5 },
		spawn = {
			{ rank = 2, unit = "ZEAL_swat", tactics = self._tactics.swat_rifle_flank, amount_min = 1, amount_max = 1, freq = 1 },
			{ rank = 3, unit = "ZEAL_heavy", tactics = self._tactics.swat_rifle_flank, amount_min = 3, amount_max = 3, freq = 3 },
			{ rank = 2, unit = "medic_M4", tactics = self._tactics.swat_rifle_flank, amount_min = 0, amount_max = 1, freq = 0.35 }
		},
		spawn_point_chk_ref = swat_spawn
	}

	self.enemy_spawn_groups.mpdc_shield_wall_ranged = {
		amount = { 4, 4 },
		spawn = {
			{ rank = 2, unit = "CS_heavy_M4", tactics = self._tactics.shield_support_ranged, amount_min = 2, amount_max = 2, freq = 1 },
			{ rank = 3, unit = "CS_shield", tactics = self._tactics.shield_wall_ranged, amount_min = 2, amount_max = 2, freq = 1 }
		},
		spawn_point_chk_ref = shield_spawn
	}
	self.enemy_spawn_groups.fbi_shield_wall_ranged = {
		amount = { 4, 5 },
		spawn = {
			{ rank = 2, unit = "FBI_heavy_G36", tactics = self._tactics.shield_support_ranged, amount_min = 2, amount_max = 2, freq = 2 },
			{ rank = 3, unit = "FBI_shield", tactics = self._tactics.shield_wall_ranged, amount_min = 2, amount_max = 2, freq = 2 },
			{ rank = 2, unit = "medic_M4", tactics = self._tactics.shield_support_charge, amount_min = 0, amount_max = 1, freq = 0.2 }
		},
		spawn_point_chk_ref = shield_spawn
	}
	self.enemy_spawn_groups.city_shield_wall_ranged = {
		amount = { 4, 5 },
		spawn = {
			{ rank = 2, unit = "CITY_heavy_G36", tactics = self._tactics.shield_support_ranged, amount_min = 2, amount_max = 2, freq = 2 },
			{ rank = 3, unit = "CITY_shield", tactics = self._tactics.shield_wall_ranged, amount_min = 2, amount_max = 2, freq = 2 },
			{ rank = 2, unit = "medic_M4", tactics = self._tactics.shield_support_charge, amount_min = 0, amount_max = 1, freq = 0.35 }
		},
		spawn_point_chk_ref = shield_spawn
	}
	self.enemy_spawn_groups.zeal_shield_wall_ranged = {
		amount = { 4, 5 },
		spawn = {
			{ rank = 2, unit = "ZEAL_heavy", tactics = self._tactics.shield_support_ranged, amount_min = 2, amount_max = 2, freq = 2 },
			{ rank = 3, unit = "ZEAL_shield", tactics = self._tactics.shield_wall_ranged, amount_min = 2, amount_max = 2, freq = 2 },
			{ rank = 2, unit = "medic_M4", tactics = self._tactics.shield_support_charge, amount_min = 0, amount_max = 1, freq = 0.5 }
		},
		spawn_point_chk_ref = shield_spawn
	}

	self.enemy_spawn_groups.mpdc_shield_wall_charge = {
		amount = { 4, 4 },
		spawn = {
			{ rank = 2, unit = "CS_heavy_R870", tactics = self._tactics.shield_support_charge, amount_min = 2, amount_max = 2, freq = 1 },
			{ rank = 3, unit = "CS_shield", tactics = self._tactics.shield_wall_charge, amount_min = 2, amount_max = 2, freq = 1 }
		},
		spawn_point_chk_ref = shield_spawn
	}
	self.enemy_spawn_groups.fbi_shield_wall_charge = {
		amount = { 4, 5 },
		spawn = {
			{ rank = 2, unit = "FBI_heavy_R870", tactics = self._tactics.shield_support_charge, amount_min = 2, amount_max = 2, freq = 2 },
			{ rank = 3, unit = "FBI_shield", tactics = self._tactics.shield_wall_charge, amount_min = 2, amount_max = 2, freq = 2 },
			{ rank = 2, unit = "medic_R870", tactics = self._tactics.shield_support_charge, amount_min = 0, amount_max = 1, freq = 0.2 }
		},
		spawn_point_chk_ref = shield_spawn
	}
	self.enemy_spawn_groups.city_shield_wall_charge = {
		amount = { 4, 5 },
		spawn = {
			{ rank = 2, unit = "CITY_heavy_BEN", tactics = self._tactics.shield_support_charge, amount_min = 2, amount_max = 2, freq = 2 },
			{ rank = 3, unit = "CITY_shield", tactics = self._tactics.shield_wall_charge, amount_min = 2, amount_max = 2, freq = 2 },
			{ rank = 2, unit = "medic_R870", tactics = self._tactics.shield_support_charge, amount_min = 0, amount_max = 1, freq = 0.35 }
		},
		spawn_point_chk_ref = shield_spawn
	}
	self.enemy_spawn_groups.zeal_shield_wall_charge = {
		amount = { 4, 5 },
		spawn = {
			{ rank = 2, unit = "ZEAL_heavy", tactics = self._tactics.shield_support_charge, amount_min = 2, amount_max = 2, freq = 2 },
			{ rank = 3, unit = "ZEAL_shield", tactics = self._tactics.shield_wall_charge, amount_min = 2, amount_max = 2, freq = 2 },
			{ rank = 2, unit = "medic_R870", tactics = self._tactics.shield_support_charge, amount_min = 0, amount_max = 1, freq = 0.5 }
		},
		spawn_point_chk_ref = shield_spawn
	}

	self.enemy_spawn_groups.mpdc_shield_wall = {
		amount = { 4, 4 },
		spawn = {
			{ rank = 3, unit = "CS_shield", tactics = self._tactics.shield_wall, amount_min = 4, amount_max = 4, freq = 1 }
		},
		spawn_point_chk_ref = shield_spawn
	}
	self.enemy_spawn_groups.fbi_shield_wall = {
		amount = { 4, 5 },
		spawn = {
			{ rank = 3, unit = "FBI_shield", tactics = self._tactics.shield_wall, amount_min = 4, amount_max = 4, freq = 4 },
			{ rank = 3, unit = "medic_M4", tactics = self._tactics.shield_wall, amount_min = 0, amount_max = 1, freq = 0.2 },
			{ rank = 3, unit = "medic_R870", tactics = self._tactics.shield_wall, amount_min = 0, amount_max = 1, freq = 0.2 }
		},
		spawn_point_chk_ref = shield_spawn
	}
	self.enemy_spawn_groups.city_shield_wall = {
		amount = { 4, 5 },
		spawn = {
			{ rank = 3, unit = "CITY_shield", tactics = self._tactics.shield_wall, amount_min = 4, amount_max = 4, freq = 4 },
			{ rank = 3, unit = "medic_M4", tactics = self._tactics.shield_wall, amount_min = 0, amount_max = 1, freq = 0.35 },
			{ rank = 3, unit = "medic_R870", tactics = self._tactics.shield_wall, amount_min = 0, amount_max = 1, freq = 0.35 }
		},
		spawn_point_chk_ref = shield_spawn
	}
	self.enemy_spawn_groups.zeal_shield_wall = {
		amount = { 4, 5 },
		spawn = {
			{ rank = 3, unit = "ZEAL_shield", tactics = self._tactics.shield_wall, amount_min = 4, amount_max = 4, freq = 4 },
			{ rank = 3, unit = "medic_M4", tactics = self._tactics.shield_wall, amount_min = 0, amount_max = 1, freq = 0.5 },
			{ rank = 3, unit = "medic_R870", tactics = self._tactics.shield_wall, amount_min = 0, amount_max = 1, freq = 0.5 }
		},
		spawn_point_chk_ref = shield_spawn
	}

	self.enemy_spawn_groups.mpdc_tazer_flanking = {
		amount = { 3, 3 },
		spawn = {
			{ rank = 3, unit = "CS_tazer", tactics = self._tactics.tazer_flanking, amount_min = 1, amount_max = 1, freq = 1 },
			{ rank = 2, unit = "CS_swat_MP5", tactics = self._tactics.tazer_flanking, amount_min = 2, amount_max = 2, freq = 1 }
		},
		spawn_point_chk_ref = taser_spawn
	}
	self.enemy_spawn_groups.fbi_tazer_flanking = {
		amount = { 4, 4 },
		spawn = {
			{ rank = 3, unit = "CS_tazer", tactics = self._tactics.tazer_flanking, amount_min = 1, amount_max = 1, freq = 1 },
			{ rank = 2, unit = "FBI_swat_M4", tactics = self._tactics.tazer_flanking, amount_min = 3, amount_max = 3, freq = 3 }
		},
		spawn_point_chk_ref = taser_spawn
	}
	self.enemy_spawn_groups.city_tazer_flanking = {
		amount = { 5, 5 },
		spawn = {
			{ rank = 3, unit = "CS_tazer", tactics = self._tactics.tazer_flanking, amount_min = 2, amount_max = 2, freq = 2 },
			{ rank = 2, unit = "CITY_swat_G36", tactics = self._tactics.tazer_flanking, amount_min = 3, amount_max = 3, freq = 3 }
		},
		spawn_point_chk_ref = taser_spawn
	}
	self.enemy_spawn_groups.zeal_tazer_flanking = {
		amount = { 5, 6 },
		spawn = {
			{ rank = 3, unit = "ZEAL_tazer", tactics = self._tactics.tazer_flanking, amount_min = 2, amount_max = 2, freq = 2 },
			{ rank = 2, unit = "ZEAL_swat", tactics = self._tactics.tazer_flanking, amount_min = 3, amount_max = 3, freq = 3 },
			{ rank = 2, unit = "medic_M4", tactics = self._tactics.tazer_flanking, amount_min = 0, amount_max = 1, freq = 0.5 }
		},
		spawn_point_chk_ref = taser_spawn
	}

	self.enemy_spawn_groups.mpdc_tazer_charge = {
		amount = { 3, 3 },
		spawn = {
			{ rank = 3, unit = "CS_tazer", tactics = self._tactics.tazer_charge, amount_min = 1, amount_max = 1, freq = 1 },
			{ rank = 2, unit = "CS_swat_R870", tactics = self._tactics.tazer_charge, amount_min = 2, amount_max = 2, freq = 1 }
		},
		spawn_point_chk_ref = taser_spawn
	}
	self.enemy_spawn_groups.fbi_tazer_charge = {
		amount = { 4, 4 },
		spawn = {
			{ rank = 3, unit = "CS_tazer", tactics = self._tactics.tazer_charge, amount_min = 1, amount_max = 1, freq = 1 },
			{ rank = 2, unit = "FBI_swat_R870", tactics = self._tactics.tazer_charge, amount_min = 3, amount_max = 3, freq = 3 }
		},
		spawn_point_chk_ref = taser_spawn
	}
	self.enemy_spawn_groups.city_tazer_charge = {
		amount = { 5, 5 },
		spawn = {
			{ rank = 3, unit = "CS_tazer", tactics = self._tactics.tazer_charge, amount_min = 2, amount_max = 2, freq = 2 },
			{ rank = 2, unit = "CITY_swat_BEN", tactics = self._tactics.tazer_charge, amount_min = 3, amount_max = 3, freq = 3 }
		},
		spawn_point_chk_ref = taser_spawn
	}
	self.enemy_spawn_groups.zeal_tazer_charge = {
		amount = { 5, 6 },
		spawn = {
			{ rank = 3, unit = "ZEAL_tazer", tactics = self._tactics.tazer_charge, amount_min = 2, amount_max = 2, freq = 2 },
			{ rank = 2, unit = "ZEAL_swat", tactics = self._tactics.tazer_charge, amount_min = 3, amount_max = 3, freq = 3 },
			{ rank = 2, unit = "medic_R870", tactics = self._tactics.tazer_charge, amount_min = 0, amount_max = 1, freq = 0.5 }
		},
		spawn_point_chk_ref = taser_spawn
	}

	self.enemy_spawn_groups.mpdc_bull_rush = {
		amount = { 3, 3 },
		spawn = {
			{ rank = 3, unit = "FBI_tank", tactics = self._tactics.tank_rush, amount_min = 1, amount_max = 1, freq = 1 },
			{ rank = 2, unit = "CS_heavy_M4", tactics = self._tactics.tank_rush, amount_min = 1, amount_max = 1, freq = 1 },
			{ rank = 2, unit = "CS_heavy_R870", tactics = self._tactics.tank_rush, amount_min = 1, amount_max = 1, freq = 1 }
		},
		spawn_point_chk_ref = bulldozer_spawn
	}
	self.enemy_spawn_groups.fbi_bull_rush = {
		amount = { 4, 4 },
		spawn = {
			{ rank = 3, unit = "FBI_tank", tactics = self._tactics.tank_rush, amount_min = 1, amount_max = 1, freq = 1 },
			{ rank = 2, unit = "FBI_heavy_G36", tactics = self._tactics.tank_rush, amount_min = 1, amount_max = 2, freq = 1 },
			{ rank = 2, unit = "FBI_heavy_R870", tactics = self._tactics.tank_rush, amount_min = 1, amount_max = 2, freq = 1 }
		},
		spawn_point_chk_ref = bulldozer_spawn
	}
	self.enemy_spawn_groups.city_bull_rush = {
		amount = { 5, 5 },
		spawn = {
			{ rank = 3, unit = "FBI_tank", tactics = self._tactics.tank_rush, amount_min = 2, amount_max = 2, freq = 2 },
			{ rank = 2, unit = "CITY_heavy_G36", tactics = self._tactics.tank_rush, amount_min = 1, amount_max = 2, freq = 1 },
			{ rank = 2, unit = "CITY_heavy_BEN", tactics = self._tactics.tank_rush, amount_min = 1, amount_max = 2, freq = 1 }
		},
		spawn_point_chk_ref = bulldozer_spawn
	}
	self.enemy_spawn_groups.zeal_bull_rush = {
		amount = { 5, 6 },
		spawn = {
			{ rank = 3, unit = "ZEAL_tank", tactics = self._tactics.tank_rush, amount_min = 2, amount_max = 2, freq = 2 },
			{ rank = 3, unit = "ZEAL_heavy", tactics = self._tactics.tank_rush, amount_min = 3, amount_max = 3, freq = 3 },
			{ rank = 2, unit = "medic_M4", tactics = self._tactics.tank_rush, amount_min = 0, amount_max = 1, freq = 0.5 },
			{ rank = 2, unit = "medic_R870", tactics = self._tactics.tank_rush, amount_min = 0, amount_max = 1, freq = 0.5 }
		},
		spawn_point_chk_ref = bulldozer_spawn
	}

	self.enemy_spawn_groups.marshal_squad = {
		spawn_cooldown = 30,
		max_nr_simultaneous_groups = 1,
		initial_spawn_delay = 90,
		amount = { 2, 2 },
		spawn = {
			{ rank = 2, unit = "marshal_shield", tactics = self._tactics.marshal_shield, amount_min = 1, freq = 2, respawn_cooldown = 30 },
			{ rank = 1, unit = "marshal_marksman", tactics = self._tactics.marshal_marksman, amount_min = 1, freq = 2, respawn_cooldown = 30 }
		},
		spawn_point_chk_ref = shield_spawn
	}

	self.enemy_spawn_groups.CS_defend_a = {
		amount = { 3, 4 },
		spawn = {
			{ rank = 1, unit = "CS_cop_C45_R870", tactics = self._tactics.CS_cop, freq = 1 }
		},
		spawn_point_chk_ref = swat_spawn
	}
	self.enemy_spawn_groups.FBI_defend_a = {
		amount = { 3, 3 },
		spawn = {
			{ rank = 1, unit = "FBI_suit_C45_M4", tactics = self._tactics.FBI_suit, amount_min = 1, freq = 1 },
			{ rank = 1, unit = "CS_cop_C45_R870", tactics = self._tactics.FBI_suit, freq = 1 }
		},
		spawn_point_chk_ref = swat_spawn
	}
	self.enemy_spawn_groups.CITY_defend_a = {
		amount = { 3, 3 },
		spawn = {
			{ rank = 1, unit = "FBI_suit_C45_M4", tactics = self._tactics.FBI_suit, amount_min = 1, freq = 1 },
			{ rank = 1, unit = "CS_cop_C45_R870", tactics = self._tactics.FBI_suit, freq = 1 }
		},
		spawn_point_chk_ref = swat_spawn
	}
	self.enemy_spawn_groups.ZEAL_defend_a = {
		amount = { 3, 3 },
		spawn = {
			{ rank = 1, unit = "FBI_suit_C45_M4", tactics = self._tactics.FBI_suit, amount_min = 1, freq = 1 },
			{ rank = 1, unit = "CS_cop_C45_R870", tactics = self._tactics.FBI_suit, freq = 1 }
		},
		spawn_point_chk_ref = swat_spawn
	}

	self.enemy_spawn_groups.CS_defend_b = {
		amount = { 3, 4 },
		spawn = {
			{ rank = 1, unit = "CS_swat_MP5", tactics = self._tactics.CS_cop, freq = 1 }
		},
		spawn_point_chk_ref = swat_spawn
	}
	self.enemy_spawn_groups.FBI_defend_b = {
		amount = { 3, 3 },
		spawn = {
			{ rank = 2, unit = "FBI_suit_M4_MP5", tactics = self._tactics.FBI_suit, amount_min = 1, freq = 1 },
			{ rank = 1, unit = "FBI_swat_M4", tactics = self._tactics.FBI_suit, freq = 1 }
		},
		spawn_point_chk_ref = swat_spawn
	}
	self.enemy_spawn_groups.CITY_defend_b = {
		amount = { 3, 3 },
		spawn = {
			{ rank = 2, unit = "FBI_suit_M4_MP5", tactics = self._tactics.FBI_suit, amount_min = 1, freq = 1 },
			{ rank = 1, unit = "CITY_swat_G36", tactics = self._tactics.FBI_suit, freq = 1 }
		},
		spawn_point_chk_ref = swat_spawn
	}
	self.enemy_spawn_groups.ZEAL_defend_b = {
		amount = { 3, 3 },
		spawn = {
			{ rank = 2, unit = "FBI_suit_M4_MP5", tactics = self._tactics.FBI_suit, amount_min = 1, freq = 1 },
			{ rank = 1, unit = "ZEAL_swat", tactics = self._tactics.FBI_suit, freq = 1 }
		},
		spawn_point_chk_ref = swat_spawn
	}

	self.enemy_spawn_groups.CS_defend_c = {
		amount = { 3, 4 },
		spawn = {
			{ rank = 1, unit = "CS_heavy_M4", tactics = self._tactics.CS_cop, freq = 1 }
		},
		spawn_point_chk_ref = swat_spawn
	}
	self.enemy_spawn_groups.FBI_defend_c = {
		amount = { 3, 3 },
		spawn = {
			{ rank = 1, unit = "FBI_swat_M4", tactics = self._tactics.FBI_suit, freq = 1 }
		},
		spawn_point_chk_ref = swat_spawn
	}
	self.enemy_spawn_groups.CITY_defend_c = {
		amount = { 3, 3 },
		spawn = {
			{ rank = 1, unit = "CITY_swat_G36", tactics = self._tactics.FBI_suit, freq = 1 }
		},
		spawn_point_chk_ref = swat_spawn
	}
	self.enemy_spawn_groups.ZEAL_defend_c = {
		amount = { 3, 3 },
		spawn = {
			{ rank = 1, unit = "ZEAL_swat", tactics = self._tactics.FBI_suit, freq = 1 }
		},
		spawn_point_chk_ref = swat_spawn
	}

	self.enemy_spawn_groups.FBI_defend_d = {
		amount = { 2, 3 },
		spawn = {
			{ rank = 1, unit = "FBI_heavy_G36", tactics = self._tactics.FBI_suit, freq = 1 }
		},
		spawn_point_chk_ref = swat_spawn
	}
	self.enemy_spawn_groups.CITY_defend_d = {
		amount = { 2, 3 },
		spawn = {
			{ rank = 1, unit = "CITY_heavy_G36", tactics = self._tactics.FBI_suit, freq = 1 }
		},
		spawn_point_chk_ref = swat_spawn
	}
	self.enemy_spawn_groups.ZEAL_defend_d = {
		amount = { 2, 3 },
		spawn = {
			{ rank = 1, unit = "ZEAL_heavy", tactics = self._tactics.FBI_suit, freq = 1 }
		},
		spawn_point_chk_ref = swat_spawn
	}

	self.enemy_spawn_groups.CS_cops = {
		amount = { 3, 4 },
		spawn = {
			{ rank = 1, unit = "CS_cop_C45_R870", tactics = self._tactics.CS_cop, amount_min = 1, freq = 1 }
		},
		spawn_point_chk_ref = swat_spawn
	}
	self.enemy_spawn_groups.CS_stealth_a = {
		amount = { 2, 3 },
		spawn = {
			{ rank = 1, unit = "CS_cop_stealth_MP5", tactics = self._tactics.CS_cop_stealth, amount_min = 1, freq = 1 }
		},
		spawn_point_chk_ref = swat_spawn
	}
	self.enemy_spawn_groups.FBI_stealth_a = {
		amount = { 2, 3 },
		spawn = {
			{ rank = 1, unit = "FBI_suit_stealth_MP5", tactics = self._tactics.FBI_suit_stealth, amount_min = 1, freq = 1 },
			{ rank = 2, unit = "CS_tazer", tactics = self._tactics.CS_tazer, amount_max = 2, freq = 1 }
		},
		spawn_point_chk_ref = swat_spawn
	}
	self.enemy_spawn_groups.CITY_stealth_a = {
		amount = { 3, 4 },
		spawn = {
			{ rank = 1, unit = "FBI_suit_stealth_MP5", tactics = self._tactics.FBI_suit_stealth, amount_min = 1, freq = 1 },
			{ rank = 2, unit = "CS_tazer", tactics = self._tactics.CS_tazer, amount_max = 2, freq = 1 }
		},
		spawn_point_chk_ref = swat_spawn
	}
	self.enemy_spawn_groups.ZEAL_stealth_a = {
		amount = { 3, 4 },
		spawn = {
			{ rank = 1, unit = "FBI_suit_stealth_MP5", tactics = self._tactics.FBI_suit_stealth, amount_min = 1, freq = 1 },
			{ rank = 2, unit = "ZEAL_tazer", tactics = self._tactics.CS_tazer, amount_max = 2, freq = 1 }
		},
		spawn_point_chk_ref = swat_spawn
	}

	self.enemy_spawn_groups.FBI_stealth_b = {
		amount = { 2, 3 },
		spawn = {
			{ rank = 1, unit = "FBI_suit_stealth_MP5", tactics = self._tactics.FBI_suit_stealth, amount_min = 1, freq = 1 },
			{ rank = 2, unit = "FBI_suit_M4_MP5", tactics = self._tactics.FBI_suit, freq = 0.75 }
		},
		spawn_point_chk_ref = swat_spawn
	}
	self.enemy_spawn_groups.CITY_stealth_b = {
		amount = { 4, 4 },
		spawn = {
			{ rank = 1, unit = "FBI_suit_stealth_MP5", tactics = self._tactics.FBI_suit_stealth, amount_min = 1, freq = 1 },
			{ rank = 2, unit = "FBI_suit_M4_MP5", tactics = self._tactics.FBI_suit, freq = 0.75 }
		},
		spawn_point_chk_ref = swat_spawn
	}
	self.enemy_spawn_groups.ZEAL_stealth_b = {
		amount = { 4, 4 },
		spawn = {
			{ rank = 1, unit = "FBI_suit_stealth_MP5", tactics = self._tactics.FBI_suit_stealth, amount_min = 1, freq = 1 },
			{ rank = 2, unit = "FBI_suit_M4_MP5", tactics = self._tactics.FBI_suit, freq = 0.75 }
		},
		spawn_point_chk_ref = swat_spawn
	}

	self.enemy_spawn_groups.CS_swats = {
		amount = { 3, 4 },
		spawn = {
			{ rank = 2, unit = "CS_swat_MP5", tactics = self._tactics.CS_swat_rifle, freq = 1 },
			{ rank = 1, unit = "CS_swat_R870", tactics = self._tactics.CS_swat_shotgun, amount_max = 2, freq = 0.5 },
			{ rank = 3, unit = "CS_swat_MP5", tactics = self._tactics.CS_swat_rifle_flank, freq = 0.33 }
		},
		spawn_point_chk_ref = swat_spawn
	}
	self.enemy_spawn_groups.FBI_swats = {
		amount = { 3, 4 },
		spawn = {
			{ rank = 2, unit = "FBI_swat_M4", tactics = self._tactics.FBI_swat_rifle, amount_min = 1, freq = 1 },
			{ rank = 3, unit = "FBI_swat_M4", tactics = self._tactics.FBI_swat_rifle_flank, freq = 0.75 },
			{ rank = 1, unit = "FBI_swat_R870", tactics = self._tactics.FBI_swat_shotgun, amount_max = 2, freq = 0.5 },
			{ rank = 1, unit = "spooc", tactics = self._tactics.spooc, amount_max = 2, freq = 0.15 }
		},
		spawn_point_chk_ref = swat_spawn
	}
	self.enemy_spawn_groups.CITY_swats = {
		amount = { 3, 4 },
		spawn = {
			{ rank = 1, unit = "CITY_swat_G36", tactics = self._tactics.FBI_swat_rifle, amount_min = 3, freq = 1 },
			{ rank = 2, unit = "FBI_suit_M4_MP5", tactics = self._tactics.FBI_swat_rifle_flank, freq = 0.75 },
			{ rank = 3, unit = "CITY_swat_BEN_UMP", tactics = self._tactics.FBI_swat_shotgun, amount_min = 2, freq = 1 }
		},
		spawn_point_chk_ref = swat_spawn
	}
	self.enemy_spawn_groups.ZEAL_swats = {
		amount = { 3, 4 },
		spawn = {
			{ rank = 1, unit = "ZEAL_swat", tactics = self._tactics.FBI_swat_rifle, amount_min = 3, freq = 1 },
			{ rank = 2, unit = "FBI_suit_M4_MP5", tactics = self._tactics.FBI_swat_rifle_flank, freq = 0.75 },
			{ rank = 3, unit = "ZEAL_swat", tactics = self._tactics.FBI_swat_shotgun, amount_min = 2, freq = 1 }
		},
		spawn_point_chk_ref = swat_spawn
	}

	self.enemy_spawn_groups.CS_heavys = {
		amount = { 3, 4 },
		spawn = {
			{ rank = 2, unit = "CS_heavy_M4", tactics = self._tactics.CS_swat_rifle, freq = 1 },
			{ rank = 3, unit = "CS_heavy_M4", tactics = self._tactics.CS_swat_rifle_flank, freq = 0.35 }
		},
		spawn_point_chk_ref = swat_spawn
	}
	self.enemy_spawn_groups.FBI_heavys = {
		amount = { 2, 3 },
		spawn = {
			{ rank = 1, unit = "FBI_heavy_G36", tactics = self._tactics.FBI_swat_rifle, freq = 1 },
			{ rank = 2, unit = "FBI_heavy_G36", tactics = self._tactics.FBI_swat_rifle_flank, freq = 0.75 },
			{ rank = 3, unit = "CS_tazer", tactics = self._tactics.CS_tazer, amount_max = 1, freq = 0.25 }
		},
		spawn_point_chk_ref = swat_spawn
	}
	self.enemy_spawn_groups.CITY_heavys = {
		amount = { 3, 4 },
		spawn = {
			{ rank = 1, unit = "CITY_heavy_G36_w", tactics = self._tactics.FBI_swat_rifle, amount_min = 4, freq = 1 },
			{ rank = 2, unit = "CITY_swat_G36", tactics = self._tactics.FBI_heavy_flank, amount_min = 3, freq = 1 },
		},
		spawn_point_chk_ref = swat_spawn
	}
	self.enemy_spawn_groups.ZEAL_heavys = {
		amount = { 3, 4 },
		spawn = {
			{ rank = 1, unit = "ZEAL_heavy_w", tactics = self._tactics.FBI_swat_rifle, amount_min = 4, freq = 1 }
		},
		spawn_point_chk_ref = swat_spawn
	}

	self.enemy_spawn_groups.CS_shields = {
		amount = { 3, 4 },
		spawn = {
			{ rank = 3, unit = "CS_shield", tactics = self._tactics.CS_shield, amount_min = 1, amount_max = 2, freq = 1 },
			{ rank = 1, unit = "CS_cop_stealth_MP5", tactics = self._tactics.CS_cop_stealth, amount_max = 1, freq = 0.5 },
			{ rank = 2, unit = "CS_heavy_M4_w", tactics = self._tactics.CS_swat_heavy, amount_max = 1, freq = 0.75 }
		},
		spawn_point_chk_ref = shield_spawn
	}
	self.enemy_spawn_groups.FBI_shields = {
		amount = { 3, 4 },
		spawn = {
			{ rank = 3, unit = "FBI_shield", tactics = self._tactics.FBI_shield_flank, amount_min = 1, amount_max = 2, freq = 1 },
			{ rank = 2, unit = "CS_tazer", tactics = self._tactics.CS_tazer, amount_max = 1, freq = 0.75 },
			{ rank = 1, unit = "FBI_heavy_G36", tactics = self._tactics.FBI_swat_rifle_flank, amount_max = 1, freq = 0.5 }
		},
		spawn_point_chk_ref = shield_spawn
	}
	self.enemy_spawn_groups.CITY_shields = {
		amount = { 3, 4 },
		spawn = {
			{ rank = 3, unit = "CITY_shield", tactics = self._tactics.FBI_shield, amount_min = 3, amount_max = 4, freq = 1 },
			{ rank = 1, unit = "FBI_suit_stealth_MP5", tactics = self._tactics.FBI_suit_stealth, amount_min = 1, freq = 1 },
			{ rank = 1, unit = "spooc", tactics = self._tactics.spooc, amount_max = 2, freq = 0.15 },
			{ rank = 2, unit = "CS_tazer", tactics = self._tactics.CS_swat_heavy, amount_min = 2, freq = 0.75 }
		},
		spawn_point_chk_ref = shield_spawn
	}
	self.enemy_spawn_groups.ZEAL_shields = {
		amount = { 3, 4 },
		spawn = {
			{ rank = 3, unit = "ZEAL_shield", tactics = self._tactics.FBI_shield, amount_min = 3, amount_max = 4, freq = 1 },
			{ rank = 1, unit = "ZEAL_swat", tactics = self._tactics.FBI_suit_stealth, amount_min = 1, freq = 1 },
			{ rank = 1, unit = "ZEAL_spooc", tactics = self._tactics.spooc, amount_max = 2, freq = 0.15 },
			{ rank = 2, unit = "ZEAL_tazer", tactics = self._tactics.CS_swat_heavy, amount_min = 2, freq = 0.75 }
		},
		spawn_point_chk_ref = shield_spawn
	}

	self.enemy_spawn_groups.CS_tazers = {
		amount = { 1, 3 },
		spawn = {
			{ rank = 2, unit = "CS_tazer", tactics = self._tactics.CS_tazer, amount_min = 1, amount_max = 1, freq = 1 },
			{ rank = 1, unit = "CS_swat_MP5", tactics = self._tactics.CS_cop_stealth, amount_max = 2, freq = 1 }
		},
		spawn_point_chk_ref = taser_spawn
	}

	self.enemy_spawn_groups.FBI_tazers = {
		amount = { 1, 3 },
		spawn = {
			{ rank = 2, unit = "CS_tazer", tactics = self._tactics.CS_tazer, amount_min = 1, amount_max = 1, freq = 1 },
			{ rank = 1, unit = "FBI_swat_M4", tactics = self._tactics.CS_cop_stealth, amount_max = 2, freq = 1 }
		},
		spawn_point_chk_ref = taser_spawn
	}
	self.enemy_spawn_groups.CITY_tazers = {
		amount = { 4, 4 },
		spawn = {
			{ rank = 1, unit = "CS_tazer", tactics = self._tactics.CS_tazer, amount_min = 3, freq = 1 },
			{ rank = 3, unit = "CITY_shield", tactics = self._tactics.FBI_shield, amount_min = 2, amount_max = 3, freq = 1 },
			{ rank = 1, unit = "CITY_heavy_G36", tactics = self._tactics.FBI_swat_rifle, amount_max = 2, freq = 1 }
		},
		spawn_point_chk_ref = taser_spawn
	}
	self.enemy_spawn_groups.ZEAL_tazers = {
		amount = { 4, 4 },
		spawn = {
			{ rank = 1, unit = "ZEAL_tazer", tactics = self._tactics.CS_tazer, amount_min = 3, freq = 1 },
			{ rank = 3, unit = "ZEAL_shield", tactics = self._tactics.FBI_shield, amount_min = 2, amount_max = 3, freq = 1 },
			{ rank = 1, unit = "ZEAL_heavy", tactics = self._tactics.FBI_swat_rifle, amount_max = 2, freq = 1 }
		},
		spawn_point_chk_ref = taser_spawn
	}

	self.enemy_spawn_groups.CS_tanks = {
		amount = { 1, 2 },
		spawn = {
			{ rank = 2, unit = "FBI_tank", tactics = self._tactics.FBI_tank, amount_min = 1, freq = 1 },
			{ rank = 1, unit = "CS_tazer", tactics = self._tactics.CS_tazer, amount_max = 1, freq = 0.5 }
		},
		spawn_point_chk_ref = bulldozer_spawn
	}
	self.enemy_spawn_groups.FBI_tanks = {
		amount = { 3, 4 },
		spawn = {
			{ rank = 1, unit = "FBI_tank", tactics = self._tactics.FBI_tank, amount_max = 1, freq = 1 },
			{ rank = 3, unit = "FBI_shield", tactics = self._tactics.FBI_shield_flank, amount_min = 1, amount_max = 2, freq = 0.5 },
			{ rank = 1, unit = "FBI_heavy_G36_w", tactics = self._tactics.FBI_heavy_flank, amount_min = 1, freq = 0.75 }
		},
		spawn_point_chk_ref = bulldozer_spawn
	}
	self.enemy_spawn_groups.CITY_tanks = {
		amount = { 4, 4 },
		spawn = {
			{ rank = 3, unit = "FBI_tank", tactics = self._tactics.FBI_tank, amount_min = 2, freq = 1 },
			{ rank = 3, unit = "CITY_shield", tactics = self._tactics.FBI_shield, amount_min = 1, amount_max = 2, freq = 1 },
			{ rank = 2, unit = "CS_tazer", tactics = self._tactics.FBI_swat_rifle, amount_min = 1, freq = 0.75 }
		},
		spawn_point_chk_ref = bulldozer_spawn
	}
	self.enemy_spawn_groups.ZEAL_tanks = {
		amount = { 4, 4 },
		spawn = {
			{ rank = 3, unit = "ZEAL_tank", tactics = self._tactics.FBI_tank, amount_min = 2, freq = 1 },
			{ rank = 3, unit = "ZEAL_shield", tactics = self._tactics.FBI_shield, amount_min = 1, amount_max = 2, freq = 1 },
			{ rank = 2, unit = "ZEAL_tazer", tactics = self._tactics.FBI_swat_rifle, amount_min = 1, freq = 0.75 }
		},
		spawn_point_chk_ref = bulldozer_spawn
	}

	self.enemy_spawn_groups.single_spooc = {
		amount = { 1, 1 },
		spawn = {
			{ rank = 1, unit = is_death_sentence and "ZEAL_spooc" or "spooc", tactics = self._tactics.spooc, amount_min = 1, freq = 1 }
		}
	}
	self.enemy_spawn_groups.FBI_spoocs = {
		amount = { 1, 1 },
		spawn = {
			{ rank = 1, unit = "spooc", tactics = self._tactics.spooc, amount_min = 1, freq = 1 }
		}
	}
	self.enemy_spawn_groups.ZEAL_spoocs = {
		amount = { 1, 1 },
		spawn = {
			{ rank = 1, unit = "ZEAL_spooc", tactics = self._tactics.spooc, amount_min = 1, freq = 1 }
		},
		spawn_point_chk_ref = cloaker_spawn
	}

end )


Hooks:PostHook( GroupAITweakData, "_init_task_data", "gbms__init_task_data", function(self, difficulty_index)
	local new_groups = GBMS["task_data_" .. GBMS:get_spawn_group_set()](self, difficulty_index)

	GBMS:swap_groups(self, new_groups)
end )
