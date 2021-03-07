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
                and not character:is_wounded() then
                    --wwl.Logger:Log("Checking character type: "..character:character_subtype_key());
                    local isSupportedCharacter = wwl:IsSupportedCharacter(character);
                    if isSupportedCharacter == true then
                        wwl.Logger:Log("Generating spells for character: "..character:command_queue_index().." subtype: "..character:character_subtype_key());
                        wwl:SetSpellsForCharacter(character);
                    end
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
            return cm:pending_battle_cache_human_is_involved();
        end,
        function(context)
            local num_defenders = cm:pending_battle_cache_num_defenders();
            local defenders = {};
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
                            end
                        end
                    end
                end
            end
            wwl.Logger:Log_Finished();

            local num_attackers = cm:pending_battle_cache_num_attackers();
            local attackers = {};
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
                            end
                        end
                    end
                end
            end
            wwl.Logger:Log_Finished();
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
                local localisedSubtypeName = effect.get_localised_string("agent_subtypes_onscreen_name_override_"..characterSubtype);
                WWL_UICache[localisedSubtypeName] = nil;
            end
            wwl.Logger:Log_Finished();
        end,
        true
    );

    wwl.Logger:Log("WWL_CharacterRecruitmentButtons");
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
            or context.string == "wizard"
            -- This exception is for Cataph's Dragon Mage)
            or (context.string == "champion" and wwl.HumanFaction:subculture() == "wh2_main_sc_hef_high_elves")
            or context.string == "button_cycle_left"
            or context.string == "button_cycle_right"
            or wwl:GetDefaultWizardDataForCharacterSubtype(context.string, wwl.HumanFaction:subculture());
        end,
        function(context)
            local stringContext = context.string;
            cm:callback(function()
                if lockUISetup == false then
                    lockUISetup = true;
                    wwl.Logger:Log("WWL_CharacterRecruitmentButtons: "..stringContext);
                    local generalsList = find_uicomponent(core:get_ui_root(), "character_panel", "general_selection_panel", "character_list_parent", "character_list", "listview", "list_clip", "list_box");
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
                        local generalsList = find_uicomponent(core:get_ui_root(), "character_panel", "general_selection_panel", "character_list_parent", "character_list", "listview", "list_clip", "list_box");
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
            wwl.Logger:Log_Finished();
        end,
        true
    );
end

