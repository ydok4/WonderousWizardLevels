local global_character_skill_cache = {};
local global_character_skill_node_set_items_cache = {};
local global_effects_cache = {};
local global_effect_bonus_values_cache = {};

function CreateDBData(databaseData)
    print("\n\nCreating DB Data...");
    -- Load our existing resources based on the files specified
    local signatureSkills = {};
    if not _G.IgnoreVanillaWizards then
        signatureSkills = GenerateWWLSignatureSkills(databaseData);
    end
    local skills = GenerateWWLSkillTrees(databaseData);
    local effects = GenerateWWLEffects(databaseData);
    local multiLoreSkillsAndEffects = GenerateMultiLoreCharacterSkills(databaseData);
    local tablesToExport = {};
    ConcatTableWithKeys(tablesToExport, skills);
    ConcatTableWithKeys(tablesToExport, effects);
    for key, data in pairs(multiLoreSkillsAndEffects) do
        if tablesToExport[key] == nil then
            tablesToExport[key] = {};
        else
            table.remove(data, 1);
            table.remove(data, 1);
        end
        ConcatTable(tablesToExport[key], data);
    end
    for key, data in pairs(signatureSkills) do
        if tablesToExport[key] == nil then
            tablesToExport[key] = {};
        else
            table.remove(data, 1);
            table.remove(data, 1);
        end
        ConcatTable(tablesToExport[key], data);
    end

    return tablesToExport;
end

function RequireCallback(filePath)
    require (filePath);
end

function ConcatTableWithKeys(destinationTable, sourceTable)
    for key, value in pairs(sourceTable) do
        destinationTable[key] = value;
    end
end

