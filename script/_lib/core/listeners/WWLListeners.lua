function WWL_SetupPostUIListeners(wwl)
    -- Log cleanup event
    core:add_listener(
        "WWL_FactionTurnEnd",
        "FactionTurnEnd",
        function(context)
            return context:faction():name() == wwl.HumanFaction:name();
        end,
        function(context)
            wwl.Logger:Log_Start();
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
            cm:disable_event_feed_events(true, "wh_event_category_agent", "", "");
            local characters = faction:character_list();
            for i = 0, characters:num_items() - 1 do
                local character = characters:item_at(i);
                local isSupportedCharacter = wwl:IsSupportedCharacter(character);
                if isSupportedCharacter == true then
                    wwl.Logger:Log("Generating spells for character: "..character:command_queue_index().." subtype: "..character:character_subtype_key());
                    wwl:SetSpellsForCharacter(character);
                end
            end
            cm:callback(function() cm:disable_event_feed_events(false, "wh_event_category_agent","",""); end, 1);
            wwl.Logger:Log_Finished();
        end,
        true
    );

    -- Before a battle we check if there are any characters that need to regenrate spells
    core:add_listener(
        "WWL_PendingBattle",
        "PendingBattle",
        function(context)
            return true;
        end,
        function(context)
            cm:disable_event_feed_events(true, "wh_event_category_agent", "", "");
            local num_defenders = cm:pending_battle_cache_num_defenders();
            local defenders = {};
            for i = 1, num_defenders do
                local defender_cqi, defender_force_cqi, defender_faction_name = cm:pending_battle_cache_get_defender(i);
                wwl.Logger:Log("Defender cqi: "..defender_cqi.." Defender faction name "..defender_faction_name);
                local militaryForce = cm:model():military_force_for_command_queue_index(tonumber(defender_force_cqi));
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
            wwl.Logger:Log_Finished();

            local num_attackers = cm:pending_battle_cache_num_attackers();
            local attackers = {};
            for i = 1, num_attackers do
                local attacker_cqi, attacker_force_cqi, attacker_faction_name = cm:pending_battle_cache_get_attacker(i);
                wwl.Logger:Log("Attacker cqi: "..attacker_cqi.." Attacker faction name "..attacker_faction_name);
                local militaryForce = cm:model():military_force_for_command_queue_index(tonumber(attacker_force_cqi));
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
            cm:callback(function() cm:disable_event_feed_events(false, "wh_event_category_agent","",""); end, 1);
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
            wwl.Logger:Log("Unlocked skill is: "..characterSkillKey);
            local character = context:character();
            local characterSubtype = character:character_subtype_key();
            local defaultWizardData = wwl:GetDefaultWizardDataForCharacterSubtype(characterSubtype);
            local wizardData = wwl:GetWizardData(character);
            local loreData = wwl:GetMagicLoreData(defaultWizardData);
            if string.match(characterSkillKey,  "wwl_skill_wizard_level_0") then
                wwl.Logger:Log("Wizard level skill is: "..characterSkillKey);
                local unlockedWizardLevel = string.match(characterSkillKey, "wwl_skill_wizard_level_0(.*)");
                wizardData.NumberOfSpells = tonumber(unlockedWizardLevel);
            elseif defaultWizardData.IsLoremaster == true and characterSkillKey == defaultWizardData.LoremasterCharacterSkillKey then
                wwl.Logger:Log("Loremaster skill unlocked: "..characterSkillKey);
                local characterCqi = character:command_queue_index();
                local characterLookupString = "character_cqi:"..characterCqi;
                -- Remove all disable spell skills. We don't need these anymore
                for index, spellKey in pairs(wizardData.UnlockedSpells) do
                    if defaultWizardData.IsLord == true then
                        cm:remove_effect_bundle_from_characters_force(spellKey.."_disable", characterCqi);
                    else
                        cm:force_remove_trait(characterLookupString, spellKey.."_disable");
                    end
                end
            elseif wwl:IsSignatureSpell(loreData, characterSkillKey) == false
                and wwl:IsInnateSpell(loreData, characterSkillKey) == false
                and Contains(wizardData.UnlockedSpells, characterSkillKey) == false
                and (wwl:IsLevel1Spell(defaultWizardData, characterSkillKey) or wwl:IsLevel3Spell(defaultWizardData, characterSkillKey)) then
                wwl.Logger:Log("Unlocked skill is: "..characterSkillKey);
                wizardData.UnlockedSpells[#wizardData.UnlockedSpells + 1] = characterSkillKey;
            end
            wwl.Logger:Log_Finished();
        end,
        true
    );
end