function SetWizardLevelUI(wwl, pathToGenerals, buttonContext)
    wwl.Logger:Log("SetWizardLevelUI");
    if not pathToGenerals then
        wwl.Logger:Log("Can't find pathToGenerals");
        return;
    end
    local numGenerals = pathToGenerals:ChildCount() - 1;
    if numGenerals >= 0 then
        local playerSubculture = wwl.HumanFaction:subculture();
        for i = 0, numGenerals do
            wwl.Logger:Log("Checking general: "..i);
            local generalPanel = UIComponent(pathToGenerals:Find(i));
            local subtypeComponent = find_uicomponent(generalPanel, "dy_subtype");
            local subtypeComponentText = subtypeComponent:GetStateText();
            wwl.Logger:Log("General subtype is: "..subtypeComponentText);
            -- If the text is Legendary Lord then we need to try and find the unique character
            if subtypeComponentText == "Legendary Lord" then
                local nameComponent = find_uicomponent(generalPanel, "dy_name");
                local nameText = nameComponent:GetStateText();
                if WWL_UICache[subtypeComponentText] == nil then
                    -- Initiliase cached data structure
                    WWL_UICache[subtypeComponentText] = {
                        TrackedWizardNames = {},
                    };
                end
                if WWL_UICache[subtypeComponentText] == nil or WWL_UICache[subtypeComponentText].TrackedWizardNames[nameText] == nil then
                    wwl.Logger:Log("Checking for Legendary Lord by name: "..nameText);
                    local characterWizardLevel = wwl:GetCharacterWizardLevelWithName(nameText, wwl.HumanFaction, true);
                    -- If we can't find a Legendary Character by their name then they aren't a wizard or aren't supported
                    if characterWizardLevel == nil then
                        wwl.Logger:Log("Could not find supported LL");
                        WWL_UICache[subtypeComponentText].TrackedWizardNames[nameText] = 0;
                    else
                        wwl.Logger:Log("Found LL...using detected value: "..characterWizardLevel.DefaultWizardLevel);
                        subtypeComponent:SetStateText(subtypeComponentText.." - Wizard level "..characterWizardLevel.DefaultWizardLevel);
                        WWL_UICache[subtypeComponentText].TrackedWizardNames[nameText] = characterWizardLevel.DefaultWizardLevel;
                        subtypeComponent:SetVisible(true);
                    end
                elseif WWL_UICache[subtypeComponentText].TrackedWizardNames[nameText] > 0 then
                    subtypeComponent:SetStateText(subtypeComponentText.." - Wizard level "..WWL_UICache[subtypeComponentText].TrackedWizardNames[nameText]);
                end
            elseif WWL_UICache[subtypeComponentText] == nil then
                if subtypeComponentText == "dy_subtype" and buttonContext ~= nil then
                    subtypeComponentText = effect.get_localised_string("agent_subtypes_onscreen_name_override_"..buttonContext);
                end
                local foundWizard = false;
                wwl.Logger:Log("Checking for subculture supported subtypes");
                local supportedSubtypes = wwl:GetSuppportedSubtypesForSubculture(playerSubculture);
                wwl.Logger:Log("Subculture is: "..playerSubculture);
                if supportedSubtypes ~= nil then
                    for subtypeKey, subTypeData in pairs(supportedSubtypes) do
                        wwl.Logger:Log("Checking subtype: "..subtypeKey);
                        local localisedSubtypeName = effect.get_localised_string("agent_subtypes_onscreen_name_override_"..subtypeKey);
                        wwl.Logger:Log("localisedSubtypeName is: "..localisedSubtypeName);
                        if localisedSubtypeName == subtypeComponentText then
                            wwl.Logger:Log("Found match!");
                            -- Set cached data
                            WWL_UICache[subtypeComponentText] = {
                                DefaultWizardLevel = subTypeData.DefaultWizardLevel,
                                TrackedWizardNames = {},
                                IsSupportedWizard = true,
                            };
                            local nameComponent = find_uicomponent(generalPanel, "dy_name");
                            local nameText = nameComponent:GetStateText();
                            local characterWizardLevel = wwl:GetCharacterWizardLevelWithName(nameText, wwl.HumanFaction, false);
                            -- If we can't find a character with any active data, then we probably haven't recruited them yet
                            if characterWizardLevel == nil then
                                wwl.Logger:Log("Character is not active. Using default values: "..subTypeData.DefaultWizardLevel);
                                subtypeComponent:SetStateText(subtypeComponentText.." - Wizard level "..subTypeData.DefaultWizardLevel);
                                WWL_UICache[subtypeComponentText].TrackedWizardNames[nameText] = subTypeData.DefaultWizardLevel;
                            else
                                wwl.Logger:Log("Character is active. Using value: "..characterWizardLevel);
                                subtypeComponent:SetStateText(subtypeComponentText.." - Wizard level "..characterWizardLevel);
                                WWL_UICache[subtypeComponentText].TrackedWizardNames[nameText] = characterWizardLevel;
                            end
                            subtypeComponent:SetVisible(true);
                            foundWizard = true;
                            break;
                        end
                    end
                end
                -- If we haven't found a subtype match, then the character probably isn't a wizard
                -- (Or they are from another mod and aren't supported)
                if foundWizard == false then
                    WWL_UICache[subtypeComponentText] = {
                        DefaultWizardLevel = 0,
                        TrackedWizardNames = {},
                        IsSupportedWizard = false,
                    };
                end
            elseif WWL_UICache[subtypeComponentText].IsSupportedWizard == true then
                wwl.Logger:Log("Using cached match!");
                local nameComponent = find_uicomponent(generalPanel, "dy_name");
                local nameText = nameComponent:GetStateText();
                if WWL_UICache[subtypeComponentText].TrackedWizardNames[nameText] == nil then
                    wwl.Logger:Log("Wizard is not cached by name");
                    local characterWizardLevel = wwl:GetCharacterWizardLevelWithName(nameText, wwl.HumanFaction, false);
                    -- If we can't find a character with any active data, then we probably haven't recruited them yet
                    if characterWizardLevel == nil then
                        local defaultWizardLevel = WWL_UICache[subtypeComponentText].DefaultWizardLevel;
                        subtypeComponent:SetStateText(subtypeComponentText.." - Wizard level "..defaultWizardLevel);
                        WWL_UICache[subtypeComponentText].TrackedWizardNames[nameText] = defaultWizardLevel;
                    else
                        subtypeComponent:SetStateText(subtypeComponentText.." - Wizard level "..characterWizardLevel);
                        WWL_UICache[subtypeComponentText].TrackedWizardNames[nameText] = characterWizardLevel;
                    end
                else
                    wwl.Logger:Log("Found wizard cache by name");
                    subtypeComponent:SetStateText(subtypeComponentText.." - Wizard level "..WWL_UICache[subtypeComponentText].TrackedWizardNames[nameText]);
                end
                subtypeComponent:SetVisible(true);
            else
                wwl.Logger:Log("Character is unsupported");
            end
            wwl.Logger:Log_Finished();
        end
    else
        wwl.Logger:Log("No generals found");
    end
    wwl.Logger:Log_Finished();
end