function CreateDBData(databaseData)
    print("\n\nCreating DB Data...");
    -- Load our existing resources based on the files specified
    local signatureSkills = GenerateWWLSignatureSkills(databaseData);
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
                        local clonedSkill = characterSkillsTables:CloneRow(1, characterSkillsMatchingLore);
                        characterSkillsTables:SetColumnValue(clonedSkill, 'key', "wwl_"..spellKey);
                        characterSkillsTables:SetColumnValue(clonedSkill, 'localised_description', "");
                        table.insert(characterSkillsToExport, clonedSkill);

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
                            characterSkillLevelToEffectsTable:SetColumnValue(clonedEffect, 'character_skill_key', "wwl_"..spellKey);
                            characterSkillLevelToEffectsTable:SetColumnValue(clonedEffect, 'level', tonumber(skillLevelString[1]) + 1);
                            table.insert(characterSkillsToEffectsToExport, clonedEffect);
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
        for subcultureKey, subcultureAgents in pairs(_G.WWLResources.WizardData) do
            for agentKey, agentData in pairs(subcultureAgents) do
                if type(agentData.Lore) == "string"
                and groupKey == agentData.Lore then
                    print("Found agent: "..agentKey.." for Lore: "..groupKey);
                    agentsWithMatchingLore[agentKey] = agentData;
                    table.insert(agentKeysWithMatchingLore, agentKey);
                end
            end
        end

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
            ConcatTable(characterSkillNodeLinksToExport, characterSkillsAndLinks["character_skill_node_links_tables"]);
            ConcatTable(characterSkillLevelToEffectsToExport, characterSkillsAndLinks["character_skill_level_to_effects_junctions_tables"]);
        end
    end
    local characterSkillNodesTable = databaseData["character_skill_nodes_tables"];
    local finalisedCharacterSkillNodes = characterSkillNodesTable:PrepareRowsForOutput(characterSkillNodesToExport);
    local characterSkillNodeLinksTable = databaseData["character_skill_node_links_tables"];
    local finalisedCharacterSkillNodeLinks = characterSkillNodeLinksTable:PrepareRowsForOutput(characterSkillNodeLinksToExport);
    local characterSkillLevelToEffectsTable = databaseData["character_skill_level_to_effects_junctions_tables"];
    local finalisedCharacterSkillLevelToEffects = characterSkillLevelToEffectsTable:PrepareRowsForOutput(characterSkillLevelToEffectsToExport);
    return {
        character_skill_nodes_tables = finalisedCharacterSkillNodes,
        character_skill_node_links_tables = finalisedCharacterSkillNodeLinks,
        character_skill_level_to_effects_junctions_tables = finalisedCharacterSkillLevelToEffects,
    };
end

