-- Mock Data
testCharacter = {
    cqi = function() return 123 end,
    get_forename = function() return "Direfan"; end,
    get_surname = function() return "Cylostra"; end,
    character_subtype_key = function() return "wh3_main_tze_kairos"; end,
    command_queue_index = function() end,
    has_military_force = function() return true end,
    military_force = function() return testMilitaryForce; end,
    faction = function() return testFaction; end,
    region = function() return get_cm():get_region(); end,
    logical_position_x = function() return 100; end,
    logical_position_y = function() return 110; end,
    command_queue_index = function() return 10; end,
    character_type = function() return false; end,
    is_null_interface = function() return false; end,
    is_wounded = function() return false; end,
    has_skill = function() return true; end,
    has_ancillary = function() return true; end,
    has_effect_bundle = function() return false; end,
}

testMilitaryForce = {
    is_null_interface = function() return false; end,
    command_queue_index = function() return 10; end,
    is_armed_citizenry = function () return false; end,
    general_character = function() return testCharacter; end,
    unit_list = function() return {
        num_items = function() return 2; end,
        item_at = function(self, index)
            return test_unit;
        end,
    }
    end,
    character_list = function()
        return {
            num_items = function()
                return 1;
            end,
            item_at = function(self, index)
                return testCharacter;
            end,
        };
    end,
}

humanFaction = {
    name = function()
        return "wh2_main_hef_nagarythe";
    end,
    culture = function()
        return "wh_main_grn_greenskins";
    end,
    subculture = function()
        return "wh3_main_sc_tze_tzeentch";
    end,
    character_list = function()
        return {
            num_items = function()
                return 1;
            end,
            item_at = function(self, index)
                return testCharacter;
            end,
        };
    end,
    region_list = function()
        return {
            num_items = function()
                return 1;
            end,
            item_at = function(self, index)
                return cm:get_region(index);
            end,
        };
    end,
    home_region = function ()
        return {
            name = function()
                return "";
            end,
            is_null_interface = function()
                return false;
            end,
        }
    end,
    faction_leader = function() return testCharacter; end,
    is_quest_battle_faction = function() return false; end,
    is_null_interface = function() return false; end,
    is_human = function() return true; end,
    has_effect_bundle = function() return true; end,
    is_horde = function() return false; end,
    can_be_horde = function() return false; end,
}

testFaction = {
    name = function()
        return "wh2_main_skv_clan_eshin";
    end,
    culture = function()
        return "wh2_main_def_dark_elves";
    end,
    subculture = function()
        return "wh3_main_sc_tze_tzeentch";
    end,
    character_list = function()
        return {
            num_items = function()
                return 1;
            end,
            item_at = function()
                return testCharacter;
            end
        };
    end,
    region_list = function()
        return {
            num_items = function()
                return 1;
            end,
            item_at = function(self, index)
                return cm:get_region(index);
            end,
        };
    end,
    home_region = function ()
        return {
            name = function()
                return "";
            end,
            is_null_interface = function()
                return false;
            end,
        }
    end,
    faction_leader = function() return testCharacter; end,
    is_quest_battle_faction = function() return false; end,
    is_null_interface = function() return false; end,
    is_human = function() return false; end,
    has_effect_bundle = function() return true; end,
    command_queue_index = function() return 10; end,
}

testFaction2 = {
    name = function()
        return "wh2_dlc11_cst_rogue_grey_point_scuttlers";
    end,
    subculture = function()
        return "wh_main_sc_nor_norsca";
    end,
    character_list = function()
        return {
            num_items = function()
                return 0;
            end
        };
    end,
    region_list = function()
        return {
            num_items = function()
                return 0;
            end
        };
    end,
    home_region = function ()
        return {
            name = function()
                return "";
            end,
            is_null_interface = function()
                return false;
            end,
        }
    end,
    faction_leader = function() return testCharacter; end,
    is_quest_battle_faction = function() return false; end,
    is_null_interface = function() return false; end,
    is_human = function() return false; end,
    has_effect_bundle = function() return true; end,
    command_queue_index = function() return 10; end,
}

test_unit = {
    unit_key = function() return "wh2_main_hef_inf_archers_1"; end,
    force_commander = function() return testCharacter; end,
    faction = function() return testFaction; end,
    percentage_proportion_of_full_strength = function() return 80; end,
}

effect = {
    get_localised_string = function()
        return "Legendary Lord";
    end,
}

common = {
    get_localised_string = function()
        return "Legendary Lord";
    end,
}

-- This can be modified in the testing driver
-- so we can simulate turns changing easily
local turn_number = 1;

