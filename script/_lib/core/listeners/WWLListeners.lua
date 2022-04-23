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
            return wwl:IsExcludedFaction(faction) == false;
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
                        wwl.Logger:Log("Generating spells for character: "..character:command_queue_index().." subtype: "..character:character_subtype_key());
                        wwl:SetSpellsForCharacter(character);
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
            return isSupportedCharacter;
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
                                    wwl.Logger:Log("Found supported subtype: "..characterSubtype.." with cqi: "..characterCqi);
                                    wwl:SetSpellsForCharacter(character);
                                    local characterSubculture = character:faction():subculture();
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
                                    end
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
                                    wwl.Logger:Log("Found supported subtype: "..characterSubtype.." with cqi: "..characterCqi);
                                    wwl:SetSpellsForCharacter(character);
                                    local characterSubculture = character:faction():subculture();
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
                                        maxAttackerLevel = wizardLevel;
                                    end
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
            local isSupportedCharacter = wwl:IsSupportedCharacter(character);
            return isSupportedCharacter and wwl:IsValidCharacterSkillKey(context:skill_point_spent_on());
        end,
        function(context)
            local characterSkillKey = context:skill_point_spent_on();
            wwl.Logger:Log("Skill allocated: "..characterSkillKey);
            local character = context:character();
            local characterSubtype = character:character_subtype_key();
            wwl.Logger:Log("Character subtype: "..characterSubtype.." cqi: "..character:command_queue_index());
            wwl:SetSpellsForCharacter(character, true);
            -- Clear cache for that subtype, this will be refreshed the next time any of the general lists are opened
            local faction = character:faction();
            if WWL_UICache ~= nil and faction:name() == wwl.HumanFaction:name() then
                local localisedSubtypeName = common.get_localised_string("agent_subtypes_onscreen_name_override_"..characterSubtype);
                WWL_UICache[localisedSubtypeName] = nil;
            end
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
        local playerFaction = wwl.HumanFaction;
        wwl.Logger:Log("Checking for subculture supported subtypes");
        local supportedSubtypes = wwl:GetSuppportedSubtypesForFaction(playerFaction);
        if supportedSubtypes == nil then
            wwl.Logger:Log("No supported subtypes found");
            return;
        end
        wwl.Logger:Log("Got player subculture: "..playerSubculture);
        local wizardLevelUIText = common.get_localised_string("wwl_wizard_level_ui");
        --wwl.Logger:Log("Got loc");
        if playerSubculture == "wh_main_sc_dwf_dwarfs" then
            wizardLevelUIText = common.get_localised_string("wwl_rune_level_ui");
        end
        -- Note: We deliberately do not check the visibility of the component because we can cache all the updates up front.
        -- This saves us from having to setup extra data when determining if we've selected a UI element where the general
        -- list is visible
        for i = 0, numGenerals do
            wwl.Logger:Log("Checking general: "..i);
            local generalPanel = UIComponent(pathToGenerals:Find(i));
            local subtypeComponent = find_uicomponent(generalPanel, "info_holder", "details_holder", "dy_subtype");
            local subtypeComponentText = subtypeComponent:GetStateText();
            wwl.Logger:Log("General subtype is: "..subtypeComponentText);
            -- If the text is Legendary Lord then we need to try and find the unique character
            if subtypeComponentText == "Legendary Lord" then
                local nameComponent = find_uicomponent(generalPanel, "info_holder", "details_holder", "dy_name");
                local nameText = nameComponent:GetStateText();
                if WWL_UICache[subtypeComponentText] == nil then
                    -- Initiliase cached data structure
                    WWL_UICache[subtypeComponentText] = {
                        TrackedWizardNames = {},
                    };
                end
                if WWL_UICache[subtypeComponentText] == nil or WWL_UICache[subtypeComponentText].TrackedWizardNames[nameText] == nil then
                    wwl.Logger:Log("Checking for Legendary Lord by name: "..nameText);
                    local characterWizardLevelUIData = wwl:GetCharacterWizardLevelUIDataWithName(nameText, wwl.HumanFaction, true);
                    -- If we can't find a Legendary Character by their name then they aren't a wizard or aren't supported
                    if characterWizardLevelUIData == nil then
                        wwl.Logger:Log("Could not find supported LL");
                        WWL_UICache[subtypeComponentText].TrackedWizardNames[nameText] = {
                            WizardLevel = nil,
                            ImagePath = nil,
                        };
                    else
                        wwl.Logger:Log("Found LL...using detected value: "..characterWizardLevelUIData.WizardLevel);
                        local wizardLevelComponent = InitialiseClonedRankComponent(wwl, generalPanel, characterWizardLevelUIData.ImagePath);
                        SetTextForWizardLevelComponent(wizardLevelComponent, wizardLevelUIText, characterWizardLevelUIData.WizardLevel);
                        WWL_UICache[subtypeComponentText].TrackedWizardNames[nameText] = characterWizardLevelUIData;
                    end
                elseif WWL_UICache[subtypeComponentText].TrackedWizardNames[nameText].WizardLevel ~= nil then
                    local characterWizardLevelUIData = WWL_UICache[subtypeComponentText].TrackedWizardNames[nameText];
                    local wizardLevelComponent = InitialiseClonedRankComponent(wwl, generalPanel, characterWizardLevelUIData.ImagePath);
                    SetTextForWizardLevelComponent(wizardLevelComponent, wizardLevelUIText, characterWizardLevelUIData.WizardLevel);
                end
            elseif WWL_UICache[subtypeComponentText] == nil then
                if subtypeComponentText == "dy_subtype" and buttonContext ~= nil then
                    subtypeComponentText = common.get_localised_string("agent_subtypes_onscreen_name_override_"..buttonContext);
                end
                local foundWizard = false;
                for subtypeKey, subTypeData in pairs(supportedSubtypes) do
                    --wwl.Logger:Log("Checking subtype: "..subtypeKey);
                    local localisedSubtypeName = common.get_localised_string("agent_subtypes_onscreen_name_override_"..subtypeKey);
                    --wwl.Logger:Log("localisedSubtypeName is: "..localisedSubtypeName);
                    if localisedSubtypeName == subtypeComponentText then
                        wwl.Logger:Log("Found match: ".. localisedSubtypeName);
                        -- Set cached data
                        local imagePath = wwl:GetImagePathForSubtype(subtypeKey);
                        local fullImagePath = wwl.Skin..imagePath;
                        WWL_UICache[subtypeComponentText] = {
                            DefaultWizardLevel = subTypeData.DefaultWizardLevel,
                            TrackedWizardNames = {},
                            IsSupportedWizard = true,
                            IconImage = fullImagePath,
                        };
                        local nameComponent = find_uicomponent(generalPanel, "info_holder", "details_holder", "dy_name");
                        local nameText = nameComponent:GetStateText();
                        wwl.Logger:Log("Looking for: "..nameText);
                        local characterWizardLevelUIData = wwl:GetCharacterWizardLevelUIDataWithName(nameText, wwl.HumanFaction, false);
                        local wizardLevelComponent = InitialiseClonedRankComponent(wwl, generalPanel, fullImagePath);
                        -- If we can't find a character with any active data, then we probably haven't recruited them yet
                        if characterWizardLevelUIData == nil then
                            wwl.Logger:Log("Character is not active. Using default values: "..subTypeData.DefaultWizardLevel);
                            SetTextForWizardLevelComponent(wizardLevelComponent, wizardLevelUIText, subTypeData.DefaultWizardLevel);
                            WWL_UICache[subtypeComponentText].TrackedWizardNames[nameText] = {
                                WizardLevel = subTypeData.DefaultWizardLevel,
                                ImagePath = fullImagePath,
                            };
                        else
                            wwl.Logger:Log("Character is active. Using value: "..characterWizardLevelUIData.WizardLevel);
                            SetTextForWizardLevelComponent(wizardLevelComponent, wizardLevelUIText, characterWizardLevelUIData.WizardLevel);
                            WWL_UICache[subtypeComponentText].TrackedWizardNames[nameText] = characterWizardLevelUIData;
                        end

                        foundWizard = true;
                        break;
                    end
                end
                -- If we haven't found a subtype match, then the character probably isn't a wizard
                -- (Or they are from another mod and aren't supported)
                if foundWizard == false then
                    wwl.Logger:Log("Character not found");
                    WWL_UICache[subtypeComponentText] = {
                        DefaultWizardLevel = 0,
                        TrackedWizardNames = {},
                        IsSupportedWizard = false,
                    };
                    subtypeComponent:SetVisible(true);
                end
            elseif WWL_UICache[subtypeComponentText].IsSupportedWizard == true then
                wwl.Logger:Log("Using cached match!");
                local nameComponent = find_uicomponent(generalPanel, "info_holder", "details_holder", "dy_name");
                local nameText = nameComponent:GetStateText();
                local wizardLevelComponent = InitialiseClonedRankComponent(wwl, generalPanel, WWL_UICache[subtypeComponentText].IconImage);

                local characterWizardLevelUIData = wwl:GetCharacterWizardLevelUIDataWithName(nameText, wwl.HumanFaction, false);
                if WWL_UICache[subtypeComponentText].TrackedWizardNames[nameText] == nil then
                    wwl.Logger:Log("Wizard is not cached by name");
                    -- If we can't find a character with any active data, then we probably haven't recruited them yet
                    if characterWizardLevelUIData == nil then
                        wwl.Logger:Log("Not recruited");
                        local defaultWizardLevel = WWL_UICache[subtypeComponentText].DefaultWizardLevel;
                        SetTextForWizardLevelComponent(wizardLevelComponent, wizardLevelUIText, defaultWizardLevel);
                        WWL_UICache[subtypeComponentText].TrackedWizardNames[nameText] = {
                            WizardLevel = defaultWizardLevel,
                            ImagePath = WWL_UICache[subtypeComponentText].IconImage,
                        };
                    else
                        wwl.Logger:Log("Using recruited data");
                        SetTextForWizardLevelComponent(wizardLevelComponent, wizardLevelUIText, characterWizardLevelUIData.WizardLevel);
                        WWL_UICache[subtypeComponentText].TrackedWizardNames[nameText] = characterWizardLevelUIData;
                    end
                else
                    wwl.Logger:Log("Found wizard cache by name");
                    local cachedWizard = WWL_UICache[subtypeComponentText].TrackedWizardNames[nameText];
                    SetTextForWizardLevelComponent(wizardLevelComponent, wizardLevelUIText, cachedWizard.WizardLevel);
                end
            else
                wwl.Logger:Log("Character is unsupported");
                -- We always show the subtype label.
                -- No real reason, mostly for consistency.
                subtypeComponent:SetVisible(true);
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
    local existingRank = find_uicomponent(generalPanel, "info_holder", "wizard_level");
    if not existingRank then
        --wwl.Logger:Log("Cloning Component");
        local rankComponent = find_uicomponent(generalPanel, "info_holder", "rank");
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
            -- We need to adjust the icon to ensure it is positioned and scaled
            -- apropriately
            local scale = 0.75;
            local width, height = wizardLevelComponent:Dimensions();
            local xPos, yPos = rankComponent:Position();
            local new_xPos = width * ((1 - scale) / 2);
            local new_yPos = height * ((1 - scale) / 2);
            local base_xPos = 2;
            local base_yPos = rankComponent:Height() - 10;
            wizardLevelComponent:SetDockOffset(new_xPos, new_yPos - base_yPos);
            -- Reize the state image and keep the aspect ratio
            local img_w, img_h = wizardLevelComponent:GetCurrentStateImageDimensions(0);
            local new_width = width * scale;
            local new_height = new_width * img_h / img_w;
            wizardLevelComponent:ResizeCurrentStateImage(0, new_width, new_height);
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