function GenerateSkillTreeForAgent(databaseData, magicLoreData, agentKey, agentData, characterSkillKeys)
    local characterSkillNodesLinksTable = databaseData["character_skill_node_links_tables"];
    local characterSkillSetsTable = databaseData["character_skill_node_sets_tables"];
    local characterSkillNodesTable = databaseData["character_skill_nodes_tables"];
    local agentSkillSet = characterSkillSetsTable:GetRowsMatchingColumnValues("agent_subtype_key", { agentKey, });
    local agentSkillSetKeys = characterSkillSetsTable:GetColumnValuesForRows("key", agentSkillSet);
    local allSkillNodesForCharacter = characterSkillNodesTable:GetRowsMatchingColumnValues("character_skill_node_set_key", agentSkillSetKeys);
    local knownAgentSkillNodes = characterSkillNodesTable:GetRowsMatchingColumnValues("character_skill_key", characterSkillKeys, allSkillNodesForCharacter);
    local rowIndents = characterSkillNodesTable:GetUniqueColumnValuesForRows("indent", knownAgentSkillNodes);
    local rowIndent = rowIndents[1];
    if rowIndent == nil then
        print("Agent: "..agentKey.." Is missing data");
        return {
            character_skill_nodes_tables = {},
            character_skill_node_links_tables = {},
            character_skill_level_to_effects_junctions_tables = {},
        };
    end
    if #rowIndents > 1 then
        if rowIndents[1] == '1.0'
        or rowIndents[1] == '0.0' then
            rowIndent = rowIndents[2];
        end
        print("Agent: "..agentKey.." Has abilities on multiple rows");
    end
    local newAgentSkills = {};
    local agentSkillNodesOnRow = characterSkillNodesTable:GetRowsMatchingColumnValues("indent", {rowIndent, }, allSkillNodesForCharacter);
    -- First we disable all the vanilla skills
    for skillNodeIndex, skillNodeRow in pairs(agentSkillNodesOnRow) do
        local clonedRow = characterSkillNodesTable:CloneRow(skillNodeIndex, agentSkillNodesOnRow);
        characterSkillNodesTable:SetColumnValue(clonedRow, 'character_skill_key', 'wwl_disable_dummy');
        characterSkillNodesTable:SetColumnValue(clonedRow, 'tier', '99');
        characterSkillNodesTable:SetColumnValue(clonedRow, 'visible_in_ui', 'false');
        table.insert(newAgentSkills, clonedRow);
    end
    -- Then we create new skills

    local agentSkillSetKey = agentSkillSetKeys[1];
    local newAgentLinkSkills = {};
    local clonedMagicLoreSkills = {};
    local defaultWizardLevelCharacterSkill = "wwl_skill_wizard_level_0"..tostring(agentData.DefaultWizardLevel);
    ConcatTable(clonedMagicLoreSkills, { defaultWizardLevelCharacterSkill, });
    if magicLoreData == nil then
        for i = 1, 7 do
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
        local originalLoreMasterSkill = characterSkillNodesTable:GetRowsMatchingColumnValues("character_skill_key", {agentData.LoremasterCharacterSkillKey}, allSkillNodesForCharacter);
        -- If this is a vanilla skill, hide it
        if next(originalLoreMasterSkill) then
            local clonedLoremasterSkillRow = characterSkillNodesTable:CloneRow(1, originalLoreMasterSkill);
            characterSkillNodesTable:SetColumnValue(clonedLoremasterSkillRow, 'character_skill_key', 'wwl_disable_dummy');
            characterSkillNodesTable:SetColumnValue(clonedLoremasterSkillRow, 'tier', 99);
            characterSkillNodesTable:SetColumnValue(clonedLoremasterSkillRow, 'visible_in_ui', 'false');
            table.insert(newAgentSkills, clonedLoremasterSkillRow);
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
        else
            upgradedSkillKey = "wwl_skill_wizard_level_0"..tostring(agentData.DefaultWizardLevel + 1);
        end
    end
    -- Common skill arrangement for everyone
    for characterSkillIndex, characterSkillKey in pairs(clonedMagicLoreSkills) do
        local newCharacterSkillNodeRow = {};
        startingTier = startingTier + 1;
        CreateWWLCharacterSkillNodeRow(characterSkillNodesTable,
        newCharacterSkillNodeRow,
            "wwl_character_skill_node_"..agentKey.."_"..characterSkillKey,
            characterSkillKey,
            agentSkillSetKey,
            rowIndent,
            startingTier,
            1,
            0
        );
        table.insert(newAgentSkills, newCharacterSkillNodeRow);

        if characterSkillKey ~= defaultWizardLevelCharacterSkill then
            -- Link the current skill to the default node
            local newCharacterSkillLinkNodeRowDefault = {};
            CreateWWLCharacterSkillNodeLinkRow(characterSkillNodesLinksTable,
            newCharacterSkillLinkNodeRowDefault,
            "wwl_character_skill_node_"..agentKey.."_"..defaultWizardLevelCharacterSkill,
            "wwl_character_skill_node_"..agentKey.."_"..characterSkillKey,
            "REQUIRED");
            table.insert(newAgentLinkSkills, newCharacterSkillLinkNodeRowDefault);
            -- Link the current skill to the upgraded node
            local newCharacterSkillLinkNodeRowUpgraded = {};
            CreateWWLCharacterSkillNodeLinkRow(characterSkillNodesLinksTable,
            newCharacterSkillLinkNodeRowUpgraded,
            "wwl_character_skill_node_"..agentKey.."_"..characterSkillKey,
            "wwl_character_skill_node_"..agentKey.."_"..upgradedSkillKey,
            "SUBSET_REQUIRED");
            table.insert(newAgentLinkSkills, newCharacterSkillLinkNodeRowUpgraded);
        end
    end
    -- Upgraded wizard level
    local upgradedWizardLevel = {};
    startingTier = startingTier + 1;
    CreateWWLCharacterSkillNodeRow(characterSkillNodesTable,
            upgradedWizardLevel,
            "wwl_character_skill_node_"..agentKey.."_"..upgradedSkillKey,
            upgradedSkillKey,
            agentSkillSetKey,
            rowIndent,
            startingTier,
            0,
            requiredParentsForUpgrade
        );
    table.insert(newAgentSkills, upgradedWizardLevel);
    if agentData.DefaultWizardLevel < 3 then
        -- Level 3 skills
        for characterSkillIndex, characterSkillKey in pairs(magicLoreData.Level3DefaultSpells) do
            local newRow = {};
            startingTier = startingTier + 1;
            CreateWWLCharacterSkillNodeRow(characterSkillNodesTable,
                newRow,
                "wwl_character_skill_node_"..agentKey.."_"..characterSkillKey,
                characterSkillKey,
                agentSkillSetKey,
                rowIndent,
                startingTier,
                0,
                0
            );
            table.insert(newAgentSkills, newRow);
            -- Add the upgraded skill as the parent of the level 3 skills
            local newSkillLink = {};
            CreateWWLCharacterSkillNodeLinkRow(characterSkillNodesLinksTable,
            newSkillLink,
            "wwl_character_skill_node_"..agentKey.."_"..upgradedSkillKey,
            "wwl_character_skill_node_"..agentKey.."_"..characterSkillKey,
            "REQUIRED");
            table.insert(newAgentLinkSkills, newSkillLink);
            if agentKey == "vmp_lord" then
                local vmpLordSkillLink = {};
                -- Link the bonus skill to the final node
                CreateWWLCharacterSkillNodeLinkRow(characterSkillNodesLinksTable,
                vmpLordSkillLink,
                "wwl_character_skill_node_"..agentKey.."_"..characterSkillKey,
                "wwl_character_skill_node_"..agentKey.."_wwl_skill_wizard_level_03",
                "REQUIRED");
                table.insert(newAgentLinkSkills, vmpLordSkillLink);
            end
        end
        if agentKey == "vmp_lord" then
            local level03VmpLord = {};
            startingTier = startingTier + 1;
            CreateWWLCharacterSkillNodeRow(characterSkillNodesTable,
                level03VmpLord,
                "wwl_character_skill_node_"..agentKey.."_wwl_skill_wizard_level_03",
                "wwl_skill_wizard_level_03",
                agentSkillSetKey,
                rowIndent,
                startingTier,
                0,
                6
            );
            upgradedSkillKey = "wwl_skill_wizard_level_03";
            table.insert(newAgentSkills, level03VmpLord);
        end
    end
    -- Bonus skills
    local conduitKey = "";
    local bonusSkills = {
        "wh_main_skill_all_magic_all_06_evasion",
        "wh_main_skill_all_magic_all_07_earthing",
        "wh_main_skill_all_magic_all_08_power_drain",
    };
    if agentKey == "wh2_main_def_morathi"
    or agentKey == "wh2_dlc11_vmp_bloodline_necrarch"
    or agentKey == "wh2_main_lzd_lord_mazdamundi"
    or string.match(agentKey, "slann")
    or string.match(agentKey, "archmage") then
        conduitKey = "wh2_dlc14_skilll_all_magic_all_greater_arcane_conduit";
    elseif agentKey == "wh2_main_hef_teclis" then
        conduitKey = "wh2_main_skill_hef_teclis_flames_of_the_phoenix";
    else
        conduitKey = "wh_main_skill_all_magic_all_11_arcane_conduit";
    end
    table.insert(bonusSkills, conduitKey);
    for characterSkillIndex, characterSkillKey in pairs(bonusSkills) do
        local newBonusSkillRow = {};
        local newSkillLink = {};
        startingTier = startingTier + 1;
        local bonusSkillNumberOfParents = 0;
        if characterSkillKey ~= conduitKey then
            -- Link the bonus skills to the ugpraded node
            CreateWWLCharacterSkillNodeLinkRow(characterSkillNodesLinksTable,
            newSkillLink,
            "wwl_character_skill_node_"..agentKey.."_"..upgradedSkillKey,
            "wwl_character_skill_node_"..agentKey.."_"..characterSkillKey,
            "REQUIRED");
            table.insert(newAgentLinkSkills, newSkillLink);
            newSkillLink = {};
            -- Link the bonus skill to the final node
            CreateWWLCharacterSkillNodeLinkRow(characterSkillNodesLinksTable,
            newSkillLink,
            "wwl_character_skill_node_"..agentKey.."_"..characterSkillKey,
            "wwl_character_skill_node_"..agentKey.."_"..conduitKey,
            "REQUIRED");
            table.insert(newAgentLinkSkills, newSkillLink);
        end
        CreateWWLCharacterSkillNodeRow(characterSkillNodesTable,
        newBonusSkillRow,
            "wwl_character_skill_node_"..agentKey.."_"..characterSkillKey,
            characterSkillKey,
            agentSkillSetKey,
            rowIndent,
            startingTier,
            0,
            bonusSkillNumberOfParents
        );
        table.insert(newAgentSkills, newBonusSkillRow);
    end
    if agentKey == "vmp_lord" then
        local level04VmpLord = {};
        startingTier = startingTier + 1;
        CreateWWLCharacterSkillNodeRow(characterSkillNodesTable,
            level04VmpLord,
            "wwl_character_skill_node_"..agentKey.."_wwl_skill_wizard_level_04",
            "wwl_skill_wizard_level_04",
            agentSkillSetKey,
            rowIndent,
            startingTier,
            0,
            1
        );
        table.insert(newAgentSkills, level04VmpLord);
        local newSkillLink = {};
        -- Link the bonus skill to the final node
        CreateWWLCharacterSkillNodeLinkRow(characterSkillNodesLinksTable,
        newSkillLink,
        "wwl_character_skill_node_"..agentKey.."_"..conduitKey,
        "wwl_character_skill_node_"..agentKey.."_wwl_skill_wizard_level_04",
        "REQUIRED");
        table.insert(newAgentLinkSkills, newSkillLink);
    end
    return {
        character_skill_nodes_tables = newAgentSkills,
        character_skill_node_links_tables = newAgentLinkSkills,
        character_skill_level_to_effects_junctions_tables = newCharacterSkillLevelToEffects,
    };