-- Mock functions
mock_listeners = {
    listeners = {},
    trigger_listener = function(self, mockListenerObject)
        local listener = self.listeners[mockListenerObject.Key];
        if listener and listener.Condition(mockListenerObject.Context) then
            listener.Callback(mockListenerObject.Context);
        end
    end,
}

-- Mock save structures
mockSaveData = {

}

-- slot (building) data
slot_1 = {
    has_building = function() return true; end,
    building = function() return {
        name = function() return "wh_msl_barracks_1"; end,
    }
    end,
}

slot_2 = {
    has_building = function() return true; end,
    building = function() return {
        name = function() return "wh_main_vmp_cemetary_2"; end,
    }
    end,
}

function get_cm()
    return   {
        is_new_game = function() return true; end,
        create_agent = function()
            return;
        end,
        get_human_factions = function()
            return {humanFaction};
        end,
        disable_event_feed_events = function() end,
        turn_number = function() return turn_number; end,
        model = function ()
            return {
                military_force_for_command_queue_index = function() return testMilitaryForce; end,
                turn_number = function() return turn_number; end,
                world = function()
                    return {
                        faction_by_key = function ()
                            return humanFaction;
                        end,
                        faction_list = function ()
                            return {
                                item_at = function(self, i)
                                    if i == 0 then
                                        return testFaction;
                                    elseif i == 1 then
                                        return humanFaction;
                                    elseif i == 2 then
                                        return testFaction2;
                                    elseif i == 3 then
                                        return testFaction2
                                    else
                                        return nil;
                                    end
                                end,
                                num_items = function()
                                    return 3;
                                end,
                            }
                        end
                    }
                end
            }
        end,
        first_tick_callbacks = {},
        add_saving_game_callback = function() end,
        add_loading_game_callback = function() end,
        spawn_character_to_pool = function() end,
        callback = function(self, callbackFunction, delay) callbackFunction() end,
        transfer_region_to_faction = function() end,
        get_faction = function() return testFaction; end,
        get_local_faction= function() return humanFaction; end,
        lift_all_shroud = function() end,
        kill_all_armies_for_faction = function() end,
        get_region = function()
            return {
                province_name = function() return "wh_main_couronne_et_languille"; end,
                religion_proportion = function() return 0; end,
                public_order = function() return -100; end,
                owning_faction = function() return testFaction; end,
                name = function() return "region_name"; end,
                is_province_capital = function() return false; end,
                is_abandoned = function() return false; end,
                command_queue_index = function() return 10; end,
                adjacent_region_list = function()
                    return {
                        item_at = function(self, i)
                            if i == 0 then
                                return get_cm():get_region();
                            elseif i == 1 then
                                return get_cm():get_region();
                            elseif i == 2 then
                                return get_cm():get_region();
                            elseif i == 3 then
                                return get_cm():get_region();
                            else
                                return nil;
                            end
                        end,
                        num_items = function()
                            return 3;
                        end,
                    }
                end,
                is_null_interface = function() return false; end,
                garrison_residence = function() return {
                    army = function() return {
                        strength = function() return 50; end,
                    } end ,
                } end,
                settlement = function() return {
                    slot_list = function() return {
                        num_items = function () return 2; end,
                        item_at = function(index)
                            if index == 1 then
                                return slot_1;
                            else
                                return slot_2;
                            end
                        end
                    }
                    end,
                }
                end
            }
        end,
        set_character_immortality = function() end,
        get_campaign_name = function() return "main_warhammer"; end,
        apply_effect_bundle_to_characters_force = function() end,
        kill_character = function() end,
        trigger_incident = function() end,
        trigger_dilemma = function() end,
        trigger_mission = function() end,
        create_force_with_general = function(self, factionKey, forceString, regionKey, spawnX, spawnY, generalType, agentSubTypeKey, clanNameKey, dummyName1, foreNameKey, dummayName2, umm, callbackFunction)
            callbackFunction(123);
        end,
        force_add_trait = function() end,
        force_remove_trait = function() end,
        get_character_by_cqi = function() return testCharacter; end,
        char_is_mobile_general_with_army = function() return true; end,
        restrict_units_for_faction = function() end,
        save_named_value = function(self, saveKey, data, context)
            mockSaveData[saveKey] = data;
        end,
        load_named_value = function(self, saveKey, datastructure, context)
            if mockSaveData[saveKey] == nil then
                return nil;
            end
            return mockSaveData[saveKey];
        end,
        remove_effect_bundle = function() end,
        apply_effect_bundle = function() end,
        char_is_agent = function() return false end,
        steal_user_input = function() end,
        disable_rebellions_worldwide = function() end,
        find_valid_spawn_location_for_character_from_settlement = function() return 1, 1; end,
        force_diplomacy = function() end,
        apply_effect_bundle_to_force = function() end,
        force_declare_war = function() end,
        cai_enable_movement_for_character = function() end,
        cai_disable_movement_for_character = function() end,
        add_unit_model_overrides = function() end,
        force_character_force_into_stance = function() end,
        attack_region = function() end,
        char_lookup_str = function() end,
        suppress_all_event_feed_messages = function() end,
        grant_unit_to_character = function() end,
        show_message_event = function() end,
        show_message_event_located = function() end,
        trigger_incident_with_targets = function() end,
        remove_skill_point = function() end,
        force_add_skill = function() return true; end,
        apply_effect_bundle_to_character = function() end,
        remove_effect_bundle_from_character = function() end,
        remove_effect_bundle_from_characters_force = function() end,
        pending_battle_cache_human_is_involved = function() return true; end,
        pending_battle_cache_num_defenders = function() return 2; end,
        pending_battle_cache_num_attackers = function() return 2; end,
        pending_battle_cache_get_defender = function(self, index)
            if index == 1 then
                return testCharacter:command_queue_index(), testCharacter:military_force():command_queue_index(), testCharacter:faction():name();
            else
                return testCharacter:command_queue_index(), testCharacter:military_force():command_queue_index(), testCharacter:faction():name();
            end
        end,
        pending_battle_cache_get_attacker = function(self, index)
            if index == 1 then
                return testCharacter:command_queue_index(), testCharacter:military_force():command_queue_index(), testCharacter:faction():name();
            else
                return testCharacter:command_queue_index(), testCharacter:military_force():command_queue_index(), testCharacter:faction():name();
            end
        end,
        create_new_custom_effect_bundle = function()
            return {
                set_duration = function() end,
                add_effect = function() end,
            };
        end,
        apply_custom_effect_bundle_to_region = function() end,
        apply_custom_effect_bundle_to_character = function() end,
        random_number = function(self, limit, start)
            return math.random(start, limit);
        end,
    };