function ConcatTable(destinationTable, sourceTable)
    for key, value in pairs(sourceTable) do
        destinationTable[#destinationTable + 1] = value;
    end
end

function Contains(sourceTable, checkValue)
    for index, value in pairs(sourceTable) do
        if value == checkValue then
            return true;
        end
    end
    return false;
end

function GenerateWWLSignatureSkills(databaseData)
    local effectsToExport = {};
    local effectBonusValuesToExport = {};
    local characterSkillsToExport = {};
    local characterSkillsToEffectsToExport = {};
    local characterSkillLocToExport = {};
    local locToExport = {};
    for loreKey, loreData in pairs(_G.WWLResources.MagicLores) do
        if loreData.SignatureSpell ~= nil
        and #loreData.SignatureSpell == 1 then
            for index, spellKey in pairs(loreData.SignatureSpell) do
                if loreData.SignatureSpell ~= nil then
                    print("Generating new signature spell for lore: "..loreKey.." innate skill: "..spellKey);
                    -- First we make the custom character skills
                    local characterSkillsTables = databaseData["character_skills_tables"];
                    local characterSkillsMatchingLore = characterSkillsTables:GetRowsMatchingColumnValues("key", { spellKey, });
                    if next(characterSkillsMatchingLore) then
                        if global_character_skill_cache["wwl_"..spellKey] == nil then
                            local clonedSkill = characterSkillsTables:CloneRow(1, characterSkillsMatchingLore);
                            characterSkillsTables:SetColumnValue(clonedSkill, 'key', "wwl_"..spellKey);
                            characterSkillsTables:SetColumnValue(clonedSkill, 'localised_description', "");
                            table.insert(characterSkillsToExport, clonedSkill);
                            global_character_skill_cache["wwl_"..spellKey] = true;

                            local characterSkillLoc = databaseData["character_skills_loc"];
                            local characterSkillNameLoc = characterSkillLoc:GetRowsMatchingColumnValues("key", { "character_skills_localised_name_"..spellKey, });
                            local clonedNameLoc = characterSkillLoc:CloneRow(1, characterSkillNameLoc);
                            characterSkillLoc:SetColumnValue(clonedNameLoc, 'key', "character_skills_localised_name_wwl_"..spellKey);
                            table.insert(characterSkillLocToExport, clonedNameLoc);
                            local characterSkillDescriptionLoc = characterSkillLoc:GetRowsMatchingColumnValues("key", { "character_skills_localised_description_"..spellKey, });
                            if next(characterSkillDescriptionLoc) then
                                local clonedDescriptionLoc = characterSkillLoc:CloneRow(1, characterSkillDescriptionLoc);
                                characterSkillLoc:SetColumnValue(clonedDescriptionLoc, 'key', "character_skills_localised_description_wwl_"..spellKey);
                                table.insert(characterSkillLocToExport, clonedDescriptionLoc);
                            end

                            local characterSkillLevelToEffectsTable = databaseData["character_skill_level_to_effects_junctions_tables"];
                            local characterSkillEffectsMatchingLore = characterSkillLevelToEffectsTable:GetRowsMatchingColumnValues("character_skill_key", { spellKey, });
                            for effectIndex, effectData in pairs(characterSkillEffectsMatchingLore) do
                                if effectIndex == 1 then
                                    local clonedBaseEffect = characterSkillLevelToEffectsTable:CloneRow(effectIndex, characterSkillEffectsMatchingLore);
                                    characterSkillLevelToEffectsTable:SetColumnValue(clonedBaseEffect, 'character_skill_key', "wwl_"..spellKey);
                                    characterSkillLevelToEffectsTable:SetColumnValue(clonedBaseEffect, 'value', 1);
                                    characterSkillLevelToEffectsTable:SetColumnValue(clonedBaseEffect, 'effect_key', spellKey.."_enabled");
                                    characterSkillLevelToEffectsTable:SetColumnValue(clonedBaseEffect, 'level', 1);
                                    table.insert(characterSkillsToEffectsToExport, clonedBaseEffect);
                                end
                                local clonedEffect = characterSkillLevelToEffectsTable:CloneRow(effectIndex, characterSkillEffectsMatchingLore);
                                local skillLevelString = characterSkillLevelToEffectsTable:GetColumnValuesForRows("level", { clonedEffect, });
                                    local skillLevel = tonumber(skillLevelString[1]);
                                    if spellKey == "wh_dlc03_skill_magic_wild_viletide"
                                    or spellKey == "wh_main_skill_all_magic_fire_03_flaming_sword_of_rhuin"
                                    or spellKey == "wh_main_skill_vmp_magic_vampires_02_vanhels_danse_macabre" then
                                        if skillLevel > 1 then
                                            characterSkillLevelToEffectsTable:SetColumnValue(clonedEffect, 'character_skill_key', "wwl_"..spellKey);
                                            characterSkillLevelToEffectsTable:SetColumnValue(clonedEffect, 'level', skillLevel);
                                            table.insert(characterSkillsToEffectsToExport, clonedEffect);
                                        end
                                    else
                                        characterSkillLevelToEffectsTable:SetColumnValue(clonedEffect, 'character_skill_key', "wwl_"..spellKey);
                                        characterSkillLevelToEffectsTable:SetColumnValue(clonedEffect, 'level', skillLevel + 1);
                                        table.insert(characterSkillsToEffectsToExport, clonedEffect);
                                    end

                            end
                        end
                    else
                        local missingSkill = "";
                    end
                end
            end
        end
    end
    local effectTables = databaseData["effects_tables"];
    local finalisedEffects = effectTables:PrepareRowsForOutput(effectsToExport);
    local effectBonusValuesTables = databaseData["effect_bonus_value_unit_ability_junctions_tables"];
    local finalisedEffectBonusValues = effectBonusValuesTables:PrepareRowsForOutput(effectBonusValuesToExport);
    local characterSkillsTable = databaseData["character_skills_tables"];
    local finalisedCharacterSkills = characterSkillsTable:PrepareRowsForOutput(characterSkillsToExport);
    local characterSkillEffectsTable = databaseData["character_skill_level_to_effects_junctions_tables"];
    local finalisedcharacterSkillEffects = characterSkillEffectsTable:PrepareRowsForOutput(characterSkillsToEffectsToExport);
    local characterSkillLocTable = databaseData["character_skills_loc"];
    local finalisedCharacterSkillLoc = characterSkillLocTable:PrepareRowsForOutput(characterSkillLocToExport);
    return {
        effects_tables = finalisedEffects,
        effect_bonus_value_unit_ability_junctions_tables = finalisedEffectBonusValues,
        character_skills_tables = finalisedCharacterSkills,
        character_skill_level_to_effects_junctions_tables = finalisedcharacterSkillEffects,
        character_skills_loc = finalisedCharacterSkillLoc,
    };
end

function GenerateWWLSkillTrees(databaseData)
    local characterSkillNodesToExport = {};
    local characterSkillNodeSetItemsToExport = {};
    local characterSkillNodeLinksToExport = {};
    local characterSkillLevelToEffectsToExport = {};
    local specialAbilityGroupsTable = databaseData["special_ability_groups_tables"];
    for specialAbilityGroupIndex, specialAbilityGroupData in pairs(specialAbilityGroupsTable.Data) do
        local groupKey = specialAbilityGroupsTable:GetColumnValueForIndex(specialAbilityGroupIndex, "ability_group");
        -- Now we match the lore of magic to the corresponding unit abilities
        local unitAbilitiesJunctionsTable = databaseData["special_ability_groups_to_unit_abilities_junctions_tables"];
        local groupsKeysToMatch = { groupKey, };
        local abilitiesForGroup = unitAbilitiesJunctionsTable:GetRowsMatchingColumnValues("special_ability_groups", groupsKeysToMatch);
        local abilityKeysForGroup = unitAbilitiesJunctionsTable:GetColumnValuesForRows("unit_special_abilities", abilitiesForGroup);
        -- Now we need some additional detail from the unit abilities
        local unitAbilitiesTable = databaseData["unit_abilities_tables"];
        local abilitiesForGroup = unitAbilitiesTable:GetRowsMatchingColumnValues("key", abilityKeysForGroup);
        -- Then we need to tie it back to effects
        local effectBonusValueAbilityJunctionsTable = databaseData["effect_bonus_value_unit_ability_junctions_tables"];
        local effectBonusValuesForAbilities = effectBonusValueAbilityJunctionsTable:GetRowsMatchingColumnValues("unit_ability", abilityKeysForGroup);
        local bonusValueId = {"enable",};
        local enabledSpellEffects = effectBonusValueAbilityJunctionsTable:GetRowsMatchingColumnValues("bonus_value_id", bonusValueId, effectBonusValuesForAbilities);
        local effectKeys = effectBonusValueAbilityJunctionsTable:GetColumnValuesForRows("effect", enabledSpellEffects);
        -- Remove the effects with upgraded in the key
        for effectIndex, effectKey in pairs(effectKeys) do
            if string.match(effectKey, "upgraded") then
                table.remove(effectKeys, effectIndex);
            end
        end
        -- Then we tie the effects to the character skills
        local characterSkillLevelToEffectsTable = databaseData["character_skill_level_to_effects_junctions_tables"];
        local effectsMatchingEnableEffects = characterSkillLevelToEffectsTable:GetRowsMatchingColumnValues("effect_key", effectKeys);
        local characterSkillKeys = characterSkillLevelToEffectsTable:GetColumnValuesForRows("character_skill_key", effectsMatchingEnableEffects);
        for characterSkillIndex, characterSkillKey in pairs(characterSkillKeys) do
            if string.match(characterSkillKey, "innate") then
                characterSkillKeys[characterSkillIndex] = nil;
            end
        end
        -- Finally we find the agents that match our lore
        local agentsWithMatchingLore = {};
        local agentKeysWithMatchingLore = {};
        --for subcultureKey, subcultureAgents in pairs(_G.WWLResources.WizardData) do
            for agentKey, agentData in pairs(_G.WWLResources.WizardData) do
                if type(agentData.Lore) == "string"
                and (groupKey == agentData.Lore
                or groupKey == agentData.BaseLore) then
                    agentsWithMatchingLore[agentKey] = agentData;
                    table.insert(agentKeysWithMatchingLore, agentKey);
                    if groupKey == agentData.BaseLore then
                        groupKey = agentData.Lore;
                    end
                    print("Found agent: "..agentKey.." for Lore: "..groupKey);
                end
            end
        --end

        -- Match them to their character skill sets, then their character skill nodes
        --[[local characterSkillSetsForAgents = characterSkillSetsTable:GetRowsMatchingColumnValues("agent_subtype_key", agentKeysWithMatchingLore);
        local characterSkillSetKeys = characterSkillSetsTable:GetColumnValuesForRows("key", characterSkillSetsForAgents);

        local characterSkillNodesForAgents = characterSkillNodesTable:GetRowsMatchingColumnValues("character_skill_node_set_key", characterSkillSetKeys);
        -- Then match them to their associated character skill nodes
        local characterSkillNodesForAgentCharacterSkills = characterSkillNodesTable:GetRowsMatchingColumnValues("character_skill_key", characterSkillKeys, characterSkillNodesForAgents);--]]
        -- Create/reorganise/overwrite the values with the ones we need
        for agentKey, agentData in pairs(agentsWithMatchingLore) do
            local magicLoreData = _G.WWLResources.MagicLores[groupKey];
            local characterSkillsAndLinks = GenerateSkillTreeForAgent(databaseData, magicLoreData, agentKey, agentData, characterSkillKeys);
            ConcatTable(characterSkillNodesToExport, characterSkillsAndLinks["character_skill_nodes_tables"]);
            ConcatTable(characterSkillNodeSetItemsToExport, characterSkillsAndLinks["character_skill_node_set_items_tables"]);
            ConcatTable(characterSkillNodeLinksToExport, characterSkillsAndLinks["character_skill_node_links_tables"]);
            ConcatTable(characterSkillLevelToEffectsToExport, characterSkillsAndLinks["character_skill_level_to_effects_junctions_tables"]);
        end
    end
    local characterSkillNodesTable = databaseData["character_skill_nodes_tables"];
    local finalisedCharacterSkillNodes = characterSkillNodesTable:PrepareRowsForOutput(characterSkillNodesToExport);
    local finalisedCharacterSkillNodeSetItemsTable = databaseData["character_skill_node_set_items_tables"];
    local finalisedCharacterSkillNodeSetItems = finalisedCharacterSkillNodeSetItemsTable:PrepareRowsForOutput(characterSkillNodeSetItemsToExport);
    local characterSkillNodeLinksTable = databaseData["character_skill_node_links_tables"];
    local finalisedCharacterSkillNodeLinks = characterSkillNodeLinksTable:PrepareRowsForOutput(characterSkillNodeLinksToExport);
    local characterSkillLevelToEffectsTable = databaseData["character_skill_level_to_effects_junctions_tables"];
    local finalisedCharacterSkillLevelToEffects = characterSkillLevelToEffectsTable:PrepareRowsForOutput(characterSkillLevelToEffectsToExport);
    return {
        character_skill_nodes_tables = finalisedCharacterSkillNodes,
        character_skill_node_set_items_tables = finalisedCharacterSkillNodeSetItems,
        character_skill_node_links_tables = finalisedCharacterSkillNodeLinks,
        character_skill_level_to_effects_junctions_tables = finalisedCharacterSkillLevelToEffects,
    };
end

function GenerateSkillTreeForAgent(databaseData, magicLoreData, agentKey, agentData, characterSkillKeys)
    local characterSkillNodesLinksTable = databaseData["character_skill_node_links_tables"];
    local characterSkillSetsTable = databaseData["character_skill_node_sets_tables"];
    local characterSkillNodesTable = databaseData["character_skill_nodes_tables"];
    local characterSkillSetItemsTable = databaseData["character_skill_node_set_items_tables"];
    local agentSkillSet = characterSkillSetsTable:GetRowsMatchingColumnValues("agent_subtype_key", { agentKey, });
    local agentSkillSetKeys = characterSkillSetsTable:GetColumnValuesForRows("key", agentSkillSet);
    local allSkillNodesForCharacter = characterSkillSetItemsTable:GetRowsMatchingColumnValues("set", agentSkillSetKeys);
    local allSkillNodeKeysForCharacter = characterSkillSetItemsTable:GetColumnValuesForRows("item", allSkillNodesForCharacter);
    local knownAgentSkillNodes = characterSkillNodesTable:GetRowsMatchingColumnValues("key", allSkillNodeKeysForCharacter);
    local knownAgentSpellSkills = characterSkillNodesTable:GetRowsMatchingColumnValues("character_skill_key", characterSkillKeys, knownAgentSkillNodes);
    local rowIndents = characterSkillNodesTable:GetUniqueColumnValuesForRows("indent", knownAgentSpellSkills);
    local rowIndent = rowIndents[1];
    if rowIndent == nil then
        -- If for some reason the lore of magic is completely different then we need
        -- to have specified the RowIdent so we know what row to go on.
        if agentData.RowIndent ~= nil then
            rowIndent = agentData.RowIndent;
        else
            print("Agent: "..agentKey.." Is missing data");
            return {
                character_skill_nodes_tables = {},
                character_skill_node_links_tables = {},
                character_skill_level_to_effects_junctions_tables = {},
            };
        end
    end
    if #rowIndents > 1 then
        if rowIndents[1] == '1.0000'
        or rowIndents[1] == '1'
        or rowIndents[1] == '0.0000'
        or rowIndents[1] == '0' then
            rowIndent = rowIndents[2];
        end
        -- Dwarfs have hidden runes on different lines which trips up the generator
        if agentKey == "wh_main_dwf_runesmith"
        or agentKey == "wh_dlc06_dwf_runelord"
        or agentKey == "wh_dlc06_dwf_runesmith_ghost"
        or agentKey == "wh_dlc03_bst_malagor" then -- Not actually sure about malagor but he uses the wrong line
            rowIndent = rowIndents[2];
        end
        print("Agent: "..agentKey.." Has abilities on multiple rows");
    end

    local agentSkillSetKey = agentSkillSetKeys[1];
    local newAgentSkills = {};
    local newAgentSkillSetItems = {};
    local agentSkillNodesOnRow = characterSkillNodesTable:GetRowsMatchingColumnValues("indent", {rowIndent, }, knownAgentSkillNodes);
    -- First we disable all the vanilla skills
    for skillNodeIndex, skillNodeRow in pairs(agentSkillNodesOnRow) do
        --[[local clonedRow = characterSkillNodesTable:CloneRow(skillNodeIndex, agentSkillNodesOnRow);
        characterSkillNodesTable:SetColumnValue(clonedRow, 'character_skill_key', 'wwl_disable_dummy');
        characterSkillNodesTable:SetColumnValue(clonedRow, 'tier', '99');
        characterSkillNodesTable:SetColumnValue(clonedRow, 'visible_in_ui', 'false');
        table.insert(newAgentSkills, clonedRow);--]]
        local skillNodeKey = skillNodeRow[1];
        local existingSkillItemSet = {};
        CreateWWLCharacterSkillNodeSetItemRow(characterSkillSetItemsTable, existingSkillItemSet, agentSkillSetKey, skillNodeKey, 'true');
        table.insert(newAgentSkillSetItems, existingSkillItemSet);
    end
    -- Then we create new skills
    local newAgentLinkSkills = {};
    local clonedMagicLoreSkills = {};
    local baseWizardLevelPrefix = "wwl_skill_wizard_level_0";
    local defaultWizardLevelCharacterSkill = baseWizardLevelPrefix;
    if agentKey == "wh2_dlc17_dwf_thorek"
    or agentKey == "wh_dlc06_dwf_runelord"
    or agentKey == "wh_main_dwf_runesmith"
    or agentKey == "wh_dlc06_dwf_runesmith_ghost"
    or agentKey == "dwf_kragg_the_grim" then
        baseWizardLevelPrefix = "wwl_skill_rune_level_0";
    end
    defaultWizardLevelCharacterSkill = baseWizardLevelPrefix..tostring(agentData.DefaultWizardLevel);
    ConcatTable(clonedMagicLoreSkills, { defaultWizardLevelCharacterSkill, });
    if magicLoreData == nil then
        local mixedLoreMax = 7;
        if agentKey == "wh2_dlc17_lzd_skink_oracle_troglodon" then
            mixedLoreMax = 3;
        end
        for i = 1, mixedLoreMax do
            table.insert(clonedMagicLoreSkills, 'wwl_'..agentKey.."_mixed_magic_"..i);
        end
    else
        local realSignatureSkills = {};
        for index, signatureSpell in pairs(magicLoreData.SignatureSpell) do
            table.insert( realSignatureSkills, 'wwl_'..signatureSpell);
        end
        ConcatTable(clonedMagicLoreSkills, magicLoreData.InnateSkill);
        ConcatTable(clonedMagicLoreSkills, realSignatureSkills);
        ConcatTable(clonedMagicLoreSkills, magicLoreData.Level1DefaultSpells);
    end

    local startingTier = -1;
    local requiredParentsForUpgrade = 9;
    if agentData.DefaultWizardLevel > 2 then
        requiredParentsForUpgrade = 13;
        if magicLoreData ~= nil then
            ConcatTable(clonedMagicLoreSkills, magicLoreData.Level3DefaultSpells);
        end
    end
    local upgradedSkillKey = "";
    local newCharacterSkillLevelToEffects = {};
    -- Perform filtering for the upgrade skills
    if agentData.LoremasterCharacterSkillKey ~= nil then
        upgradedSkillKey = agentData.LoremasterCharacterSkillKey;
        local originalLoreMasterSkill = characterSkillNodesTable:GetRowsMatchingColumnValues("character_skill_key", {agentData.LoremasterCharacterSkillKey}, knownAgentSkillNodes);
        -- If this is a vanilla skill, hide it
        if next(originalLoreMasterSkill) then
            --[[local clonedLoremasterSkillRow = characterSkillNodesTable:CloneRow(1, originalLoreMasterSkill);
            characterSkillNodesTable:SetColumnValue(clonedLoremasterSkillRow, 'character_skill_key', 'wwl_disable_dummy');
            characterSkillNodesTable:SetColumnValue(clonedLoremasterSkillRow, 'tier', 99);
            characterSkillNodesTable:SetColumnValue(clonedLoremasterSkillRow, 'visible_in_ui', 'false');
            table.insert(newAgentSkills, clonedLoremasterSkillRow);--]]
            local loremasterSkillItemSet = {};
            CreateWWLCharacterSkillNodeSetItemRow(characterSkillSetItemsTable, loremasterSkillItemSet, agentSkillSetKey, originalLoreMasterSkill[1][1], 'true');
            --local clonedLoremasterSkillRow = characterSkillSetItemsTable:CloneRow(1, originalLoreMasterSkill);
            --characterSkillSetItemsTable:SetColumnValue(clonedLoremasterSkillRow, 'mod_disabled', 'true');
            table.insert(newAgentSkillSetItems, loremasterSkillItemSet);
        end
        local characterSkillLevelToEffectsTable = databaseData["character_skill_level_to_effects_junctions_tables"];
        local dummyEffect = characterSkillLevelToEffectsTable:GetRowsMatchingColumnValues("effect_key", { "wh_main_effect_agent_action_success_chance_skill", });
        local clonedDummyEffect = characterSkillLevelToEffectsTable:CloneRow(dummyEffect[1], dummyEffect);
        characterSkillLevelToEffectsTable:SetColumnValue(clonedDummyEffect, 'character_skill_key', agentData.LoremasterCharacterSkillKey);
        characterSkillLevelToEffectsTable:SetColumnValue(clonedDummyEffect, 'effect_key', "wwl_skill_loremaster_all_spell_slots");
        characterSkillLevelToEffectsTable:SetColumnValue(clonedDummyEffect, 'value', "1");
        characterSkillLevelToEffectsTable:SetColumnValue(clonedDummyEffect, 'effect_scope', "character_to_character_own");
        characterSkillLevelToEffectsTable:SetColumnValue(clonedDummyEffect, 'level', "1");
        table.insert(newCharacterSkillLevelToEffects, clonedDummyEffect);
    else
        if agentData.DefaultWizardLevel > 3 then
            upgradedSkillKey = "wh_main_skill_all_magic_all_11_diviner";
            if agentKey == "dwf_kragg_the_grim" then
                upgradedSkillKey = "wh_main_skill_dwf_runesmith_self_strike_the_runes";
            end
        else
            upgradedSkillKey = baseWizardLevelPrefix..tostring(agentData.DefaultWizardLevel + 1);
        end
    end
    -- Common skill arrangement for everyone
    for characterSkillIndex, characterSkillKey in pairs(clonedMagicLoreSkills) do
        local skillNodeSpellKey = "wwl_character_skill_node_"..agentKey.."_"..characterSkillKey;
        local newCharacterSkillNodeRow = {};
        startingTier = startingTier + 1;
        CreateWWLCharacterSkillNodeRow(characterSkillNodesTable,
            newCharacterSkillNodeRow,
            skillNodeSpellKey,
            characterSkillKey,
            agentSkillSetKey,
            rowIndent,
            startingTier,
            1,
            0
        );
        table.insert(newAgentSkills, newCharacterSkillNodeRow);

        local newCharacterSkillNodeSetItemRow = {};
        CreateWWLCharacterSkillNodeSetItemRow(characterSkillSetItemsTable, newCharacterSkillNodeSetItemRow, agentSkillSetKey, skillNodeSpellKey, 'false');
        table.insert(newAgentSkillSetItems, newCharacterSkillNodeSetItemRow);

        if characterSkillKey ~= defaultWizardLevelCharacterSkill then
            -- Link the current skill to the default node
            local newCharacterSkillLinkNodeRowDefault = {};
            CreateWWLCharacterSkillNodeLinkRow(characterSkillNodesLinksTable,
            newCharacterSkillLinkNodeRowDefault,
            "wwl_character_skill_node_"..agentKey.."_"..defaultWizardLevelCharacterSkill,
            skillNodeSpellKey,
            "REQUIRED");
            table.insert(newAgentLinkSkills, newCharacterSkillLinkNodeRowDefault);
            -- Link the current skill to the upgraded node
            local newCharacterSkillLinkNodeRowUpgraded = {};
            CreateWWLCharacterSkillNodeLinkRow(characterSkillNodesLinksTable,
            newCharacterSkillLinkNodeRowUpgraded,
            skillNodeSpellKey,
            "wwl_character_skill_node_"..agentKey.."_"..upgradedSkillKey,
            "SUBSET_REQUIRED");
            table.insert(newAgentLinkSkills, newCharacterSkillLinkNodeRowUpgraded);
        end
    end
    -- Upgraded wizard level
    local upgradedWizardLevelNodeKey = "wwl_character_skill_node_"..agentKey.."_"..upgradedSkillKey;
    local upgradedWizardLevel = {};
    startingTier = startingTier + 1;
    CreateWWLCharacterSkillNodeRow(characterSkillNodesTable,
            upgradedWizardLevel,
            upgradedWizardLevelNodeKey,
            upgradedSkillKey,
            agentSkillSetKey,
            rowIndent,
            startingTier,
            0,
            requiredParentsForUpgrade
        );
    table.insert(newAgentSkills, upgradedWizardLevel);

    local upgradedWizardLevelSkillNodeSetItemRow = {};
    CreateWWLCharacterSkillNodeSetItemRow(characterSkillSetItemsTable, upgradedWizardLevelSkillNodeSetItemRow, agentSkillSetKey, upgradedWizardLevelNodeKey, 'false');
    table.insert(newAgentSkillSetItems, upgradedWizardLevelSkillNodeSetItemRow);

    if agentData.DefaultWizardLevel < 3
    and magicLoreData ~= nil then
        -- Level 3 skills
        for characterSkillIndex, characterSkillKey in pairs(magicLoreData.Level3DefaultSpells) do
            local wizardLevel3SkillNodeKey = "wwl_character_skill_node_"..agentKey.."_"..characterSkillKey;
            local newRow = {};
            startingTier = startingTier + 1;
            CreateWWLCharacterSkillNodeRow(characterSkillNodesTable,
                newRow,
                wizardLevel3SkillNodeKey,
                characterSkillKey,
                agentSkillSetKey,
                rowIndent,
                startingTier,
                0,
                0
            );
            table.insert(newAgentSkills, newRow);
            local wizardLevel3SkillNodeSetItemRow = {};
            CreateWWLCharacterSkillNodeSetItemRow(characterSkillSetItemsTable, wizardLevel3SkillNodeSetItemRow, agentSkillSetKey, wizardLevel3SkillNodeKey, 'false');
            table.insert(newAgentSkillSetItems, wizardLevel3SkillNodeSetItemRow);
            -- Add the upgraded skill as the parent of the level 3 skills
            local newSkillLink = {};
            CreateWWLCharacterSkillNodeLinkRow(characterSkillNodesLinksTable,
            newSkillLink,
            "wwl_character_skill_node_"..agentKey.."_"..upgradedSkillKey,
            wizardLevel3SkillNodeKey,
            "REQUIRED");
            table.insert(newAgentLinkSkills, newSkillLink);
            if agentKey == "wh_main_vmp_lord"
            or agentKey == "msl_lord" then
                local vmpLordSkillLink = {};
                -- Link the bonus skill to the final node
                CreateWWLCharacterSkillNodeLinkRow(characterSkillNodesLinksTable,
                vmpLordSkillLink,
                wizardLevel3SkillNodeKey,
                "wwl_character_skill_node_"..agentKey.."_"..baseWizardLevelPrefix.."3",
                "REQUIRED");
                table.insert(newAgentLinkSkills, vmpLordSkillLink);
            end
        end
        if agentKey == "wh_main_vmp_lord"
        or agentKey == "msl_lord" then
            local level03VampireLordSkillNodeKey = "wwl_character_skill_node_"..agentKey.."_wwl_skill_wizard_level_03";
            local level03VmpLord = {};
            startingTier = startingTier + 1;
            CreateWWLCharacterSkillNodeRow(characterSkillNodesTable,
                level03VmpLord,
                level03VampireLordSkillNodeKey,
                "wwl_skill_wizard_level_03",
                agentSkillSetKey,
                rowIndent,
                startingTier,
                0,
                6
            );
            upgradedSkillKey = "wwl_skill_wizard_level_03";
            table.insert(newAgentSkills, level03VmpLord);

            local vampireLordWizardLevel3SkillNodeSetItemRow = {};
            CreateWWLCharacterSkillNodeSetItemRow(characterSkillSetItemsTable, vampireLordWizardLevel3SkillNodeSetItemRow, agentSkillSetKey, level03VampireLordSkillNodeKey, 'false');
            table.insert(newAgentSkillSetItems, vampireLordWizardLevel3SkillNodeSetItemRow);
        end
    end
    -- Bonus skills
    local conduitKey = "";
    local bonusSkills = {
        "wh_main_skill_all_magic_all_06_evasion",
        "wh_main_skill_all_magic_all_07_earthing",
        "wh_main_skill_all_magic_all_08_power_drain",
    };
    if agentKey == "wh2_dlc11_vmp_bloodline_necrarch"
    or agentKey == "wh2_main_lzd_lord_mazdamundi"
    or agentKey == "wh_dlc03_bst_malagor"
    or agentKey == "wh2_dlc16_wef_ariel"
    or agentKey == "wh3_main_tze_kairos"
    or agentKey == "lzd_lord_huinitenuchli"
    or agentKey == "hef_belannaer"
    or string.match(agentKey, "slann")
    or string.match(agentKey, "archmage") then
        conduitKey = "wh2_dlc14_skilll_all_magic_all_greater_arcane_conduit";
    elseif agentKey == "wh2_main_hef_teclis" then
        conduitKey = "wh2_dlc14_skilll_all_magic_all_greater_arcane_conduit";
    elseif agentKey == "wh3_main_tze_herald_of_tzeentch_metal"
    or agentKey == "wh3_main_tze_herald_of_tzeentch_tzeentch"
    or agentKey == "wh3_main_tze_iridescent_horror_metal"
    or agentKey == "wh3_main_tze_iridescent_horror_tzeentch"
    or agentKey == "wh3_main_tze_exalted_lord_of_change_metal"
    or agentKey == "wh3_dlc24_tze_exalted_lord_of_change_metal_locked_army"
    or agentKey == "wh3_main_tze_exalted_lord_of_change_tzeentch"
    or agentKey == "wh3_dlc24_tze_exalted_lord_of_change_tzeentch_locked_army"
    or agentKey == "wh3_main_tze_cultist"
    or agentKey == "tze_melekh_the_changer"
    or agentKey == "chs_malofex_the_storm_chaser"
    or agentKey == "chs_egrimm_van_horstmann"
    or agentKey == "chs_azubhor_clawhand"
    or agentKey == "wh3_dlc24_tze_the_changeling"
    or agentKey == "wh3_dlc20_chs_daemon_prince_tzeentch" then
        if agentKey == "wh3_main_tze_exalted_lord_of_change_metal"
        or agentKey == "wh3_dlc24_tze_exalted_lord_of_change_metal_locked_army"
        or agentKey == "wh3_main_tze_exalted_lord_of_change_tzeentch"
        or agentKey == "wh3_dlc24_tze_exalted_lord_of_change_tzeentch_locked_army"
        or agentKey == "chs_malofex_the_storm_chaser"
        or agentKey == "wh3_dlc20_chs_daemon_prince_tzeentch" then
            conduitKey = "wh2_dlc14_skilll_all_magic_all_greater_arcane_conduit";
        else
            conduitKey = "wh_main_skill_all_magic_all_11_arcane_conduit";
        end

        bonusSkills = {
            "wh3_main_skill_tze_all_magic_prismatic_plurality",
            "wh_main_skill_all_magic_all_07_earthing",
            "wh_main_skill_all_magic_all_08_power_drain",
        };
    elseif agentKey == "wh2_dlc17_dwf_thorek"
    or agentKey == "wh_dlc06_dwf_runelord"
    or agentKey == "wh_main_dwf_runesmith"
    or agentKey == "wh_dlc06_dwf_runesmith_ghost" then
        conduitKey = "wh_main_skill_dwf_runesmith_self_strike_the_runes";
        bonusSkills = {
            "wh_main_skill_dwf_runesmith_self_forgefire",
            "wh_main_skill_dwf_runesmith_self_rune_of_hearth_&_home",
            "wh2_dlc17_skill_dwf_runesmith_self_wardbreaker",
        };
    elseif agentKey == "dwf_kragg_the_grim" then
        conduitKey = "mixu_LL_dwf_rune_abilities_master_rune_of_kragg";
        bonusSkills = {
            "wh_main_skill_dwf_runesmith_self_forgefire",
            "wh_main_skill_dwf_runesmith_self_rune_of_hearth_&_home",
            "wh2_dlc17_skill_dwf_runesmith_self_wardbreaker",
        };
    elseif agentKey == "wh2_dlc17_lzd_skink_oracle_troglodon" then
        conduitKey = "wh2_dlc17_skill_lzd_skink_oracle_telepathic_link";
    elseif agentKey == "wef_shadowdancer" then
        conduitKey = "mixu_wef_shadowdancer_ability_loecs_blessing";
        bonusSkills = {
            "mixu_wef_shadowdancer_special_loecs_shroud",
            "wh_main_skill_all_magic_all_07_earthing",
            "wh_main_skill_all_magic_all_08_power_drain",
        };
    elseif agentKey == "wh2_main_def_morathi" then
        conduitKey = "wh2_dlc14_skilll_all_magic_all_greater_arcane_conduit";
        bonusSkills = {
            "wh2_main_skill_def_generic_hekartis_blessing_morathi",
            "wh_main_skill_all_magic_all_07_earthing",
            "wh_main_skill_all_magic_all_08_power_drain",
        };
    elseif agentKey == "wh2_dlc10_def_supreme_sorceress_beasts"
    or agentKey == "wh2_dlc10_def_supreme_sorceress_dark"
    or agentKey == "wh2_dlc10_def_supreme_sorceress_death"
    or agentKey == "wh2_dlc10_def_supreme_sorceress_fire"
    or agentKey == "wh2_dlc10_def_supreme_sorceress_shadow"
    or agentKey == "wh2_main_def_sorceress_dark"
    or agentKey == "wh2_main_def_sorceress_fire"
    or agentKey == "wh2_main_def_sorceress_shadow"
    or agentKey == "wh2_dlc10_def_sorceress_beasts"
    or agentKey == "wh2_dlc10_def_sorceress_death" then
        conduitKey = "wh_main_skill_all_magic_all_11_arcane_conduit";
        bonusSkills = {
            "wh2_main_skill_def_generic_hekartis_blessing",
            "wh_main_skill_all_magic_all_07_earthing",
            "wh_main_skill_all_magic_all_08_power_drain",
        };
    elseif agentKey == "adv_butcher_death"
    or agentKey == "adv_butcher_heav"
    or agentKey == "wh3_main_ogr_butcher_beasts"
    or agentKey == "wh3_main_ogr_butcher_great_maw"
    or agentKey == "adv_slaught_death"
    or agentKey == "adv_slaught_heav"
    or agentKey == "wh3_main_ogr_slaughtermaster_beasts"
    or agentKey == "wh3_main_ogr_slaughtermaster_great_maw"
    or agentKey == "wh3_main_ogr_skrag_the_slaughterer" then
        conduitKey = "wh3_main_skill_ogr_magic_all_11_extra_ingredients";
        bonusSkills = {
            "wh3_main_skill_ogr_magic_meat_cleaver",
            "wh_main_skill_all_magic_all_07_earthing",
            "wh3_main_skill_ogr_magic_meat_reserves",
        };
    else
        conduitKey = "wh_main_skill_all_magic_all_11_arcane_conduit";
    end
    table.insert(bonusSkills, conduitKey);
    for characterSkillIndex, characterSkillKey in pairs(bonusSkills) do
        local bonusSkillKey = "wwl_character_skill_node_"..agentKey.."_"..characterSkillKey;
        local newBonusSkillRow = {};
        local newSkillLink = {};
        startingTier = startingTier + 1;
        local bonusSkillNumberOfParents = 0;
        if characterSkillKey ~= conduitKey then
            -- Link the bonus skills to the ugpraded node
            CreateWWLCharacterSkillNodeLinkRow(characterSkillNodesLinksTable,
            newSkillLink,
            "wwl_character_skill_node_"..agentKey.."_"..upgradedSkillKey,
            bonusSkillKey,
            "REQUIRED");
            table.insert(newAgentLinkSkills, newSkillLink);
            newSkillLink = {};
            -- Link the bonus skill to the final node
            CreateWWLCharacterSkillNodeLinkRow(characterSkillNodesLinksTable,
            newSkillLink,
            bonusSkillKey,
            "wwl_character_skill_node_"..agentKey.."_"..conduitKey,
            "REQUIRED");
            table.insert(newAgentLinkSkills, newSkillLink);
        else
            -- Arcane Conduit / Capstone
            bonusSkillNumberOfParents = 3;
        end
        CreateWWLCharacterSkillNodeRow(characterSkillNodesTable,
            newBonusSkillRow,
            bonusSkillKey,
            characterSkillKey,
            agentSkillSetKey,
            rowIndent,
            startingTier,
            0,
            bonusSkillNumberOfParents
        );
        table.insert(newAgentSkills, newBonusSkillRow);
        local bonusSkillNodeSetItemRow = {};
        CreateWWLCharacterSkillNodeSetItemRow(characterSkillSetItemsTable, bonusSkillNodeSetItemRow, agentSkillSetKey, bonusSkillKey, 'false');
        table.insert(newAgentSkillSetItems, bonusSkillNodeSetItemRow);
    end
    if agentKey == "wh_main_vmp_lord"
    or agentKey == "msl_lord" then
        local vampireLordLevel04SkillNodeKey = "wwl_character_skill_node_"..agentKey.."_wwl_skill_wizard_level_04";
        local level04VmpLord = {};
        startingTier = startingTier + 1;
        CreateWWLCharacterSkillNodeRow(characterSkillNodesTable,
            level04VmpLord,
            vampireLordLevel04SkillNodeKey,
            "wwl_skill_wizard_level_04",
            agentSkillSetKey,
            rowIndent,
            startingTier,
            0,
            1
        );
        table.insert(newAgentSkills, level04VmpLord);
        local vampireLord04SkillNodeSetItemRow = {};
        CreateWWLCharacterSkillNodeSetItemRow(characterSkillSetItemsTable, vampireLord04SkillNodeSetItemRow, agentSkillSetKey, vampireLordLevel04SkillNodeKey, 'false');
        table.insert(newAgentSkillSetItems, vampireLord04SkillNodeSetItemRow);
        local newSkillLink = {};
        -- Link the bonus skill to the final node
        CreateWWLCharacterSkillNodeLinkRow(characterSkillNodesLinksTable,
        newSkillLink,
        "wwl_character_skill_node_"..agentKey.."_"..conduitKey,
        "wwl_character_skill_node_"..agentKey.."_wwl_skill_wizard_level_04",
        "REQUIRED");
        table.insert(newAgentLinkSkills, newSkillLink);
    elseif agentKey == "wh3_dlc20_chs_daemon_prince_nurgle"
    or agentKey == "wh3_dlc20_chs_daemon_prince_slaanesh"
    or agentKey == "wh3_dlc20_chs_daemon_prince_tzeentch"
    or agentKey == "wh3_dlc20_chs_daemon_prince_undivided" then
        local level04DaemonPrinceSkillNodeKey = "wwl_character_skill_node_"..agentKey.."_wwl_skill_wizard_level_03";
        local level04DaemonPrince = {};
        startingTier = startingTier + 1;
        CreateWWLCharacterSkillNodeRow(characterSkillNodesTable,
            level04DaemonPrince,
            level04DaemonPrinceSkillNodeKey,
            "wwl_skill_wizard_level_03",
            agentSkillSetKey,
            rowIndent,
            startingTier,
            0,
            1
        );
        table.insert(newAgentSkills, level04DaemonPrince);
        local vampireLord04SkillNodeSetItemRow = {};
        CreateWWLCharacterSkillNodeSetItemRow(characterSkillSetItemsTable, vampireLord04SkillNodeSetItemRow, agentSkillSetKey, level04DaemonPrinceSkillNodeKey, 'false');
        table.insert(newAgentSkillSetItems, vampireLord04SkillNodeSetItemRow);
        local newSkillLink = {};
        -- Link the bonus skill to the final node
        CreateWWLCharacterSkillNodeLinkRow(characterSkillNodesLinksTable,
        newSkillLink,
        "wwl_character_skill_node_"..agentKey.."_"..conduitKey,
        level04DaemonPrinceSkillNodeKey,
        "REQUIRED");
        table.insert(newAgentLinkSkills, newSkillLink);
    end
    return {
        character_skill_nodes_tables = newAgentSkills,
        character_skill_node_set_items_tables = newAgentSkillSetItems,
        character_skill_node_links_tables = newAgentLinkSkills,
        character_skill_level_to_effects_junctions_tables = newCharacterSkillLevelToEffects,
    };
end

function CreateWWLCharacterSkillNodeRow(table, row, key, characterSkillKey, agentSkillSetKey, indent, tier, pointsOnCreation, numParents)
    table:SetColumnValue(row, 'campaign_key', '');
    table:SetColumnValue(row, 'character_skill_key', characterSkillKey);
    --table:SetColumnValue(row, 'character_skill_node_set_key', agentSkillSetKey);
    table:SetColumnValue(row, 'faction_key', '');
    table:SetColumnValue(row, 'indent', indent);
    table:SetColumnValue(row, 'key', key);
    table:SetColumnValue(row, 'tier', tier);
    table:SetColumnValue(row, 'subculture', '');
    table:SetColumnValue(row, 'points_on_creation', pointsOnCreation);
    table:SetColumnValue(row, 'required_num_parents', numParents);
    table:SetColumnValue(row, 'visible_in_ui', 'true');
end

function CreateWWLCharacterSkillNodeSetItemRow(table, row, set, itemKey, isDisabled)
    local uniqueKey = set..itemKey..isDisabled;
    if not global_character_skill_node_set_items_cache[uniqueKey] then
        table:SetColumnValue(row, 'set', set);
        table:SetColumnValue(row, 'item', itemKey);
        table:SetColumnValue(row, 'mod_disabled', isDisabled);
        global_character_skill_node_set_items_cache[uniqueKey] = true;
    end
end

function CreateWWLCharacterSkillNodeLinkRow(table, row, parentKey, childKey, linkType)
    table:SetColumnValue(row, 'child_key', childKey);
    table:SetColumnValue(row, 'initial_descent_tiers', '0');
    table:SetColumnValue(row, 'parent_key', parentKey);
    table:SetColumnValue(row, 'parent_link_position', '1');
    table:SetColumnValue(row, 'child_link_position', '1');
    table:SetColumnValue(row, 'parent_link_position_offset', '0');
    table:SetColumnValue(row, 'child_link_position_offset', '0');
    table:SetColumnValue(row, 'link_type', linkType);
end

-- Note: The prefix, suffix and keepDataExtension are optional.
-- The prefix/suffix adds a the value to the beginning or end of
-- the output file name
-- keepDataExtension will not remove _data__ from the output filename.
function OutputToFile(modifiedDBs, prefix, dataTableName, keepDataExtension)
    print("\n\nStarting file output...");
    for fileName, file in pairs(modifiedDBs) do
        if prefix ~= nil then
            fileName = prefix..fileName;
        end
        if keepDataExtension ~= true then
            fileName = fileName:gsub('_data__', '');
        end
        local iostream = assert(io.open("SkillTreeGenerator\\out\\"..fileName..".tsv", "w+"));
        print("Writing "..fileName.." to disk");
        for rowKey, row in pairs(file) do
            if rowKey == 2 then
                local rowString = row[1];
                local tableDefinitionRow = "";
                if string.match(rowString, "text/db/") then
                    local locName = fileName:gsub("@", '');
                    tableDefinitionRow = "#Loc;1;text/db/"..dataTableName.."_"..locName..".loc";
                else
                    tableDefinitionRow = rowString:gsub('/data__', '/'..dataTableName);
                end
                iostream:write(tableDefinitionRow.."\n");
            else
                for columnKey, column in pairs(row) do
                    if columnKey == #row then
                        iostream:write(column.."\n");
                    else
                        iostream:write(column.."\t");
                    end
                end
            end
        end
    end
end

function GenerateWWLEffects(databaseData)
    print("GenerateWWLEffects");
    local effectsToExport = {};
    local effectBonusValuesToExport = {};
    local effectLocToExport = {};
    local unitSpecialAbilityToExport = {};

    local effectTables = databaseData["effects_tables"];
    local effectsLocTables = databaseData["effects_loc"];
    local specialAbilityGroupsTable = databaseData["special_ability_groups_tables"];
    local unitSpecialAbilitiesTables = databaseData["unit_special_abilities_tables"];

    for specialAbilityGroupIndex, specialAbilityGroupData in pairs(specialAbilityGroupsTable.Data) do
        local groupKey = specialAbilityGroupsTable:GetColumnValueForIndex(specialAbilityGroupIndex, "ability_group");
        -- Now we match the lore of magic to the corresponding unit abilities
        local unitAbilitiesJunctionsTable = databaseData["special_ability_groups_to_unit_abilities_junctions_tables"];
        local groupsKeysToMatch = { groupKey, };
        local abilitiesForGroup = unitAbilitiesJunctionsTable:GetRowsMatchingColumnValues("special_ability_groups", groupsKeysToMatch);
        local abilityKeysForGroup = unitAbilitiesJunctionsTable:GetColumnValuesForRows("unit_special_abilities", abilitiesForGroup);
        -- Then we need to tie it back to effects
        local effectBonusValueAbilityJunctionsTable = databaseData["effect_bonus_value_unit_ability_junctions_tables"];
        local effectBonusValuesForAbilities = effectBonusValueAbilityJunctionsTable:GetRowsMatchingColumnValues("unit_ability", abilityKeysForGroup);
        local bonusValueId = {"enable",};
        local enabledSpellEffects = effectBonusValueAbilityJunctionsTable:GetRowsMatchingColumnValues("bonus_value_id", bonusValueId, effectBonusValuesForAbilities);
        local magicLoreData = _G.WWLResources.MagicLores[groupKey];
        if magicLoreData ~= nil then
            local allSpellsForLore = {};
            ConcatTable(allSpellsForLore, magicLoreData.InnateSkill);
            ConcatTable(allSpellsForLore, magicLoreData.SignatureSpell);
            ConcatTable(allSpellsForLore, magicLoreData.Level1DefaultSpells);
            ConcatTable(allSpellsForLore, magicLoreData.Level3DefaultSpells);
            for spellIndex, spellKey in pairs(allSpellsForLore) do
                if spellKey ~= "wh_main_skill_dwf_runesmith_self_damping" then -- Need to hardcode the exception for dwarfs
                    if global_effects_cache[spellKey.."_enabled"] == nil then
                        local characterSkillLevelToEffectsTable = databaseData["character_skill_level_to_effects_junctions_tables"];
                        local effectsMatchingCharacterSkill = characterSkillLevelToEffectsTable:GetRowsMatchingColumnValues("character_skill_key", {spellKey});
                        local effectKeysMatchingCharacterSkill = characterSkillLevelToEffectsTable:GetColumnValuesForRows("effect_key", effectsMatchingCharacterSkill);
                        local effectsMatchingSpellBonusValues = effectBonusValueAbilityJunctionsTable:GetRowsMatchingColumnValues("effect", effectKeysMatchingCharacterSkill);
                        local enableBonusValuesForSpell = effectBonusValueAbilityJunctionsTable:GetRowsMatchingColumnValues("bonus_value_id", { "enable" }, effectsMatchingSpellBonusValues);
                        local matchingSpellAbilityKey = "";
                        local matchingSpellOriginalKey = "";
                        if next(enableBonusValuesForSpell) then
                            matchingSpellOriginalKey = effectBonusValueAbilityJunctionsTable:GetColumnValueForIndex(1, 'effect', enableBonusValuesForSpell);
                            matchingSpellAbilityKey = effectBonusValueAbilityJunctionsTable:GetColumnValueForIndex(1, 'unit_ability', enableBonusValuesForSpell);
                        else
                            --matchingSpellOriginalKey = effectBonusValueAbilityJunctionsTable:GetColumnValueForIndex(1, 'effect', effectsMatchingSpellBonusValues);
                            matchingSpellAbilityKey = effectBonusValueAbilityJunctionsTable:GetColumnValueForIndex(1, 'unit_ability', effectsMatchingSpellBonusValues);
                        end
                        local enableOverCharge = effectBonusValueAbilityJunctionsTable:GetRowsMatchingColumnValues("bonus_value_id", { "enable_overchage" }, effectsMatchingSpellBonusValues);

                        local newEnabledEffectRow = {};
                        effectTables:SetColumnValue(newEnabledEffectRow, 'effect', spellKey.."_enabled");
                        effectTables:SetColumnValue(newEnabledEffectRow, 'icon', 'magic_character.png');
                        effectTables:SetColumnValue(newEnabledEffectRow, 'priority', '0');
                        effectTables:SetColumnValue(newEnabledEffectRow, 'icon_negative', 'magic_character.png');
                        effectTables:SetColumnValue(newEnabledEffectRow, 'category', 'both');
                        effectTables:SetColumnValue(newEnabledEffectRow, 'is_positive_value_good', 'true');
                        table.insert(effectsToExport, newEnabledEffectRow);
                        local clonedBonusValueRow = effectBonusValueAbilityJunctionsTable:CloneRow(1, enabledSpellEffects);
                        effectBonusValueAbilityJunctionsTable:SetColumnValue(clonedBonusValueRow, 'effect', spellKey.."_enabled");
                        effectBonusValueAbilityJunctionsTable:SetColumnValue(clonedBonusValueRow, 'bonus_value_id', "enable");
                        effectBonusValueAbilityJunctionsTable:SetColumnValue(clonedBonusValueRow, 'unit_ability', matchingSpellAbilityKey);
                        
                        table.insert(effectBonusValuesToExport, clonedBonusValueRow);
                        local newDisabledEffectRow = {};
                        effectTables:SetColumnValue(newDisabledEffectRow, 'effect', spellKey.."_disabled");
                        effectTables:SetColumnValue(newDisabledEffectRow, 'icon', 'magic_character.png');
                        effectTables:SetColumnValue(newDisabledEffectRow, 'priority', '0');
                        effectTables:SetColumnValue(newDisabledEffectRow, 'icon_negative', 'magic_character.png');
                        effectTables:SetColumnValue(newDisabledEffectRow, 'category', 'both');
                        effectTables:SetColumnValue(newDisabledEffectRow, 'is_positive_value_good', 'false');
                        table.insert(effectsToExport, newDisabledEffectRow);
                        local clonedBonusValueRow = effectBonusValueAbilityJunctionsTable:CloneRow(1, enabledSpellEffects);
                        effectBonusValueAbilityJunctionsTable:SetColumnValue(clonedBonusValueRow, 'effect', spellKey.."_disabled");
                        effectBonusValueAbilityJunctionsTable:SetColumnValue(clonedBonusValueRow, 'bonus_value_id', "disable");
                        effectBonusValueAbilityJunctionsTable:SetColumnValue(clonedBonusValueRow, 'unit_ability', matchingSpellAbilityKey);
                        table.insert(effectBonusValuesToExport, clonedBonusValueRow);

                        global_effects_cache[spellKey.."_enabled"] = true;

                        if enableOverCharge[1] ~= nil
                        and global_effects_cache[spellKey.."_enabled_overcharge"] == nil then
                            local newOverChargeEffectRow = {};
                            effectTables:SetColumnValue(newOverChargeEffectRow, 'effect', spellKey.."_enabled_overcharge");
                            effectTables:SetColumnValue(newOverChargeEffectRow, 'icon', 'magic_character.png');
                            effectTables:SetColumnValue(newOverChargeEffectRow, 'priority', '0');
                            effectTables:SetColumnValue(newOverChargeEffectRow, 'icon_negative', 'magic_character.png');
                            effectTables:SetColumnValue(newOverChargeEffectRow, 'category', 'both');
                            effectTables:SetColumnValue(newOverChargeEffectRow, 'is_positive_value_good', 'true');
                            table.insert(effectsToExport, newOverChargeEffectRow);
                            local clonedBonusValueOverChargeRow = effectBonusValueAbilityJunctionsTable:CloneRow(1, enabledSpellEffects);
                            effectBonusValueAbilityJunctionsTable:SetColumnValue(clonedBonusValueOverChargeRow, 'effect', spellKey.."_enabled_overcharge");
                            effectBonusValueAbilityJunctionsTable:SetColumnValue(clonedBonusValueOverChargeRow, 'bonus_value_id', "enable_overchage"); -- Yep, this is a typo in the game files
                            effectBonusValueAbilityJunctionsTable:SetColumnValue(clonedBonusValueOverChargeRow, 'unit_ability', matchingSpellAbilityKey);
                            table.insert(effectBonusValuesToExport, clonedBonusValueOverChargeRow);

                            global_effects_cache[spellKey.."_enabled_overcharge"] = true;
                        end

                        local effectLoc = effectsLocTables:GetRowsMatchingColumnValues("key", { "effects_description_"..matchingSpellOriginalKey, });
                        local clonedEffectLoc = effectsLocTables:CloneRow(1, effectLoc);
                        local effectDescription = clonedEffectLoc[2];
                        if effectDescription ~= nil then
                            local primaryKey = spellKey:gsub('wh3_main_skill_', "");
                            primaryKey = primaryKey:gsub('wh_main_skill_all_', "");
                            primaryKey = primaryKey:gsub('wh_dlc05_skill_magic_', "");
                            effectDescription = effectDescription:gsub('Overcast spell', "Spell");
                            effectDescription = effectDescription:gsub('Overcast ', "");
                            effectDescription = effectDescription:gsub(' Upgraded', "");
                            effectsLocTables:SetColumnValue(clonedEffectLoc, 'key', "effects_description_"..primaryKey.."_enabled_visible");
                            effectsLocTables:SetColumnValue(clonedEffectLoc, 'text', effectDescription);
                            effectsLocTables:SetColumnValue(clonedEffectLoc, 'tooltip', 'true');
                            table.insert(effectLocToExport, clonedEffectLoc);

                            local newEnabledEffectLocRow = {};
                            effectTables:SetColumnValue(newEnabledEffectLocRow, 'effect', primaryKey.."_enabled_visible");
                            effectTables:SetColumnValue(newEnabledEffectLocRow, 'icon', 'magic_character.png');
                            effectTables:SetColumnValue(newEnabledEffectLocRow, 'priority', '292');
                            effectTables:SetColumnValue(newEnabledEffectLocRow, 'icon_negative', 'magic_character.png');
                            effectTables:SetColumnValue(newEnabledEffectLocRow, 'category', 'both');
                            effectTables:SetColumnValue(newEnabledEffectLocRow, 'is_positive_value_good', 'true');
                            table.insert(effectsToExport, newEnabledEffectLocRow);

                            local clonedVisibleBonusValueRow = effectBonusValueAbilityJunctionsTable:CloneRow(1, enabledSpellEffects);
                            effectBonusValueAbilityJunctionsTable:SetColumnValue(clonedVisibleBonusValueRow, 'effect', primaryKey.."_enabled_visible");
                            effectBonusValueAbilityJunctionsTable:SetColumnValue(clonedVisibleBonusValueRow, 'bonus_value_id', "enable");
                            effectBonusValueAbilityJunctionsTable:SetColumnValue(clonedVisibleBonusValueRow, 'unit_ability', matchingSpellAbilityKey);
                            table.insert(effectBonusValuesToExport, clonedVisibleBonusValueRow);
                        end
                    end
                end
            end

            local loresWithWWLTransformationBehaviour = {
                wh_dlc05_lore_life = true,
                wh_main_lore_metal = true,
                wh_main_lore_heavens = true,
                wh3_main_lore_of_yang = true,
                wh3_main_lore_of_yin = true,
            };
            if loresWithWWLTransformationBehaviour[groupKey] ~= nil then
                print("Clong unit special abilities for lore: "..groupKey)
                for spellIndex, spellKey in pairs(magicLoreData.SignatureSpell) do
                    CloneSpecialAbilityForTransformation(databaseData, effectBonusValueAbilityJunctionsTable, unitSpecialAbilitiesTables, unitSpecialAbilityToExport, spellKey, 'true');
                end
                for spellIndex, spellKey in pairs(magicLoreData.Level1DefaultSpells) do
                    CloneSpecialAbilityForTransformation(databaseData, effectBonusValueAbilityJunctionsTable, unitSpecialAbilitiesTables, unitSpecialAbilityToExport, spellKey, 'true');
                end
                for spellIndex, spellKey in pairs(magicLoreData.Level3DefaultSpells) do
                    CloneSpecialAbilityForTransformation(databaseData, effectBonusValueAbilityJunctionsTable, unitSpecialAbilitiesTables, unitSpecialAbilityToExport, spellKey, 'false');
                end
            end
        end
    end
    local finalisedEffects = effectTables:PrepareRowsForOutput(effectsToExport);
    local finalisedEffectsLoc = effectsLocTables:PrepareRowsForOutput(effectLocToExport);
    local effectBonusValuesTables = databaseData["effect_bonus_value_unit_ability_junctions_tables"];
    local finalisedEffectBonusValues = effectBonusValuesTables:PrepareRowsForOutput(effectBonusValuesToExport);
    local finalisedUnitSpecialAbilityToExport = unitSpecialAbilitiesTables:PrepareRowsForOutput(unitSpecialAbilityToExport);

    print("Finished GenerateWWLEffects");
    return {
        effects_tables = finalisedEffects,
        effect_bonus_value_unit_ability_junctions_tables = finalisedEffectBonusValues,
        effectsLoc = finalisedEffectsLoc,
        unit_special_abilities_tables = finalisedUnitSpecialAbilityToExport,
    };
end

function CloneSpecialAbilityForTransformation(databaseData, effectBonusValueAbilityJunctionsTable, unitSpecialAbilitiesTables, unitSpecialAbilityToExport, spellKey, canBeCopied)
    if spellKey ~= "wh_main_skill_dwf_runesmith_self_damping" then -- Need to hardcode the exception for dwarfs
        if global_effects_cache[spellKey.."_enabled"] ~= nil then
            local characterSkillLevelToEffectsTable = databaseData["character_skill_level_to_effects_junctions_tables"];
            local effectsMatchingCharacterSkill = characterSkillLevelToEffectsTable:GetRowsMatchingColumnValues("character_skill_key", {spellKey});
            local effectKeysMatchingCharacterSkill = characterSkillLevelToEffectsTable:GetColumnValuesForRows("effect_key", effectsMatchingCharacterSkill);
            local effectsMatchingSpellBonusValues = effectBonusValueAbilityJunctionsTable:GetRowsMatchingColumnValues("effect", effectKeysMatchingCharacterSkill);
            local enableBonusValuesForSpell = effectBonusValueAbilityJunctionsTable:GetRowsMatchingColumnValues("bonus_value_id", { "enable" }, effectsMatchingSpellBonusValues);
            local matchingSpellAbilityKey = "";
            local matchingSpellOriginalKey = "";
            if next(enableBonusValuesForSpell) then
                matchingSpellOriginalKey = effectBonusValueAbilityJunctionsTable:GetColumnValueForIndex(1, 'effect', enableBonusValuesForSpell);
                matchingSpellAbilityKey = effectBonusValueAbilityJunctionsTable:GetColumnValueForIndex(1, 'unit_ability', enableBonusValuesForSpell);
            else
                matchingSpellAbilityKey = effectBonusValueAbilityJunctionsTable:GetColumnValueForIndex(1, 'unit_ability', effectsMatchingSpellBonusValues);
            end

            if matchingSpellAbilityKey ~= nil then
                local unitSpecialAbility = unitSpecialAbilitiesTables:GetRowsMatchingColumnValues("key", { matchingSpellAbilityKey });
                if unitSpecialAbility and next(unitSpecialAbility) then
                    local clonedUnitSpecialAbility = unitSpecialAbilitiesTables:CloneRow(1, unitSpecialAbility);
                    unitSpecialAbilitiesTables:SetColumnValue(clonedUnitSpecialAbility, 'can_be_copied_to_transformation_unit', canBeCopied);
                    table.insert(unitSpecialAbilityToExport, clonedUnitSpecialAbility);
                    local unitSpecialAbilityKey = unitSpecialAbilitiesTables:GetColumnValueForRow(clonedUnitSpecialAbility, "key");
                    local upgradedUnitSpecialAbilityKey = unitSpecialAbilityKey.."_upgraded";
                    local upgradedUnitSpecialAbility = unitSpecialAbilitiesTables:GetRowsMatchingColumnValues("key", { upgradedUnitSpecialAbilityKey });
                    if upgradedUnitSpecialAbility ~= nil and next(upgradedUnitSpecialAbility) then
                        local clonedUpgradedUnitSpecialAbility = unitSpecialAbilitiesTables:CloneRow(1, upgradedUnitSpecialAbility);
                        unitSpecialAbilitiesTables:SetColumnValue(clonedUpgradedUnitSpecialAbility, 'can_be_copied_to_transformation_unit', canBeCopied);
                        table.insert(unitSpecialAbilityToExport, clonedUpgradedUnitSpecialAbility);
                    end
                end
            end
        end
    end
    return;
end

function GenerateMultiLoreCharacterSkills(databaseData)
    local multiLoreCasters = {};
    --for subcultureKey, subcultureCasters in pairs(_G.WWLResources.WizardData) do
        for agentKey, agentData in pairs(_G.WWLResources.WizardData) do
            if type(agentData.Lore) == "table"
            -- Daemon Prince is unique
            and agentKey ~= "wh3_main_dae_daemon_prince" then
                multiLoreCasters[agentKey] = agentData;
            end
        end
    --end
    local effectsToExport = {};
    local effectsLocToExport = {};
    local effectBonusValuesToExport = {};
    local characterSkillsToExport = {};
    local characterSkillsToEffectsToExport = {};
    local characterSkillNodesToExport = {};
    local characterSkillNodeSetItemsToExport = {};
    local characterSkillNodeLinksToExport = {};
    local characterSkillLocToExport = {};

    local effectsLocTables = databaseData["effects_loc"];

    for agentKey, agentData in pairs(multiLoreCasters) do
        print("Generating multi lore for: "..agentKey);
        local characterSkillEffects = {};
        -- First we make the custom character skills
        local characterSkillsTables = databaseData["character_skills_tables"];
        local newCharacterSkills = {};
        local characterSkillLoc = databaseData["character_skills_loc"];
        local newCharacterSkillsLoc = {};
        local temporaryCharacterSkillName = {};
        for i = 1, 7 do
            local newSkill = {};
            local newSkillKey = 'wwl_'..agentKey.."_mixed_magic_"..i;
            characterSkillsTables:SetColumnValue(newSkill, 'image_path', 'character_magic.png');
            characterSkillsTables:SetColumnValue(newSkill, 'key', newSkillKey);
            characterSkillsTables:SetColumnValue(newSkill, 'localised_description', '');
            characterSkillsTables:SetColumnValue(newSkill, 'localised_name', '');
            characterSkillsTables:SetColumnValue(newSkill, 'unlocked_at_rank', '0');
            characterSkillsTables:SetColumnValue(newSkill, 'is_background_skill', 'false');
            characterSkillsTables:SetColumnValue(newSkill, 'is_female_only_background_skill', 'false');
            characterSkillsTables:SetColumnValue(newSkill, 'is_male_only_background_skill', 'false');
            characterSkillsTables:SetColumnValue(newSkill, 'background_weighting', '0');
            characterSkillsTables:SetColumnValue(newSkill, 'influence_cost', '0');
            newCharacterSkills[i] = newSkill;
            local newLocName = {};
            characterSkillLoc:SetColumnValue(newLocName, 'key', "character_skills_localised_name_"..newSkillKey);
            characterSkillLoc:SetColumnValue(newLocName, 'text', '');
            characterSkillLoc:SetColumnValue(newLocName, 'tooltip', 'true');
            newCharacterSkillsLoc[i * 2] = newLocName;
            local newLocDescription = {};
            characterSkillLoc:SetColumnValue(newLocDescription, 'key', "character_skills_localised_description_"..newSkillKey);
            characterSkillLoc:SetColumnValue(newLocDescription, 'text', '');
            characterSkillLoc:SetColumnValue(newLocDescription, 'tooltip', 'true');
            newCharacterSkillsLoc[i * 2 - 1] = newLocDescription;
        end
        local characterSkillLevelToEffectsTable = databaseData["character_skill_level_to_effects_junctions_tables"];
        local agentLoresData = {};
        -- We need to do a prepass so we know what the max level is before we start attempting to generate
        local maxLevelForSpellSlots = {};
        local signatureSpells = {};
        for loreIndex, loreKey in pairs(agentData.Lore) do
            local magicLoreData = _G.WWLResources.MagicLores[loreKey];
            local allSpellsForLore = {};
            ConcatTable(allSpellsForLore, magicLoreData.InnateSkill);
            ConcatTable(allSpellsForLore, magicLoreData.SignatureSpell);
            ConcatTable(allSpellsForLore, magicLoreData.Level1DefaultSpells);
            ConcatTable(allSpellsForLore, magicLoreData.Level3DefaultSpells);
            for spellIndex, spellKey in pairs(allSpellsForLore) do
                if maxLevelForSpellSlots[spellIndex] == nil then
                    maxLevelForSpellSlots[spellIndex] = 1;
                end
                -- We change generation behaviour slightly if it is a signature spell
                if Contains(magicLoreData.SignatureSpell, spellKey) then
                    signatureSpells[spellKey] = true;
                end
                local effectsForSpell = characterSkillLevelToEffectsTable:GetRowsMatchingColumnValues("character_skill_key", { spellKey, }, characterSkillEffectsMatchingLore);
                for index, effectData in pairs(effectsForSpell) do
                    local effectLevel = characterSkillLevelToEffectsTable:GetColumnValueForRow(effectData, 'level');
                    if tonumber(effectLevel) > maxLevelForSpellSlots[spellIndex] then
                        maxLevelForSpellSlots[spellIndex] = tonumber(effectLevel);
                    end
                end
            end
            agentLoresData[loreKey] = allSpellsForLore;
        end
        local addedKeys = {};
        for loreKey, allSpellsForLore in pairs(agentLoresData) do
            -- Then we make the link the effects for the custom skills by coping existing character skills
            local characterSkillEffectsMatchingLore = characterSkillLevelToEffectsTable:GetRowsMatchingColumnValues("character_skill_key", allSpellsForLore);
            -- Now we know the max level for the slot, so we can generate
            for spellIndex, spellKey in pairs(allSpellsForLore) do
                -- Now we generate loc
                local locForSpells = characterSkillLoc:GetRowsMatchingColumnValues("key", {"character_skills_localised_name_"..spellKey});
                local locSpellName = characterSkillLoc:GetColumnValueForRow(locForSpells[1], 'text');
                if temporaryCharacterSkillName[spellIndex] == nil then
                    temporaryCharacterSkillName[spellIndex] = {};
                end
                table.insert(temporaryCharacterSkillName[spellIndex], locSpellName);
                -- Now we clone each effect for the spell. This is so we can make them invisible
                local effectsForSpell = characterSkillLevelToEffectsTable:GetRowsMatchingColumnValues("character_skill_key", { spellKey, }, characterSkillEffectsMatchingLore);
                local maxLevelEffectForSpell = 0;
                for effectIndex, effectData in pairs(effectsForSpell) do
                    local effectLevel = characterSkillLevelToEffectsTable:GetColumnValueForRow(effectData, 'level');
                    local newEffectLevel = tonumber(effectLevel);
                    if signatureSpells[spellKey] == true then
                        newEffectLevel = tonumber(effectLevel) + 1;
                        if (spellKey == "wh_dlc03_skill_magic_wild_viletide"
                        or spellKey == "wh_main_skill_all_magic_fire_03_flaming_sword_of_rhuin"
                        or spellKey == "wh_main_skill_vmp_magic_vampires_02_vanhels_danse_macabre") then
                            if tonumber(effectLevel) > 1 then
                                newEffectLevel = tonumber(effectLevel);
                            else
                                newEffectLevel = 0;
                            end
                        end
                    end
                    if tonumber(newEffectLevel) > maxLevelEffectForSpell then
                        maxLevelEffectForSpell = tonumber(newEffectLevel);
                    end
                    local oldEffectKey = characterSkillLevelToEffectsTable:GetColumnValueForRow(effectData, 'effect_key');
                    local effectsTable = databaseData["effects_tables"];
                    local matchingEffect = effectsTable:GetRowsMatchingColumnValues("effect", { oldEffectKey, });
                    local clonedEffect = effectsTable:CloneRow(1, matchingEffect);
                    local newEffectKey = agentKey.."_"..oldEffectKey;
                    if addedKeys[spellIndex.."_"..newEffectKey.."_"..newEffectLevel] == nil then
                        if global_effects_cache[newEffectKey] == nil then
                            effectsTable:SetColumnValue(clonedEffect, 'effect', newEffectKey);
                            --[[if not string.match(oldEffectKey, "_enable") then
                                effectsTable:SetColumnValue(clonedEffect, 'priority', '0');
                                effectsTable:SetColumnValue(clonedEffect, 'icon', '');
                                effectsTable:SetColumnValue(clonedEffect, 'icon_negative', '');
                            else
                                local originalEffectLoc = effectsLocTables:GetRowsMatchingColumnValues("key", { "effects_description_"..oldEffectKey, });
                                local newEffectNameLoc = effectsLocTables:CloneRow(1, originalEffectLoc);
                                effectsLocTables:SetColumnValue(newEffectNameLoc, 'key', "effects_description_"..newEffectKey);
                                table.insert(effectsLocToExport, newEffectNameLoc);
                            end--]]
                            effectsTable:SetColumnValue(clonedEffect, 'priority', '0');
                            effectsTable:SetColumnValue(clonedEffect, 'icon', '');
                            effectsTable:SetColumnValue(clonedEffect, 'icon_negative', '');
                            table.insert(effectsToExport, clonedEffect);
                            global_effects_cache[newEffectKey] = true;
                        end

                        local effectBonusValueUnitAbilitiesTable = databaseData["effect_bonus_value_unit_ability_junctions_tables"];
                        local effectsBonusValuesForSpell = effectBonusValueUnitAbilitiesTable:GetRowsMatchingColumnValues("effect", { oldEffectKey, });
                        for bonusValueIndex, effectBonusValue in pairs(effectsBonusValuesForSpell) do
                            local bonusValueId = effectBonusValueUnitAbilitiesTable:GetColumnValueForRow(effectBonusValue, 'bonus_value_id');
                            local unitAbility = effectBonusValueUnitAbilitiesTable:GetColumnValueForRow(effectBonusValue, 'unit_ability');
                            if global_effect_bonus_values_cache[newEffectKey.."_"..bonusValueId.."_"..unitAbility] == nil then
                                local clonedBonusValue = effectBonusValueUnitAbilitiesTable:CloneRow(bonusValueIndex, effectsBonusValuesForSpell);
                                effectBonusValueUnitAbilitiesTable:SetColumnValue(clonedBonusValue, 'effect', newEffectKey);
                                table.insert(effectBonusValuesToExport, clonedBonusValue);
                                global_effect_bonus_values_cache[newEffectKey.."_"..bonusValueId.."_"..unitAbility] = true;
                            end
                        end
                        local clonedEffectToSkill = characterSkillLevelToEffectsTable:CloneRow(effectIndex, effectsForSpell);
                        characterSkillLevelToEffectsTable:SetColumnValue(clonedEffectToSkill, 'character_skill_key', 'wwl_'..agentKey.."_mixed_magic_"..spellIndex);
                        characterSkillLevelToEffectsTable:SetColumnValue(clonedEffectToSkill, 'effect_key', newEffectKey);
                        if signatureSpells[spellKey] == true then
                            if effectIndex == 1 then
                                local clonedBaseEffectToSkill = characterSkillLevelToEffectsTable:CloneRow(effectIndex, effectsForSpell);
                                characterSkillLevelToEffectsTable:SetColumnValue(clonedBaseEffectToSkill, 'character_skill_key', 'wwl_'..agentKey.."_mixed_magic_"..spellIndex);
                                characterSkillLevelToEffectsTable:SetColumnValue(clonedBaseEffectToSkill, 'effect_key', spellKey..'_enabled');
                                characterSkillLevelToEffectsTable:SetColumnValue(clonedBaseEffectToSkill, 'level', 1);
                                table.insert(characterSkillsToEffectsToExport, clonedBaseEffectToSkill);
                            end
                            characterSkillLevelToEffectsTable:SetColumnValue(clonedEffectToSkill, 'level', newEffectLevel);
                            maxLevelForSpellSlots[spellIndex] = tonumber(newEffectLevel);
                        end
                        if addedKeys[spellIndex.."_"..newEffectKey.."_"..newEffectLevel] == nil
                        and newEffectLevel > 0 then
                            table.insert(characterSkillsToEffectsToExport, clonedEffectToSkill);
                            addedKeys[spellIndex.."_"..newEffectKey.."_"..newEffectLevel] = true;
                        end
                    end
                end
                -- We adjust the spell level manually for signature spells
                -- because the vanilla behaviour has been changed.
                if signatureSpells[spellKey] == true then
                    maxLevelEffectForSpell = maxLevelEffectForSpell + 1;
                end
                -- If the effect level generated for the spell is less than the max in the slot
                -- Then we should duplicate the max level and fill in for max
                local maxlevelForSpellSlot = maxLevelForSpellSlots[spellIndex];
                if maxLevelEffectForSpell < maxlevelForSpellSlot then
                    local maxLevelEffectsForSpell = characterSkillLevelToEffectsTable:GetRowsMatchingColumnValues("level", { tostring(maxLevelEffectForSpell), }, effectsForSpell);
                    for additionalLevel = (maxLevelEffectForSpell + 1), maxlevelForSpellSlot do
                        for effectIndex, effectData in pairs(maxLevelEffectsForSpell) do
                            local effectLevel = additionalLevel;
                            local newEffectLevel = tonumber(effectLevel);
                            if signatureSpells[spellKey] == true then
                                newEffectLevel = tonumber(effectLevel) + 1;
                                if (spellKey == "wh_dlc03_skill_magic_wild_viletide"
                                or spellKey == "wh_main_skill_all_magic_fire_03_flaming_sword_of_rhuin"
                                or spellKey == "wh_main_skill_vmp_magic_vampires_02_vanhels_danse_macabre") then
                                    if tonumber(effectLevel) > 1 then
                                        newEffectLevel = tonumber(effectLevel);
                                    else
                                        newEffectLevel = 0;
                                    end
                                end
                            end
                            local oldEffectKey = characterSkillLevelToEffectsTable:GetColumnValueForRow(effectData, 'effect_key');
                            local effectsTable = databaseData["effects_tables"];
                            local matchingEffect = effectsTable:GetRowsMatchingColumnValues("effect", { oldEffectKey, });
                            local clonedEffect = effectsTable:CloneRow(1, matchingEffect);
                            local newEffectKey = agentKey.."_"..oldEffectKey;
                            if addedKeys[spellIndex.."_"..newEffectKey.."_"..newEffectLevel] == nil then
                                if global_effects_cache[newEffectKey] == nil then
                                    effectsTable:SetColumnValue(clonedEffect, 'effect', newEffectKey);
                                    --[[if not string.match(oldEffectKey, "_enable") then
                                        effectsTable:SetColumnValue(clonedEffect, 'priority', '0');
                                        effectsTable:SetColumnValue(clonedEffect, 'icon', '');
                                        effectsTable:SetColumnValue(clonedEffect, 'icon_negative', '');
                                    else
                                        local originalEffectLoc = effectsLocTables:GetRowsMatchingColumnValues("key", { "effects_description_"..oldEffectKey, });
                                        local newEffectNameLoc = effectsLocTables:CloneRow(1, originalEffectLoc);
                                        effectsLocTables:SetColumnValue(newEffectNameLoc, 'key', "effects_description_"..newEffectKey);
                                        table.insert(effectsLocToExport, newEffectNameLoc);
                                    end--]]
                                    effectsTable:SetColumnValue(clonedEffect, 'priority', '0');
                                    effectsTable:SetColumnValue(clonedEffect, 'icon', '');
                                    effectsTable:SetColumnValue(clonedEffect, 'icon_negative', '');
                                    table.insert(effectsToExport, clonedEffect);
                                    global_effects_cache[newEffectKey] = true;
                                end
                                local effectBonusValueUnitAbilitiesTable = databaseData["effect_bonus_value_unit_ability_junctions_tables"];
                                local effectsBonusValuesForSpell = effectBonusValueUnitAbilitiesTable:GetRowsMatchingColumnValues("effect", { oldEffectKey, });
                                for bonusValueIndex, effectBonusValue in pairs(effectsBonusValuesForSpell) do
                                    local bonusValueId = effectBonusValueUnitAbilitiesTable:GetColumnValueForRow(effectBonusValue, 'bonus_value_id');
                                    local unitAbility = effectBonusValueUnitAbilitiesTable:GetColumnValueForRow(effectBonusValue, 'unit_ability');
                                    if global_effect_bonus_values_cache[newEffectKey.."_"..bonusValueId.."_"..unitAbility] == nil then
                                        local clonedBonusValue = effectBonusValueUnitAbilitiesTable:CloneRow(bonusValueIndex, effectsBonusValuesForSpell);
                                        effectBonusValueUnitAbilitiesTable:SetColumnValue(clonedBonusValue, 'effect', newEffectKey);
                                        table.insert(effectBonusValuesToExport, clonedBonusValue);
                                        global_effect_bonus_values_cache[newEffectKey.."_"..bonusValueId.."_"..unitAbility] = true;
                                    end
                                end
                                local clonedEffectToSkill = characterSkillLevelToEffectsTable:CloneRow(effectIndex, maxLevelEffectsForSpell);
                                characterSkillLevelToEffectsTable:SetColumnValue(clonedEffectToSkill, 'character_skill_key', 'wwl_'..agentKey.."_mixed_magic_"..spellIndex);
                                characterSkillLevelToEffectsTable:SetColumnValue(clonedEffectToSkill, 'effect_key', newEffectKey);
                                characterSkillLevelToEffectsTable:SetColumnValue(clonedEffectToSkill, 'level', newEffectLevel);
                                if signatureSpells[spellKey] == true then
                                    if effectIndex == 1 then
                                        local clonedBaseEffectToSkill = characterSkillLevelToEffectsTable:CloneRow(effectIndex, maxLevelEffectsForSpell);
                                        characterSkillLevelToEffectsTable:SetColumnValue(clonedBaseEffectToSkill, 'character_skill_key', 'wwl_'..agentKey.."_mixed_magic_"..spellIndex);
                                        characterSkillLevelToEffectsTable:SetColumnValue(clonedBaseEffectToSkill, 'effect_key', spellKey..'_enabled');
                                        characterSkillLevelToEffectsTable:SetColumnValue(clonedBaseEffectToSkill, 'level', 1);
                                        table.insert(characterSkillsToEffectsToExport, clonedBaseEffectToSkill);
                                    end
                                      characterSkillLevelToEffectsTable:SetColumnValue(clonedEffectToSkill, 'level', newEffectLevel);
                                end
                                if addedKeys[spellIndex.."_"..newEffectKey.."_"..newEffectLevel] == nil
                                and newEffectLevel > 0 then
                                    table.insert(characterSkillsToEffectsToExport, clonedEffectToSkill);
                                    addedKeys[spellIndex.."_"..newEffectKey.."_"..newEffectLevel] = true;
                                end
                            end
                        end
                    end
                end
            end
            -- We only need to add this effect once
            for spellIndex, maxLevelForSpellSlot in pairs(maxLevelForSpellSlots) do
                if maxLevelForSpellSlot > 1 then
                    for spellLevel = 2, maxLevelForSpellSlot do
                        if addedKeys[spellIndex.."_wwl_increased_spell_effects_"..spellLevel] == nil then
                            local increasedSpellEffects = {};
                            characterSkillLevelToEffectsTable:SetColumnValue(increasedSpellEffects, 'character_skill_key', 'wwl_'..agentKey.."_mixed_magic_"..spellIndex);
                            characterSkillLevelToEffectsTable:SetColumnValue(increasedSpellEffects, 'effect_key', "wwl_increased_spell_effects");
                            characterSkillLevelToEffectsTable:SetColumnValue(increasedSpellEffects, 'effect_scope', "character_to_character_own");
                            characterSkillLevelToEffectsTable:SetColumnValue(increasedSpellEffects, 'level', spellLevel);
                            characterSkillLevelToEffectsTable:SetColumnValue(increasedSpellEffects, 'value', "1");
                            table.insert(characterSkillsToEffectsToExport, increasedSpellEffects);
                            addedKeys[spellIndex.."_wwl_increased_spell_effects_"..spellLevel] = true;
                        end
                    end
                end
            end
        end
        for i = 1, 7 do
            if temporaryCharacterSkillName[i] ~= nil then
                local textForSkill = "";
                local skillNameText = "";
                if i == 1 then
                    skillNameText = "Innate Spells";
                elseif i == 2 then
                    skillNameText = "Signature Spells";
                else
                    skillNameText = "Spell Slot "..tostring(i - 2);
                end
                for j = 1, #temporaryCharacterSkillName[i] do
                    if j ~= #temporaryCharacterSkillName[i] then
                        textForSkill = textForSkill..temporaryCharacterSkillName[i][j]..", ";
                    else
                        textForSkill = textForSkill..temporaryCharacterSkillName[i][j];
                    end
                end
                characterSkillLoc:SetColumnValue(newCharacterSkillsLoc[i * 2], 'text', skillNameText);
                characterSkillLoc:SetColumnValue(newCharacterSkillsLoc[i * 2 - 1], 'text', textForSkill);
            end
        end
        local characterSkillsAndLinks = GenerateSkillTreeForAgent(databaseData, nil, agentKey, agentData, { "wh_main_skill_all_magic_all_06_evasion", "wh_main_skill_all_magic_all_07_earthing", "wh_main_skill_all_magic_all_08_power_drain",  "wh_dlc06_skill_dwf_runelord_self_rune_of_hearth_&_home", "wh_main_skill_all_magic_all_11_arcane_conduit", "wh2_main_skill_magic_dark_flock_of_doom_teclis", "wh2_main_skill_all_magic_high_09_arcane_unforging_lord", "wh3_main_skill_tze_all_magic_prismatic_plurality", });
        ConcatTable(characterSkillNodesToExport, characterSkillsAndLinks["character_skill_nodes_tables"]);
        ConcatTable(characterSkillNodeSetItemsToExport, characterSkillsAndLinks["character_skill_node_set_items_tables"]);
        ConcatTable(characterSkillNodeLinksToExport, characterSkillsAndLinks["character_skill_node_links_tables"]);
        ConcatTable(characterSkillsToEffectsToExport, characterSkillsAndLinks["character_skill_level_to_effects_junctions_tables"]);
        ConcatTable(characterSkillsToExport, newCharacterSkills);
        ConcatTable(characterSkillLocToExport, newCharacterSkillsLoc);
    end

    local effectTables = databaseData["effects_tables"];
    local finalisedEffects = effectTables:PrepareRowsForOutput(effectsToExport);
    local finalisedEffectsLoc = effectsLocTables:PrepareRowsForOutput(effectsLocToExport);
    local effectBonusValuesTables = databaseData["effect_bonus_value_unit_ability_junctions_tables"];
    local finalisedEffectBonusValues = effectBonusValuesTables:PrepareRowsForOutput(effectBonusValuesToExport);
    local characterSkillsTable = databaseData["character_skills_tables"];
    local finalisedCharacterSkills = characterSkillsTable:PrepareRowsForOutput(characterSkillsToExport);
    local characterSkillNodesTable = databaseData["character_skill_nodes_tables"];
    local finalisedCharacterSkillNodes = characterSkillNodesTable:PrepareRowsForOutput(characterSkillNodesToExport);
    local characterSkillNodeSetItemsTable = databaseData["character_skill_node_set_items_tables"];
    local finalisedCharacterSkillNodeSetItems = characterSkillNodeSetItemsTable:PrepareRowsForOutput(characterSkillNodeSetItemsToExport);
    local characterSkillEffectsTable = databaseData["character_skill_level_to_effects_junctions_tables"];
    local finalisedcharacterSkillEffects = characterSkillEffectsTable:PrepareRowsForOutput(characterSkillsToEffectsToExport);
    local characterSkillNodeLinksTable = databaseData["character_skill_node_links_tables"];
    local finalisedCharacterSkillNodeLinks = characterSkillNodeLinksTable:PrepareRowsForOutput(characterSkillNodeLinksToExport);
    local characterSkillLocTable = databaseData["character_skills_loc"];
    local finalisedCharacterSkillLoc = characterSkillLocTable:PrepareRowsForOutput(characterSkillLocToExport);
    return {
        effects_tables = finalisedEffects,
        effects_loc = finalisedEffectsLoc,
        effect_bonus_value_unit_ability_junctions_tables = finalisedEffectBonusValues,
        character_skills_tables = finalisedCharacterSkills,
        character_skill_nodes_tables = finalisedCharacterSkillNodes,
        character_skill_node_set_items_tables = finalisedCharacterSkillNodeSetItems,
        character_skill_node_links_tables = finalisedCharacterSkillNodeLinks,
        character_skill_level_to_effects_junctions_tables = finalisedcharacterSkillEffects,
        character_skills_loc = finalisedCharacterSkillLoc,
    };
end