end

function CreateWWLCharacterSkillNodeRow(table, row, key, characterSkillKey, agentSkillSetKey, indent, tier, pointsOnCreation, numParents)
    table:SetColumnValue(row, 'campaign_key', '');
    table:SetColumnValue(row, 'character_skill_key', characterSkillKey);
    table:SetColumnValue(row, 'character_skill_node_set_key', agentSkillSetKey);
    table:SetColumnValue(row, 'faction_key', '');
    table:SetColumnValue(row, 'indent', indent);
    table:SetColumnValue(row, 'key', key);
    table:SetColumnValue(row, 'tier', tier);
    table:SetColumnValue(row, 'subculture', '');
    table:SetColumnValue(row, 'points_on_creation', pointsOnCreation);
    table:SetColumnValue(row, 'required_num_parents', numParents);
    table:SetColumnValue(row, 'visible_in_ui', 'true');
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
function OutputToFile(modifiedDBs, prefix, suffix, keepDataExtension)
    print("\n\nStarting file output...");
    for fileName, file in pairs(modifiedDBs) do
        if prefix ~= nil then
            fileName = prefix..fileName;
        end
        if suffix ~= nil then
            fileName = fileName..suffix;
        end
        if keepDataExtension ~= true then
            fileName = fileName:gsub('_data__', '');
        end
        local iostream = assert(io.open("SkillTreeGenerator\\out\\"..fileName..".tsv", "w+"));
        print("Writing "..fileName.." to disk");
        for rowKey, row in pairs(file) do
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