end

cm = get_cm();
mock_dy_subtype_ui_component = {
    Id = function() return "wh2_dlc10_hef_inf_shadow_walkers_0_recruitable" end,
    ChildCount = function() return 2; end,
    Find = function() return mock_unit_ui_component; end,
    SetVisible = function() end,
    MoveTo = function() end,
    SetStateText = function() end,
    SetInteractive = function() end,
    Visible = function() return true; end,
    Position = function() return 0, 1 end,
    Bounds = function() return 0, 1 end,
    Width = function() return 1; end,
    Resize = function() return; end,
    SetCanResizeWidth = function() return; end,
    SimulateMouseOn = function() return; end,
    GetStateText = function() return "Legendary Lord"; end,
    --GetStateText = function() return "Unlocks recruitment of:"; end,
    SetCanResizeHeight = function() end;
    SetCanResizeWidth = function() end;
}

mock_dy_name_ui_component = {
    Id = function() return "wh_main_vmp_inf_zombie_mercenary" end,
    --Id = function() return "building_info_recruitment_effects" end,
    ChildCount = function() return 2; end,
    Find = function() return mock_max_unit_ui_component; end,
    SetVisible = function() end,
    MoveTo = function() end,
    SetStateText = function() end,
    SetInteractive = function() end,
    Visible = function() return true; end,
    Position = function() return 0, 1 end,
    Bounds = function() return 0, 1 end,
    Width = function() return 1; end,
    Resize = function() return; end,
    SetCanResizeWidth = function() return; end,
    SimulateMouseOn = function() return; end,
    GetStateText = function() return "Legendary Lord Legendary Lord"; end,
    SetCanResizeHeight = function() end;
    SetCanResizeWidth = function() end;
}

mock_unit_ui_list_component = {
    Id = function() return "mock_list" end,
    ChildCount = function() return 2; end,
    Find = function(self, param1, param2)
        if param2 == "dy_subtype" then
            return mock_dy_subtype_ui_component;
        elseif param2 == "dy_name" then
            return mock_dy_name_ui_component;
        end
        return mock_max_unit_ui_component;
    end,
    SetVisible = function() end,
    MoveTo = function() end,
    SetStateText = function() end,
    SetInteractive = function() end,
    Visible = function() return true; end,
    Position = function() return 0, 1 end,
    Bounds = function() return 0, 1 end,
    Width = function() return 1; end,
    Resize = function() return; end,
    SetCanResizeWidth = function() return; end,
    SimulateMouseOn = function() return; end,
    GetStateText = function() return "Legendary Lord"; end,
    --GetStateText = function() return "Unlocks recruitment of:"; end,
    SetCanResizeHeight = function() end;
    SetCanResizeWidth = function() end;
}

