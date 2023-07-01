local WWL_UICache = {};
local find_uicomponent = nil;
local UIComponent = nil;

function WWL_SetupPostUIListeners(wwl, core, find_uicomponent_function, uicomponent_function)
    find_uicomponent = find_uicomponent_function;
    UIComponent = uicomponent_function;
    if not core then
        wwl.Logger:Log("ERROR: Core is missing");
        return;
    end

    -- Daemon Prince
    local god_dedication_threshold = 3;
    -- Overwrite vanilla listeners - Doesn't work
    --[[core:remove_listener("daemon_prince_tint_listener");
    core:add_listener(
		"daemon_prince_tint_listener",
		"CharacterArmoryItemEquipped",
		function(context)
			return context:character():faction():name() == "wh3_main_dae_daemon_prince";
		end,
		function(context)
		
			--NOTE: If updating any of below logic, please tell UI team to update logic in SETUP_UNIT_CUSTOM_INFO::calculate_character_tint_from_variant_list
			-- Ideally we would find a way to share up this essentially duplicated logic...
			local character = context:character();
            local armory = character:family_member():armory();

            local most_equipped_of_category = 0;
            local category_equipped = "undivided";

            local daemon_prince_ascension_category = cm:get_saved_value("wwl_daemon_prince_ascension_category");
            if daemon_prince_ascension_category == nil then
                local categories = {"khorne", "nurgle", "slaanesh", "tzeentch"};
                for i = 1, #categories do
                    local number_of_equipped_items = armory:number_of_equipped_items_of_ui_type(categories[i]);
                    if number_of_equipped_items > most_equipped_of_category then
                        category_equipped = categories[i];
                        most_equipped_of_category = number_of_equipped_items;
                    end;
                end;
            elseif daemon_prince_ascension_category ~= "undivided" then
                category_equipped = daemon_prince_ascension_category;
                local number_of_equipped_items = armory:number_of_equipped_items_of_ui_type(category_equipped);
                most_equipped_of_category = number_of_equipped_items;
            end
			
            if category_equipped == "undivided" then
                if most_equipped_of_category > god_dedication_threshold then
                    local tweaker_daemon = common.tweaker_value("daemon_prince_max_equipment_can_equip") or "9";
                    local max_number_of_daemon_slots = tonumber(tweaker_daemon);
                    
                    local colour_amount = 0;
                    -- Colours get more intense after ascension
                    if daemon_prince_ascension_category == nil then
                        colour_amount = math.round(255 / max_number_of_daemon_slots * (most_equipped_of_category - god_dedication_threshold));
                    else
                        colour_amount = math.round(255 / max_number_of_daemon_slots * most_equipped_of_category);
                    end

                    cm:set_tint_colour_for_character(character, "wh3_main_daemon_prince_" .. category_equipped .. "_primary", colour_amount, "wh3_main_daemon_prince_" .. category_equipped .. "_secondary", colour_amount);
                    cm:set_tint_activity_state_for_character(character, true);
                end
            else
                cm:set_tint_activity_state_for_character(character, false);
            end
		end,
		true
	);--]]

    -- New Daemon Prince listeners
    -- Blocks multiple events firing if an item set is equipped.
    -- Saves some performance
    local itemEquipLock = false;
    local ascensionRituals = {
        wh3_main_ritual_dae_ascend_khorne = "khorne",
        wh3_main_ritual_dae_ascend_nurgle = "nurgle",
        wh3_main_ritual_dae_ascend_slaanesh = "slaanesh",
        wh3_main_ritual_dae_ascend_tzeentch = "tzeentch",
        wh3_main_ritual_dae_ascend_undivided = "undivided",
    };
    core:add_listener(
		"WWL_DedicationTracker",
		"RitualCompletedEvent",
		true,
		function(context)
			local faction = context:performing_faction();
			local faction_name = faction:name();
			
			if faction:is_human() and faction_name == "wh3_main_dae_daemon_prince" then
                local ritualKey = context:ritual():ritual_key();
				if ascensionRituals[ritualKey] ~= nil then
                    cm:set_saved_value("wwl_daemon_prince_ascension_category", ascensionRituals[ritualKey]);
				end;
			end;
		end,
		true
	);

    core:add_listener(
		"WWL_DaemonPrinceTraitListener",
		"CharacterArmoryItemEquipped",
		function(context)
			return context:character():faction():name() == "wh3_main_dae_daemon_prince";
		end,
		function(context)
            if itemEquipLock == false then
                local character = context:character();
                local armory = character:family_member():armory();
                local char_str = "character_cqi:"..character:command_queue_index();
                itemEquipLock = true;
                cm:callback(function()
                    itemEquipLock = false;
                    local categories = {"khorne", "nurgle", "slaanesh", "tzeentch"};
                    local most_equipped_of_category = 0;
                    local category_equipped = "undivided";

                    local daemon_prince_ascension_category = cm:get_saved_value("wwl_daemon_prince_ascension_category");
                    if daemon_prince_ascension_category == nil then
                        local categories = {"khorne", "nurgle", "slaanesh", "tzeentch"};
                        for i = 1, #categories do
                            local number_of_equipped_items = armory:number_of_equipped_items_of_ui_type(categories[i]);
                            if number_of_equipped_items > most_equipped_of_category then
                                category_equipped = categories[i];
                                most_equipped_of_category = number_of_equipped_items;
                            end;
                        end;
                    else
                        wwl.Logger:Log("Daemon prince has ascended: "..daemon_prince_ascension_category);
                        category_equipped = daemon_prince_ascension_category;
                        if daemon_prince_ascension_category ~= "undivided" then
                            local number_of_equipped_items = armory:number_of_equipped_items_of_ui_type(category_equipped);
                            most_equipped_of_category = number_of_equipped_items;
                        end
                    end
        
                    local daemonPrinceWizardData = wwl:GetDefaultWizardDataForCharacterSubtype("wh3_main_dae_daemon_prince");
                    -- This returns the UI Info key of the armory item
                    local armoryItems = armory:get_all_active_variant_slot_states();
                    local numberOfSpellItems = 0;
                    if daemon_prince_ascension_category ~= nil then
                        wwl.Logger:Log("Adding ascension bonus");
                        numberOfSpellItems = numberOfSpellItems + 1;
                    end
                    for index, itemKey in pairs(armoryItems) do
                        if itemKey ~= '' then
                            wwl.Logger:Log("armory item equipped: "..itemKey);
                            if daemonPrinceWizardData.ArmoryItems[itemKey] ~= nil then
                                numberOfSpellItems = numberOfSpellItems + 1;
                            end
                        end
                    end
                    if numberOfSpellItems > 5 then
                        numberOfSpellItems = 5;
                    end
                    wwl.Logger:Log("god_dedication_threshold: "..god_dedication_threshold);
                    if daemon_prince_ascension_category == nil then
                        wwl.Logger:Log("most_equipped_of_category: "..most_equipped_of_category);
                    end
                    wwl.Logger:Log("numberOfSpellItems: "..numberOfSpellItems);
        
                    local godTraitPoints = {
                        ["wwl_trait_daemon_prince_undivided"] = character:trait_points("wwl_trait_daemon_prince_undivided") - 1,
                        ["wwl_trait_daemon_prince_"..category_equipped] = character:trait_points("wwl_trait_daemon_prince_"..category_equipped) - 1,
                    };
                    -- If the category with the most is above the dedication threshold and the existing trait doesn't have the right level
                    -- then we need to reset the traits and add the correct one
                    local removeTraits = false;
                    local traitToApply = nil;
                    -- If we've ascended then there is no threshold
                    if daemon_prince_ascension_category ~= nil
                    and godTraitPoints["wwl_trait_daemon_prince_"..daemon_prince_ascension_category] ~= numberOfSpellItems then
                        removeTraits = true;
                        traitToApply = "wwl_trait_daemon_prince_"..daemon_prince_ascension_category;
                    -- Otherwise we need to check if we meet the threshold
                    elseif most_equipped_of_category > god_dedication_threshold then
                        if godTraitPoints["wwl_trait_daemon_prince_"..category_equipped] ~= numberOfSpellItems then 
                            removeTraits = true;
                            traitToApply = "wwl_trait_daemon_prince_"..category_equipped;
                        end
                        -- Otherwise we're Undivided
                    elseif godTraitPoints["wwl_trait_daemon_prince_undivided"] ~= numberOfSpellItems then
                        removeTraits = true;
                        traitToApply = "wwl_trait_daemon_prince_undivided";
                    end

                    if removeTraits == true then
                        cm:disable_event_feed_events(true, "all", "", "");
                        for i = 1, #categories do
                            cm:force_remove_trait(char_str, "wwl_trait_daemon_prince_"..categories[i]);
                        end
                        cm:force_remove_trait(char_str, "wwl_trait_daemon_prince_undivided");
                        cm:force_remove_trait(char_str, "wwl_trait_daemon_prince_undivided_no_spells");
                        cm:callback(function() cm:disable_event_feed_events(false, "all", "", ""); end, 1);
                    end
                    if traitToApply ~= nil then
                        wwl.Logger:Log("Adding trait: "..traitToApply);
                        local traitLevel = numberOfSpellItems + 1;
                        cm:force_add_trait(char_str, traitToApply, false, traitLevel);
                        -- Applies an effect bundle which will be used to flag that we need to regenerate spells when the panel is closed
                        cm:apply_effect_bundle_to_character("wwl_regenerate_spells_hidden", character, 0);
                    end
                    wwl.Logger:Log_Finished();
                end,
                0.1);
            end


            wwl.Logger:Log_Finished();
		end,
		true
	);

    core:add_listener(
        "WWL_DaemonPrincePanelClosed",
        "PanelClosedCampaign",
        function(context)
            return context.string == "character_details_panel"
            and wwl.HumanFaction:name() == "wh3_main_dae_daemon_prince";
        end,
        function(context)
            wwl.Logger:Log("Daemon prince panel closed\n");
            local faction = cm:get_local_faction();
            local faction_leader = faction:faction_leader();
            if faction_leader:has_effect_bundle("wwl_regenerate_spells_hidden") then
                wwl.Logger:Log("Daemon prince has regenerate spells bundle");
                wwl:SetSpellsForCharacter(faction_leader, true);
                cm:remove_effect_bundle_from_character("wwl_regenerate_spells_hidden", faction_leader);
            end

            wwl.Logger:Log_Finished();
        end,
        true
    );

    -- General WWL events
    -- Log cleanup event
    core:add_listener(
        "WWL_FactionTurnEnd",
        "FactionTurnEnd",
        function(context)
            return context:faction():name() == wwl.HumanFaction:name();
        end,
        function(context)
            wwl.Logger:Log_Start();
            -- clear UI cache
            WWL_UICache = {};
        end,
        true
    );

    -- Each turn we generate spells for all existing, supported characters
    core:add_listener(
        "WWL_FactionTurnStart",
        "FactionTurnStart",
        function(context)
            local faction = context:faction();
            return faction:is_human() == true
            and wwl:IsExcludedFaction(faction) == false
            and not cm:is_new_game();
        end,
        function(context)
            local faction = context:faction();
            local factionKey = faction:name();
            wwl.Logger:Log("Generating spells for characters in faction: "..factionKey);
            local characters = faction:character_list();
            for i = 0, characters:num_items() - 1 do
                local character = characters:item_at(i);
                if character
                and not character:is_null_interface()
                and not character:is_wounded()
                and character:character_type("colonel") == false then
                    --wwl.Logger:Log("Checking character type: "..character:character_subtype_key());
                    local isSupportedCharacter = wwl:IsSupportedCharacter(character);
                    if isSupportedCharacter == true then
                        if faction:is_human() then
                            cm:callback(function()
                                wwl.Logger:Log("Generating spells for character: "..character:command_queue_index().." subtype: "..character:character_subtype_key());
                                wwl:SetSpellsForCharacter(character);
                                wwl.Logger:Log_Finished();
                            end,
                            1);
                        else
                            wwl.Logger:Log("Generating spells for character: "..character:command_queue_index().." subtype: "..character:character_subtype_key());
                            wwl:SetSpellsForCharacter(character);
                        end
                    end
                    --wwl:DoUnitUpgrades(character);
                end
            end

            wwl.Logger:Log_Finished();
        end,
        true
    );

    -- We check if the character we selected has generated spells this turn
    core:add_listener(
        "WWL_CharacterSelected",
        "CharacterSelected",
        function(context)
            local character = context:character();
            local isSupportedCharacter = wwl:IsSupportedCharacter(character);
            return isSupportedCharacter
            and not cm:is_new_game();
        end,
        function(context)
            local character = context:character();
            wwl.Logger:Log("Selected: "..character:character_subtype_key());
            wwl:SetSpellsForCharacter(character);
            wwl.Logger:Log_Finished();
        end,
        true
    );

    -- Before a battle we check if there are any characters that need to regenerate spells
    core:add_listener(
        "WWL_PendingBattle",
        "PendingBattle",
        function(context)
            return true;
        end,
        function(context)
            -- When used on the trigger for this event, this does not fire correctly
            local ishumanInvolved = cm:pending_battle_cache_human_is_involved();
            if ishumanInvolved == true then
                wwl.Logger:Log("In pending battle cache");
                local num_defenders = cm:pending_battle_cache_num_defenders();
                local defenders = {};
                local maxDefenderLevel = 0;
                for i = 1, num_defenders do
                    local defender_cqi, defender_force_cqi, defender_faction_name = cm:pending_battle_cache_get_defender(i);
                    wwl.Logger:Log("Defender cqi: "..defender_cqi.." Defender faction name "..defender_faction_name);
                    if defender_faction_name ~= "rebels" then
                        local militaryForce = cm:model():military_force_for_command_queue_index(tonumber(defender_force_cqi));
                        if not militaryForce:is_null_interface() then
                            local charactersInMilitaryForce = militaryForce:character_list();
                            for i = 0, charactersInMilitaryForce:num_items() - 1 do
                                local character = charactersInMilitaryForce:item_at(i);
                                if wwl:IsSupportedCharacter(character) == true then
                                    local characterCqi = character:command_queue_index();
                                    local characterSubtype = character:character_subtype_key();
                                    cm:callback(function()
                                        wwl.Logger:Log("Found supported subtype: "..characterSubtype.." with cqi: "..characterCqi);
                                        wwl:SetSpellsForCharacter(character);
                                        wwl.Logger:Log_Finished();
                                    end,
                                    0.1);

                                    -- Disabled until I decide to do something with it later
                                    --[[local characterSubculture = character:faction():subculture();
                                    local wizardLevelPrefix = "wwl_skill_wizard_level_0";
                                    if characterSubculture == "wh_main_sc_dwf_dwarfs" then
                                        wizardLevelPrefix = "wwl_skill_rune_level_0";
                                    end
                                    local wizardLevel = 1;
                                    if character:has_skill(wizardLevelPrefix.."2") then
                                        wizardLevel = 2;
                                    elseif character:has_skill(wizardLevelPrefix.."3") then
                                        wizardLevel = 3;
                                    elseif character:has_skill(wizardLevelPrefix.."4") then
                                        wizardLevel = 4;
                                    elseif character:has_skill(wizardLevelPrefix.."5") then
                                        wizardLevel = 5;
                                    end
                                    if wizardLevel > maxDefenderLevel then
                                        maxDefenderLevel = wizardLevel;
                                    end--]]
                                end
                            end
                        end
                    end
                end
                wwl.Logger:Log_Finished();

                local num_attackers = cm:pending_battle_cache_num_attackers();
                local attackers = {};
                local maxAttackerLevel = 0;
                for i = 1, num_attackers do
                    local attacker_cqi, attacker_force_cqi, attacker_faction_name = cm:pending_battle_cache_get_attacker(i);
                    wwl.Logger:Log("Attacker cqi: "..attacker_cqi.." Attacker faction name "..attacker_faction_name);
                    if attacker_faction_name ~= "rebels" then
                        local militaryForce = cm:model():military_force_for_command_queue_index(tonumber(attacker_force_cqi));
                        if not militaryForce:is_null_interface() then
                            local charactersInMilitaryForce = militaryForce:character_list();
                            for i = 0, charactersInMilitaryForce:num_items() - 1 do
                                local character = charactersInMilitaryForce:item_at(i);
                                if wwl:IsSupportedCharacter(character) == true then
                                    local characterCqi = character:command_queue_index();
                                    local characterSubtype = character:character_subtype_key();
                                    cm:callback(function()
                                        wwl.Logger:Log("Found supported subtype: "..characterSubtype.." with cqi: "..characterCqi);
                                        wwl:SetSpellsForCharacter(character);
                                        wwl.Logger:Log_Finished();
                                    end,
                                    0.1);
                                end
                            end
                        end
                    end
                end
                local defenderDifference = maxDefenderLevel - maxAttackerLevel;
                -- Defender battle effects
                local attackerDifference = maxAttackerLevel - maxDefenderLevel;
                -- Attacker battle effects
                --[[local battle_effects = cm:create_new_custom_effect_bundle("wwl_battle_effects");
                battle_effects:set_duration(1);
                battle_effects:add_effect("wh_main_effect_military_force_winds_of_magic_depletion_mod_character", "character_to_force_own_unseen", 2 * attackerDifference);
                battle_effects:add_effect("wh_main_effect_character_stat_mod_miscast_chance", "character_to_character_own", -2 * wizardLevel);--]]
                -- wh_main_effect_military_force_winds_of_magic_depletion_mod_character_enemy
                -- wh_main_effect_military_force_winds_of_magic_depletion_mod_character_enemy
                wwl.Logger:Log_Finished();
            end
        end,
        true
    );

    -- Whenever a character allocates a skillpoint we need to check if we have to update
    -- their spell list
    core:add_listener(
        "WWL_CharacterSkillPointAllocated",
        "CharacterSkillPointAllocated",
        function(context)
            local character = context:character();
            local faction = character:faction();
            if not faction:is_human() then
                return false;
            end
            local isSupportedCharacter = wwl:IsSupportedCharacter(character);
            return isSupportedCharacter
            and wwl:IsValidCharacterSkillKey(context:skill_point_spent_on())
            and not cm:is_new_game();
        end,
        function(context)
            local characterSkillKey = context:skill_point_spent_on();
            wwl.Logger:Log("Skill allocated: "..characterSkillKey);
            local character = context:character();
            local characterSubtype = character:character_subtype_key();
            wwl.Logger:Log("Character subtype: "..characterSubtype.." cqi: "..character:command_queue_index());
            wwl:SetSpellsForCharacter(character, true);
            wwl.Logger:Log_Finished();
        end,
        true
    );

    local panelOpened = false;
    local lockUISetup = false;
    core:add_listener(
        "WWL_CharacterPanelOpened",
        "PanelOpenedCampaign",
        function(context)
            return context.string == "character_panel";
        end,
        function(context)
            wwl.Logger:Log("\nCharacter panel opened");
            panelOpened = true;
            wwl.Logger:Log_Finished();
        end,
        true
    );

    core:add_listener(
        "WWL_CharacterRecruitmentButtons",
        "ComponentLClickUp",
        function(context)
            return context.string == "button_create_army"
            or context.string == "button_agents"
            or context.string == "wizard" -- Most spellcasters
            or context.string == "engineer" -- Skaven warlock engineers
            or context.string == "champion" -- Branchwraith, Cataph's Dragon Mage
            or context.string == "runesmith" -- Runesmith's (duh), Loremaster's
            or context.string == "dignitary" -- Balefiends, Vampires
            or context.string == "spy" -- None in vanilla but included just in case
            or context.string == "button_cycle_left"
            or context.string == "button_cycle_right"
            --or wwl:GetMagicLoreData(context.string) ~= nil -- When clicking the lore buttons
            or wwl:GetDefaultWizardDataForCharacterSubtype(context.string); -- When selecting different lord types
        end,
        function(context)
            local stringContext = context.string;
            cm:callback(function()
                if lockUISetup == false then
                    lockUISetup = true;
                    wwl.Logger:Log("WWL_CharacterRecruitmentButtons: "..stringContext);
                    local generalsList = find_uicomponent(core:get_ui_root(), "character_panel", "character_panel_info_holder", "general_selection_panel", "main_holder", "character_list_parent", "character_list", "listview", "list_clip", "list_box");
                    SetWizardLevelUI(wwl, generalsList, stringContext);
                    lockUISetup = false;
                    wwl.Logger:Log_Finished();
                end
            end,
            0.1);
        end,
        true
    );

    wwl.Logger:Log("AppointGeneralOpened");
    core:add_listener(
        "WWL_AppointGeneralOpened",
        "PanelOpenedCampaign",
        function(context)
            return context.string == "appoint_new_general";
        end,
        function(context)
            local stringContext = context.string;
            cm:callback(function()
                if lockUISetup == false then
                    lockUISetup = true;
                    wwl.Logger:Log("WWL_AppointGeneralOpened: "..stringContext);
                    local generalsList = find_uicomponent(core:get_ui_root(), "panel_manager", "appoint_new_general", "event_appoint_new_general", "general_selection_panel", "character_list", "listview", "list_clip", "list_box");
                    SetWizardLevelUI(wwl, generalsList);
                    lockUISetup = false;
                    wwl.Logger:Log_Finished();
                end
            end,
            0.1);
        end,
        true
    );

    wwl.Logger:Log("ClickedReplaceButton");
    core:add_listener(
        "WWL_ClickedReplaceButton",
        "ComponentLClickUp",
        function(context)
            return context.string == "button_replace_general";
        end,
        function(context)
            local stringContext = context.string;
            cm:callback(function()
                if lockUISetup == false then
                    lockUISetup = true;
                    wwl.Logger:Log("WWL_ClickedReplaceButton: "..stringContext);
                    local generalsList = find_uicomponent(core:get_ui_root(), "character_details_panel", "general_selection_panel", "character_list", "listview", "list_clip", "list_box");
                    SetWizardLevelUI(wwl, generalsList);
                    lockUISetup = false;
                    wwl.Logger:Log_Finished();
                end
            end,
            0.1);
        end,
        true
    );

    core:add_listener(
        "WWL_SettlementSelected",
        "SettlementSelected",
        function(context)
            return true;
        end,
        function(context)
            wwl.Logger:Log("Settlement selected");
            if panelOpened == true then
                cm:callback(function(context)
                    if lockUISetup == false then
                        lockUISetup = true;
                        local generalsList = find_uicomponent(core:get_ui_root(), "character_panel", "character_panel_info_holder", "general_selection_panel", "main_holder", "character_list_parent", "character_list", "listview", "list_clip", "list_box");
                        SetWizardLevelUI(wwl, generalsList);
                        lockUISetup = false;
                        wwl.Logger:Log_Finished();
                    end
                end,
                0.2);
            end
            wwl.Logger:Log_Finished();
        end,
        true
    );

    wwl.Logger:Log("GeneralRecruitmentClosed");
    core:add_listener(
        "WWL_GeneralRecruitmentClosed",
        "PanelClosedCampaign",
        function(context)
            return context.string == "character_panel"
            or context.string == "appoint_new_general"
            or context.string == "character_details_panel";
        end,
        function(context)
            wwl.Logger:Log("Panel closed\n");
            panelOpened = false;
            -- Failsafe in case the UI logic breaks
            lockUISetup = false;
            wwl.Logger:Log_Finished();
        end,
        true
    );

    -- Manage Unit Upgrade UI
    -- Note: Disabled, idea wasn't possible
    --[[local playerSubculture = wwl.HumanFaction:subculture();
    if _G.WWLResources.UnitData[playerSubculture] ~= nil then
        core:add_listener(
            "WWL_UnitSelected",
            "UnitSelectedCampaign",
            function(context)
                return true;
            end,
            function(context)
                local unit = context:unit();
                wwl.Logger:Log("Unit Selected: "..unit:unit_key());
                local unit_effect_list = unit:get_unit_purchasable_effects();
                local hasNonSupportedEffect = false;
                for i = 1, unit_effect_list:num_items() do
                    local unit_effect = unit_effect_list:item_at(i - 1);
                    if common.get_localised_string("effect_bundles_localised_title_"..unit_effect) ~= "" then
                        wwl.Logger:Log("Has other unit upgrade effect");
                        hasNonSupportedEffect = true;
                    end
                end
                if hasNonSupportedEffect == false then
                    local upgradeButton = find_uicomponent(core:get_ui_root(), "units_panel", "main_units_panel", "button_group_unit", "button_upgrade");
                    upgradeButton:SetVisible(false);
                end
                wwl.Logger:Log_Finished();
            end,
            true
        );
    end--]]