function GenerateWWLEffects(databaseData)
    local effectsToExport = {};
    local effectBonusValuesToExport = {};
    local effectTables = databaseData["effects_tables"];
    local specialAbilityGroupsTable = databaseData["special_ability_groups_tables"];
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
                local characterSkillLevelToEffectsTable = databaseData["character_skill_level_to_effects_junctions_tables"];
                local effectsMatchingCharacterSkill = characterSkillLevelToEffectsTable:GetRowsMatchingColumnValues("character_skill_key", {spellKey});
                local effectKeysMatchingCharacterSkill = characterSkillLevelToEffectsTable:GetColumnValuesForRows("effect_key", effectsMatchingCharacterSkill);
                local matchingSpellEnabledKeys = effectBonusValueAbilityJunctionsTable:GetRowsMatchingColumnValues("effect", effectKeysMatchingCharacterSkill);
                local matchingSpellEnabledKey = effectBonusValueAbilityJunctionsTable:GetColumnValueForIndex(1, 'unit_ability', matchingSpellEnabledKeys);
                local newEnabledEffectRow = {};
                effectTables:SetColumnValue(newEnabledEffectRow, 'effect', spellKey.."_enabled");
                effectTables:SetColumnValue(newEnabledEffectRow, 'icon', '');
                effectTables:SetColumnValue(newEnabledEffectRow, 'priority', '0');
                effectTables:SetColumnValue(newEnabledEffectRow, 'icon_negative', '');
                effectTables:SetColumnValue(newEnabledEffectRow, 'category', 'both');
                effectTables:SetColumnValue(newEnabledEffectRow, 'is_positive_value_good', 'true');
                table.insert(effectsToExport, newEnabledEffectRow);
                local clonedBonusValueRow = effectBonusValueAbilityJunctionsTable:CloneRow(1, enabledSpellEffects);
                effectBonusValueAbilityJunctionsTable:SetColumnValue(clonedBonusValueRow, 'effect', spellKey.."_enabled");
                effectBonusValueAbilityJunctionsTable:SetColumnValue(clonedBonusValueRow, 'bonus_value_id', "enable");
                effectBonusValueAbilityJunctionsTable:SetColumnValue(clonedBonusValueRow, 'unit_ability', matchingSpellEnabledKey);
                table.insert(effectBonusValuesToExport, clonedBonusValueRow);
                local newDisabledEffectRow = {};
                effectTables:SetColumnValue(newDisabledEffectRow, 'effect', spellKey.."_disabled");
                effectTables:SetColumnValue(newDisabledEffectRow, 'icon', '');
                effectTables:SetColumnValue(newDisabledEffectRow, 'priority', '0');
                effectTables:SetColumnValue(newDisabledEffectRow, 'icon_negative', '');
                effectTables:SetColumnValue(newDisabledEffectRow, 'category', 'both');
                effectTables:SetColumnValue(newDisabledEffectRow, 'is_positive_value_good', 'false');
                table.insert(effectsToExport, newDisabledEffectRow);
                local clonedBonusValueRow = effectBonusValueAbilityJunctionsTable:CloneRow(1, enabledSpellEffects);
                effectBonusValueAbilityJunctionsTable:SetColumnValue(clonedBonusValueRow, 'effect', spellKey.."_disabled");
                effectBonusValueAbilityJunctionsTable:SetColumnValue(clonedBonusValueRow, 'bonus_value_id', "disable");
                effectBonusValueAbilityJunctionsTable:SetColumnValue(clonedBonusValueRow, 'unit_ability', matchingSpellEnabledKey);
                table.insert(effectBonusValuesToExport, clonedBonusValueRow);
            end
        end
    end
    local finalisedEffects = effectTables:PrepareRowsForOutput(effectsToExport);
    local effectBonusValuesTables = databaseData["effect_bonus_value_unit_ability_junctions_tables"];
    local finalisedEffectBonusValues = effectBonusValuesTables:PrepareRowsForOutput(effectBonusValuesToExport);
    return {
        effects_tables = finalisedEffects,
        effect_bonus_value_unit_ability_junctions_tables = finalisedEffectBonusValues,
    };