find_uicomponent = function(self, param1)
    if param1 == "dy_subtype" then
        return mock_dy_subtype_ui_component;
    elseif param1 == "dy_name" then
        return mock_dy_name_ui_component;
    end
    return mock_unit_ui_list_component;
end

UIComponent = function(mock_ui_find) return mock_ui_find; end

core = {
    remove_listener = function() end,
    add_listener = function (self, key, eventKey, condition, callback)
        mock_listeners.listeners[key] = {
            Condition = condition,
            Callback = callback,
        }
    end,
    get_ui_root = function() end,
    get_screen_resolution = function() return 0, 1 end;
    is_mod_loaded = function() return true; end,
}

random_army_manager = {
    new_force = function() end,
    add_mandatory_unit = function() end,
    add_unit = function() end,
    generate_force = function() return ""; end,
}

invasion_manager = {
    new_invasion = function()
        return {
            set_target = function() end,
            apply_effect = function() end,
            add_character_experience = function() end,
            start_invasion = function() end,
            assign_general = function() end,
            create_general = function() end,
        }
    end,
    get_invasion = function() return {
        release = function() return end,
    }; end,
}
out = function(text)
  print(text);
end

require 'script/campaign/mod/a_wwl_core_resource_loader'
require 'script/campaign/mod/z_wwl_slann_lores'
require 'script/campaign/mod/z_wwl_cataph_resource_loader'
require 'script/campaign/mod/z_wwl_deco_resource_loader'
require 'script/campaign/mod/z_wwl_kislev_resource_loader'
require 'script/campaign/mod/z_wwl_mixu_resource_loader'
require 'script/campaign/mod/z_wwl_wez_speshul_resource_loader'
require 'script/campaign/mod/z_wwl_xoudad'
require 'script/campaign/mod/z_wondrous_wizard_levels'

math.randomseed(os.time())

-- This is used in game by Warhammer but we have it hear so it won't throw errors when running
-- in ZeroBrane IDE
z_wondrous_wizard_levels();

local WWL = _G.WWL;
local MockContext_WWL_FactionTurnStart = {
    Key = "WWL_FactionTurnStart",
    Context = {
        faction = function() return humanFaction; end,
    },
}
mock_listeners:trigger_listener(MockContext_WWL_FactionTurnStart);

local MockContext_WWL_PendingBattle = {
    Key = "WWL_PendingBattle",
    Context = {
        faction = function() return humanFaction end,
    },
}
mock_listeners:trigger_listener(MockContext_WWL_PendingBattle);

local MockContext_WWL_CharacterSkillPointAllocated = {
    Key = "WWL_CharacterSkillPointAllocated",
    Context = {
        character = function() return testCharacter end,
        skill_point_spent_on = function() return "wh_dlc05_skill_magic_shadow_penumbral_pendulum"; end,
    },
}
mock_listeners:trigger_listener(MockContext_WWL_CharacterSkillPointAllocated);


MockContext_WWL_CharacterSkillPointAllocated = {
    Key = "WWL_CharacterSkillPointAllocated",
    Context = {
        character = function() return testCharacter end,
        skill_point_spent_on = function() return "wh_main_skill_vmp_lord_unique_mannfred_loremaster_lore_of_death"; end,
    },
}
mock_listeners:trigger_listener(MockContext_WWL_CharacterSkillPointAllocated);

local WWL_CharacterRecruitmentButtons = {
    Key = "WWL_CharacterRecruitmentButtons",
    Context = {
        string = "button_create_army",
    },
}
mock_listeners:trigger_listener(WWL_CharacterRecruitmentButtons);

local WWL_CharacterSelected = {
    Key = "WWL_CharacterSelected",
    Context = {
        character = function() return testCharacter; end,
    },
}
mock_listeners:trigger_listener(WWL_CharacterSelected);
WWL = {};
z_wondrous_wizard_levels();
turn_number = 2;
mock_listeners:trigger_listener(MockContext_WWL_FactionTurnStart);
mock_listeners:trigger_listener(MockContext_WWL_CharacterSkillPointAllocated);
mock_listeners:trigger_listener(MockContext_WWL_CharacterSkillPointAllocated);
mock_listeners:trigger_listener(MockContext_WWL_PendingBattle);
turn_number = 3;
mock_listeners:trigger_listener(MockContext_WWL_FactionTurnStart);
mock_listeners:trigger_listener(MockContext_WWL_CharacterSkillPointAllocated);
mock_listeners:trigger_listener(MockContext_WWL_PendingBattle);