end

function SetWizardLevelUI(wwl, pathToGenerals, buttonContext)
    wwl.Logger:Log("SetWizardLevelUI");
    if not pathToGenerals then
        wwl.Logger:Log("Can't find pathToGenerals");
        return;
    end
    local numGenerals = pathToGenerals:ChildCount() - 1;
    if numGenerals >= 0 then
        --wwl.Logger:Log("numGenerals > 0: "..numGenerals);
        local playerSubculture = wwl.HumanFaction:subculture();

        wwl.Logger:Log("Player subculture: "..playerSubculture);
        local wizardLevelUIText = common.get_localised_string("wwl_wizard_level_ui");
        if playerSubculture == "wh_main_sc_dwf_dwarfs" then
            wizardLevelUIText = common.get_localised_string("wwl_rune_level_ui");
        end
        -- Note: We deliberately do not check the visibility of the component because we can cache all the updates up front.
        -- This saves us from having to setup extra data when determining if we've selected a UI element where the general
        -- list is visible
        for i = 0, numGenerals do
            wwl.Logger:Log("Checking general: "..i);
            local generalPanel = UIComponent(pathToGenerals:Find(i));
            local generalSubtype = find_uicomponent(generalPanel, "dy_subtype");
            local contextObject = generalSubtype:GetContextObject("CcoCampaignCharacter");
            if contextObject ~= nil then
                local agentSubtypeKey = contextObject:Call("AgentSubtypeRecordContext.Key");
                wwl.Logger:Log("Subtype is: ".. agentSubtypeKey);
                local cqi = contextObject:Call("CQI");
                local character = nil;
                if cqi ~= 0 then
                    character = cm:get_character_by_cqi(cqi);
                end
                if wwl:IsSupportedSubtype(character, agentSubtypeKey) then
                    wwl.Logger:Log("Subtype is supported: ".. agentSubtypeKey);
                    -- Build default and shared cache data
                    if WWL_UICache[agentSubtypeKey] == nil then

                        local defaultWizardLevelData = wwl:GetDefaultWizardDataForCharacterSubtype(agentSubtypeKey, character);
                        local imagePath = wwl:GetImagePathForSubtype(agentSubtypeKey, defaultWizardLevelData);
                        local fullImagePath = wwl.Skin..imagePath;
                        WWL_UICache[agentSubtypeKey] = {
                            DefaultWizardLevel = defaultWizardLevelData.DefaultWizardLevel,
                            IconImage = fullImagePath,
                        };
                    end

                    local wizardLevelComponent = InitialiseClonedRankComponent(wwl, generalPanel, WWL_UICache[agentSubtypeKey].IconImage);
                    -- If we can't find a character with any active data, then we haven't recruited them yet.
                    if cqi == 0 then
                        wwl.Logger:Log("Character is not recruited");
                        local defaultWizardLevel = WWL_UICache[agentSubtypeKey].DefaultWizardLevel;
                        SetTextForWizardLevelComponent(wizardLevelComponent, wizardLevelUIText, defaultWizardLevel);
                    else
                        wwl.Logger:Log("Character has been recruited");
                        local characterWizardLevelUIData = wwl:GetCharacterWizardLevelUIData(character);
                        if characterWizardLevelUIData ~= nil then
                            SetTextForWizardLevelComponent(wizardLevelComponent, wizardLevelUIText, characterWizardLevelUIData.WizardLevel);
                        end
                    end
                end
            end
            wwl.Logger:Log_Finished();
        end
    else
        wwl.Logger:Log("No generals found");
    end
    wwl.Logger:Log_Finished();