end

function GenerateMultiLoreCharacterSkills(databaseData)
    local multiLoreCasters = {};
    for subcultureKey, subcultureCasters in pairs(_G.WWLResources.WizardData) do
        for agentKey, agentData in pairs(subcultureCasters) do
            if type(agentData.Lore) == "table" then
                multiLoreCasters[agentKey] = agentData;
            end
        end
    end
    local effectsToExport = {};
    local effectBonusValuesToExport = {};
    local characterSkillsToExport = {};
    local characterSkillsToEffectsToExport = {};
    local characterSkillNodesToExport = {};
    local characterSkillNodeLinksToExport = {};
    local characterSkillLocToExport = {};
    local locToExport = {};
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
        for loreIndex, loreKey in pairs(agentData.Lore) do
            local magicLoreData = _G.WWLResources.MagicLores[loreKey];
            local allSpellsForLore = {};
            ConcatTable(allSpellsForLore, magicLoreData.InnateSkill);
            ConcatTable(allSpellsForLore, magicLoreData.SignatureSpell);
            ConcatTable(allSpellsForLore, magicLoreData.Level1DefaultSpells);
            ConcatTable(allSpellsForLore, magicLoreData.Level3DefaultSpells);
            -- Then we make the link the effects for the custom skills by coping existing character skills
            local characterSkillLevelToEffectsTable = databaseData["character_skill_level_to_effects_junctions_tables"];
            local characterSkillEffectsMatchingLore = characterSkillLevelToEffectsTable:GetRowsMatchingColumnValues("character_skill_key", allSpellsForLore);
            local maxLevelForSpellSlots = {};
            for spellIndex, spellKey in pairs(allSpellsForLore) do
                local lastAddedSignatureSpellLevel = 1;
                if maxLevelForSpellSlots[spellIndex] == nil then
                    maxLevelForSpellSlots[spellIndex] = 1;
                end
                -- Now we generate loc
                local locForSpells = characterSkillLoc:GetRowsMatchingColumnValues("key", {"character_skills_localised_name_"..spellKey});
                local locSpellName = characterSkillLoc:GetColumnValueForRow(locForSpells[1], 'text');
                if temporaryCharacterSkillName[spellIndex] == nil then
                    temporaryCharacterSkillName[spellIndex] = {};
                end
                table.insert(temporaryCharacterSkillName[spellIndex], locSpellName);
                -- Now we clone each effect for the spell. This is so we can make them invisible
                local effectsForSpell = characterSkillLevelToEffectsTable:GetRowsMatchingColumnValues("character_skill_key", { spellKey, }, characterSkillEffectsMatchingLore);
                for effectIndex, effectData in pairs(effectsForSpell) do
                    local effectLevel = characterSkillLevelToEffectsTable:GetColumnValueForRow(effectData, 'level');
                    if tonumber(effectLevel) > maxLevelForSpellSlots[spellIndex] then
                        maxLevelForSpellSlots[spellIndex] = tonumber(effectLevel);
                    end
                    local oldEffectKey = characterSkillLevelToEffectsTable:GetColumnValueForRow(effectData, 'effect_key');
                    local effectsTable = databaseData["effects_tables"];
                    local matchingEffect = effectsTable:GetRowsMatchingColumnValues("effect", { oldEffectKey, });
                    local clonedEffect = effectsTable:CloneRow(1, matchingEffect);
                    local newEffectKey = agentKey.."_"..oldEffectKey;
                    effectsTable:SetColumnValue(clonedEffect, 'effect', newEffectKey);
                    if not string.match(oldEffectKey, "_enable") then
                        effectsTable:SetColumnValue(clonedEffect, 'priority', '0');
                    end
                    table.insert(effectsToExport, clonedEffect);
                    local effectBonusValueUnitAbilitiesTable = databaseData["effect_bonus_value_unit_ability_junctions_tables"];
                    local effectsBonusValuesForSpell = effectBonusValueUnitAbilitiesTable:GetRowsMatchingColumnValues("effect", { oldEffectKey, });
                    for bonusValueIndex, effectBonusValue in pairs(effectsBonusValuesForSpell) do
                        local clonedBonusValue = effectBonusValueUnitAbilitiesTable:CloneRow(bonusValueIndex, effectsBonusValuesForSpell);
                        effectBonusValueUnitAbilitiesTable:SetColumnValue(clonedBonusValue, 'effect', newEffectKey);
                        table.insert(effectBonusValuesToExport, clonedBonusValue);
                    end
                    local clonedEffectToSkill = characterSkillLevelToEffectsTable:CloneRow(effectIndex, effectsForSpell);
                    characterSkillLevelToEffectsTable:SetColumnValue(clonedEffectToSkill, 'character_skill_key', 'wwl_'..agentKey.."_mixed_magic_"..spellIndex);
                    characterSkillLevelToEffectsTable:SetColumnValue(clonedEffectToSkill, 'effect_key', newEffectKey);
                    if Contains(magicLoreData.SignatureSpell, spellKey) then
                        if effectIndex == 1 then
                            local clonedBaseEffectToSkill = characterSkillLevelToEffectsTable:CloneRow(effectIndex, effectsForSpell);
                            characterSkillLevelToEffectsTable:SetColumnValue(clonedBaseEffectToSkill, 'character_skill_key', 'wwl_'..agentKey.."_mixed_magic_"..spellIndex);
                            characterSkillLevelToEffectsTable:SetColumnValue(clonedBaseEffectToSkill, 'effect_key', spellKey..'_enabled');
                            characterSkillLevelToEffectsTable:SetColumnValue(clonedBaseEffectToSkill, 'level', 1);
                            table.insert(characterSkillsToEffectsToExport, clonedBaseEffectToSkill);
                        end
                        local newEffectLevel = tonumber(effectLevel) + 1;
                        -- Probably not needed but will confirm
                        --[[if newEffectLevel > lastAddedSignatureSpellLevel then
                            local clonedBaseEffectToSkill = characterSkillLevelToEffectsTable:CloneRow(effectIndex, effectsForSpell);
                            characterSkillLevelToEffectsTable:SetColumnValue(clonedBaseEffectToSkill, 'character_skill_key', 'wwl_'..agentKey.."_mixed_magic_"..spellIndex);
                            characterSkillLevelToEffectsTable:SetColumnValue(clonedBaseEffectToSkill, 'effect_key', spellKey..'_enabled');
                            characterSkillLevelToEffectsTable:SetColumnValue(clonedBaseEffectToSkill, 'level', newEffectLevel);
                            table.insert(characterSkillsToEffectsToExport, clonedBaseEffectToSkill);
                            lastAddedSignatureSpellLevel = newEffectLevel;
                        end--]]
                        characterSkillLevelToEffectsTable:SetColumnValue(clonedEffectToSkill, 'level', newEffectLevel);
                        maxLevelForSpellSlots[spellIndex] = newEffectLevel;
                    end
                    table.insert(characterSkillsToEffectsToExport, clonedEffectToSkill);
                end
            end
            -- We only need to add this effect once
            for spellIndex, maxLevelForSpellSlot in pairs(maxLevelForSpellSlots) do
                if maxLevelForSpellSlot > 1 then
                    for spellLevel = 2, maxLevelForSpellSlot do
                        local increasedSpellEffects = {};
                        characterSkillLevelToEffectsTable:SetColumnValue(increasedSpellEffects, 'character_skill_key', 'wwl_'..agentKey.."_mixed_magic_"..spellIndex);
                        characterSkillLevelToEffectsTable:SetColumnValue(increasedSpellEffects, 'effect_key', "wwl_increased_spell_effects");
                        characterSkillLevelToEffectsTable:SetColumnValue(increasedSpellEffects, 'effect_scope', "character_to_character_own");
                        characterSkillLevelToEffectsTable:SetColumnValue(increasedSpellEffects, 'level', spellLevel);
                        characterSkillLevelToEffectsTable:SetColumnValue(increasedSpellEffects, 'value', "1");
                        table.insert(characterSkillsToEffectsToExport, increasedSpellEffects);
                    end
                end
            end
        end
        for i = 1, 7 do
            local textForSkill = "";
            for j = 1, #temporaryCharacterSkillName[i] do
                if j ~= #temporaryCharacterSkillName[i] then
                    textForSkill = textForSkill..temporaryCharacterSkillName[i][j]..", ";
                else
                    textForSkill = textForSkill..temporaryCharacterSkillName[i][j];
                end
            end
            local skillNameText = "";
            if i == 1 then
                skillNameText = "Innate Spells";
            elseif i == 2 then
                skillNameText = "Signature Spells";
            else
                skillNameText = "Spell Slot "..tostring(i - 2);
            end
            characterSkillLoc:SetColumnValue(newCharacterSkillsLoc[i * 2], 'text', skillNameText);
            characterSkillLoc:SetColumnValue(newCharacterSkillsLoc[i * 2 - 1], 'text', textForSkill);
        end
        local characterSkillsAndLinks = GenerateSkillTreeForAgent(databaseData, nil, agentKey, agentData, { "wh_main_skill_all_magic_all_06_evasion", "wh_main_skill_all_magic_all_07_earthing", "wh_main_skill_all_magic_all_08_power_drain", "wh_main_skill_all_magic_all_11_arcane_conduit", "wh2_main_skill_magic_dark_flock_of_doom_teclis", "wh2_main_skill_all_magic_high_09_arcane_unforging_lord", });
        ConcatTable(characterSkillNodesToExport, characterSkillsAndLinks["character_skill_nodes_tables"]);
        ConcatTable(characterSkillNodeLinksToExport, characterSkillsAndLinks["character_skill_node_links_tables"]);
        ConcatTable(characterSkillsToEffectsToExport, characterSkillsAndLinks["character_skill_level_to_effects_junctions_tables"]);
        ConcatTable(characterSkillsToExport, newCharacterSkills);
        ConcatTable(characterSkillLocToExport, newCharacterSkillsLoc);
    end

    local effectTables = databaseData["effects_tables"];
    local finalisedEffects = effectTables:PrepareRowsForOutput(effectsToExport);
    local effectBonusValuesTables = databaseData["effect_bonus_value_unit_ability_junctions_tables"];
    local finalisedEffectBonusValues = effectBonusValuesTables:PrepareRowsForOutput(effectBonusValuesToExport);
    local characterSkillsTable = databaseData["character_skills_tables"];
    local finalisedCharacterSkills = characterSkillsTable:PrepareRowsForOutput(characterSkillsToExport);
    local characterSkillNodesTable = databaseData["character_skill_nodes_tables"];
    local finalisedCharacterSkillNodes = characterSkillNodesTable:PrepareRowsForOutput(characterSkillNodesToExport);
    local characterSkillEffectsTable = databaseData["character_skill_level_to_effects_junctions_tables"];
    local finalisedcharacterSkillEffects = characterSkillEffectsTable:PrepareRowsForOutput(characterSkillsToEffectsToExport);
    local characterSkillNodeLinksTable = databaseData["character_skill_node_links_tables"];
    local finalisedCharacterSkillNodeLinks = characterSkillNodeLinksTable:PrepareRowsForOutput(characterSkillNodeLinksToExport);
    local characterSkillLocTable = databaseData["character_skills_loc"];
    local finalisedCharacterSkillLoc = characterSkillLocTable:PrepareRowsForOutput(characterSkillLocToExport);
    return {
        effects_tables = finalisedEffects,
        effect_bonus_value_unit_ability_junctions_tables = finalisedEffectBonusValues,
        character_skills_tables = finalisedCharacterSkills,
        character_skill_nodes_tables = finalisedCharacterSkillNodes,
        character_skill_node_links_tables = finalisedCharacterSkillNodeLinks,
        character_skill_level_to_effects_junctions_tables = finalisedcharacterSkillEffects,
        character_skills_loc = finalisedCharacterSkillLoc,
    };
end