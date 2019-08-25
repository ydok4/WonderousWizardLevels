function WWL_SetupPostUIListeners(wwl)
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
            local characters = faction:character_list();
            for i = 0, characters:num_items() - 1 do
                local character = characters:item_at(i);
                local characterSubtype = character:character_subtype_key();
                local isSupportedCharacter = wwl:IsSupportedCharacterSubType(characterSubtype);
                wwl.Logger:Log("Generating spells for character: "..character:command_queue_index());
                if isSupportedCharacter == true then
                    wwl:SetSpellsForCharacter(character);
                end
            end
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
            local num_defenders = cm:pending_battle_cache_num_defenders();
            local defenders = {};
            for i = 1, num_defenders do
                local defender_cqi, defender_force_cqi, defender_faction_name = cm:pending_battle_cache_get_defender(i);
                wwl.Logger:Log("Defender cqi: "..defender_cqi.." Defender faction name "..defender_faction_name);
                local militaryForce = cm:model():military_force_for_command_queue_index(tonumber(defender_force_cqi));
                local charactersInMilitaryForce = militaryForce:character_list();
                for i = 0, charactersInMilitaryForce:num_items() - 1 do
                    local character = charactersInMilitaryForce:item_at(i);
                    local characterSubtype = character:character_subtype_key();
                    if wwl:IsSupportedCharacterSubType(characterSubtype) == true then
                        local characterCqi = character:command_queue_index();
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
                    local characterSubtype = character:character_subtype_key();
                    if wwl:IsSupportedCharacterSubType(characterSubtype) == true then
                        local characterCqi = character:command_queue_index();
                        wwl.Logger:Log("Found supported subtype: "..characterSubtype.." with cqi: "..characterCqi);
                        wwl:SetSpellsForCharacter(character);
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
            local characterSubtype = character:character_subtype_key();
            local isSupportedCharacter = wwl:IsSupportedCharacterSubType(characterSubtype);
            return context:skill_point_spent_on():find("wwl_skill_wizard_level_0")
            or isSupportedCharacter;
        end,
        function(context)
            local character = context:character();
            wwl.Logger:Log("Skill point is: "..context:skill_point_spent_on());
            -- Update character data
        end,
        true
    );
end