end

function InitialiseClonedSubTypeComponent(wwl, generalPanel, subtypeComponent, textToApply)
    local existingWizardLevel = find_uicomponent(generalPanel, "info_holder", "details_holder", "dy_wizard_level");
    if not existingWizardLevel then
        --wwl.Logger:Log("Cloning Component");
        subtypeComponent:SetVisible(true);
        local wizardLevelTextComponent = UIComponent(subtypeComponent:CopyComponent("dy_wizard_level"));
        local xPos, yPos = subtypeComponent:Position();
        -- Needs a little bit of extra space to look right
        wizardLevelTextComponent:MoveTo(xPos + subtypeComponent:WidthOfTextLine(textToApply.." "), yPos);
        --wizardLevelTextComponent:RegisterTopMost();
		--wwl.Logger:Log("Priority is: "..wizardLevelTextComponent:Priority());
        --wizardLevelTextComponent:PropagatePriority(150);
        return wizardLevelTextComponent;
    end
    return existingWizardLevel;
end

function InitialiseClonedRankComponent(wwl, generalPanel, loreIconPath)
    local generalId = generalPanel:Id();
    local existingRank = nil;
    if string.match(generalId, "_bloodline") then
        existingRank = find_uicomponent(generalPanel, "wizard_level");
    else
        existingRank = find_uicomponent(generalPanel, "info_holder", "wizard_level");
    end
    if not existingRank then
        --wwl.Logger:Log("Cloning Component");
        local rankComponent = nil;
        if string.match(generalId, "_bloodline") then
            rankComponent = find_uicomponent(generalPanel, "rank");
        else
            rankComponent = find_uicomponent(generalPanel, "info_holder", "rank");
        end
		-- Clone components
        local wizardLevelComponent = UIComponent(rankComponent:CopyComponent("wizard_level"));
		local dyRankComponent = find_uicomponent(wizardLevelComponent, "dy_rank");
		local wizardLevelText = UIComponent(dyRankComponent:CopyComponent("dy_wizard_level"));
		-- Cleanup and rearrange children
		wizardLevelComponent:Divorce(wizardLevelText:Address());
		wizardLevelComponent:DestroyChildren();
		wizardLevelComponent:Adopt(wizardLevelText:Address());
		wizardLevelComponent:SetTooltipText("", true);
        wizardLevelComponent:SetImagePath(loreIconPath, 0, true);
        cm:callback(function()
            local useHorizontalPositioning = false;
            -- If we aren't looking at a WH3 faction, then we need to use different offsets for positioning the icon
            -- This is for WH3 factions and Warriors of Chaos at this stage
            -- Legacy condition
            --[[if not string.match(wwl.HumanFaction:subculture(), "wh3")
            and wwl.HumanFaction:subculture() ~= "wh_main_sc_chs_chaos" then--]]
            -- New (and only remaining condition)
            if string.match(generalId, "_bloodline") then
                useHorizontalPositioning = true;
            end
            -- We need to adjust the icon to ensure it is positioned and scaled
            -- apropriately
            local scale = 0.75;
            local width, height = wizardLevelComponent:Dimensions();
            local xPos, yPos = rankComponent:Position();
            local new_xPos = width * ((1 - scale) / 2);
            local new_yPos = height * ((1 - scale) / 2);
            local base_xPos = 2;
            local base_yPos = rankComponent:Height() - 10;
            -- When using horizontal positioning the offsets differ for the image icon and the text
            if useHorizontalPositioning == true then
                new_xPos = 40;
                if string.match(generalId, "_bloodline") then
                    new_xPos = 32;
                    new_yPos = 100;
                end
                base_yPos = 0;
                base_xPos = 0;
            end
            wizardLevelComponent:SetDockOffset(new_xPos, new_yPos - base_yPos);
            -- Reize the state image and keep the aspect ratio
            local img_w, img_h = wizardLevelComponent:GetCurrentStateImageDimensions(0);
            local new_width = width * scale;
            local new_height = new_width * img_h / img_w;
            wizardLevelComponent:ResizeCurrentStateImage(0, new_width, new_height);
            -- When using horizontal positioning the offsets differ for the image icon and the text
            if useHorizontalPositioning == true then
                new_xPos = 3;
                new_yPos = 5;
                base_xPos = 0;
                base_yPos = 0;
            end
            -- Finally adjust the position of the number so it is centred
            wizardLevelText:SetDockOffset(new_xPos - base_xPos - new_width/4, new_yPos - new_height/4 - 2);
        end,
        0.1);
        return wizardLevelComponent;
    end
	wwl.Logger:Log("Existing component");
    return existingRank;
end

function SetTextForWizardLevelComponent(wizardLevelComponent, wizardLevelUIText, wizardLevel)
    wizardLevelComponent:SetTooltipText(wizardLevelUIText..wizardLevel, true);

    local wizardLevelTextComponent = find_uicomponent(wizardLevelComponent, "dy_wizard_level");
    wizardLevelTextComponent:SetStateText(wizardLevel);
end