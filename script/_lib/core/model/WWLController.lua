WWLController = {
    CampaignName = "",
    HumanFaction = {},
    BattleLores = {"Beasts", "Death", "Fire", "Heavens", "Life", "Light", "Metal", "Shadows", },
    Logger = {},
    -- Data structures
    WizardData = {},
}

function WWLController:new (o)
    o = o or {};
    setmetatable(o, self);
    self.__index = self;
    return o;
end

function WWLController:Initialise(enableLogging)
    self.CampaignName = cm:get_campaign_name();
    self.HumanFaction = self:GetHumanFaction();
    self.Logger = Logger:new({});
    self.Logger:Initialise("WondrousWizardLevels.txt", enableLogging);
    self.Logger:Log_Start();
end

-- This exists to convert the human faction list to just an object.
-- This also means it will only work for one player.
function WWLController:GetHumanFaction()
    local allHumanFactions = cm:get_human_factions();
    if allHumanFactions == nil then
        return allHumanFactions;
    end
    for key, humanFaction in pairs(allHumanFactions) do
        local faction = cm:model():world():faction_by_key(humanFaction);
        return faction;
    end
end

function WWLController:IsExcludedFaction(faction)
    local factionName = faction:name();
    if factionName == "wh_main_grn_skull-takerz" then
        return false;
    end

    if factionName == "rebels" or
    string.match(factionName, "waaagh") or
    string.match(factionName, "brayherd") or
    string.match(factionName, "intervention") or
    string.match(factionName, "incursion") or
    string.match(factionName, "separatists") or
    string.match(factionName, "qb") or
    factionName == "wh_dlc03_bst_beastmen_chaos" or
    factionName == "wh2_dlc11_cst_vampire_coast_encounters"
    then
        return true;
    end

    return false;
end

function WWLController:IsSupportedCharacter(character)
    if character:character_type("colonel") == true then
        return false;
    end
    local characterSubtype = character:character_subtype_key();
    local characterSubculture = character:faction():subculture();
    local equivalentSubculture = self:GetEquivalentSubculture(characterSubculture);
    if _G.WWLResources.WizardData[equivalentSubculture] == nil then
        return false;
    end
    return _G.WWLResources.WizardData[equivalentSubculture][characterSubtype] ~= nil;
end

function WWLController:SetupNewWizard(character)
    local characterCqi = character:command_queue_index();
    local characterLookupString = "character_cqi:"..characterCqi;
    local characterSubtype = character:character_subtype_key();
    local characterSubculture = character:faction():subculture()
    local defaultWizardData = self:GetDefaultWizardDataForCharacterSubtype(characterSubtype, characterSubculture);
    local defaultSpells = self:GetDefaultSpellsForWizard(defaultWizardData);
    self.WizardData[characterLookupString] = {
        NumberOfSpells = defaultWizardData.DefaultWizardLevel,
        UnlockedSpells = defaultSpells,
        LastGeneratedSpellTurn = 0,
    };
    return self.WizardData[characterLookupString];
end

function WWLController:GetLegendaryLordNameKeysForSubculture(subcultureKey)
    local equivalentSubculture = self:GetEquivalentSubculture(subcultureKey);
    return _G.WWLResources.LegendaryLordNameKeys[equivalentSubculture];
end
function WWLController:GetSuppportedSubtypesForSubculture(characterSubculture)
    local equivalentSubculture = self:GetEquivalentSubculture(characterSubculture);
    return _G.WWLResources.WizardData[equivalentSubculture];
end

function WWLController:GetDefaultWizardDataForCharacterSubtype(characterSubtype, characterSubculture)
    local equivalentSubculture = self:GetEquivalentSubculture(characterSubculture);
    if equivalentSubculture == nil then
        return false;
    end
    return _G.WWLResources.WizardData[equivalentSubculture][characterSubtype];
end

function WWLController:GetEquivalentSubculture(subculture)
    local equivalentSubculture = subculture;
    if subculture == "wh_main_sc_ksl_kislev"
    or subculture == "wh_main_sc_teb_teb" then
        equivalentSubculture = "wh_main_sc_emp_empire";
    elseif subculture == "wh_main_sc_grn_savage_orcs" then
        equivalentSubculture = "wh_main_sc_grn_greenskins";
    end
    return equivalentSubculture;
end

function WWLController:IsSignatureSpell(magicLore, skillKey)
    return magicLore ~= nil and Contains(magicLore.SignatureSpell, skillKey);
end

function WWLController:IsInnateSpell(magicLore, skillKey)
    return magicLore ~= nil and Contains(magicLore.InnateSkill, skillKey);
end

function WWLController:IsLevel1Spell(wizardData, skillKey)
    local magicLore = self:GetMagicLoreData(wizardData.Lore);
    if magicLore == nil then
        return false;
    else
        return Contains(magicLore.Level1DefaultSpells, skillKey);
    end
end

function WWLController:IsLevel3Spell(wizardData, skillKey)
    local magicLore = self:GetMagicLoreData(wizardData.Lore);
    if magicLore == nil then
        return false;
    else
        return Contains(magicLore.Level3DefaultSpells, skillKey);
    end
end

function WWLController:GetMagicLoreData(loreKey)
    return _G.WWLResources.MagicLores[loreKey];
end

function WWLController:GetDefaultSpellsForWizard(wizardData)
    if type(wizardData.Lore) == "table" then
        return {};
    end
    local defaultSpells = {};
    --self.Logger:Log("Getting Lore: "..wizardData.Lore);
    local magicLore = self:GetMagicLoreData(wizardData.Lore);
    for index, spellKey in pairs(magicLore.Level1DefaultSpells) do
        defaultSpells[#defaultSpells + 1] = tostring(spellKey);
    end
    if wizardData.DefaultWizardLevel >= 3 then
        for index, spellKey in pairs(magicLore.Level3DefaultSpells) do
            defaultSpells[#defaultSpells + 1] = tostring(spellKey);
        end
    end
    return defaultSpells;
end

function WWLController:GetSpellsForCharacter(character, lore)
    local magicLoreData = self:GetMagicLoreData(lore);
    local spellsForCharacterLore = {};
    ConcatTable(spellsForCharacterLore, magicLoreData.Level1DefaultSpells);
    ConcatTable(spellsForCharacterLore, magicLoreData.Level3DefaultSpells);
    local unlockedSpells = {};
    for index, spellKey in pairs(spellsForCharacterLore) do
        if character:has_skill(spellKey) then
            --self.Logger:Log("Character has spell: "..spellKey);
            --cm:remove_effect_bundle_from_character(spellKey.."_disabled", character);
            table.insert(unlockedSpells, spellKey);
        end
    end
    return unlockedSpells;
end

function WWLController:GetWizardLevel(character)
    local defaultWizardData = self:GetDefaultWizardDataForCharacterSubtype(character:character_subtype_key(), character:faction():subculture());
    if defaultWizardData == nil then
        return nil;
    end
    local defaultWizardLevelToCheck = defaultWizardData.DefaultWizardLevel + 1;
    local maxLevelToCheck = defaultWizardData.DefaultWizardLevel + 1;
    if character:character_subtype_key() == "vmp_lord" then
            maxLevelToCheck = 4;
    end
    local characterWizardLevel = defaultWizardData.DefaultWizardLevel;
    for i = defaultWizardLevelToCheck, maxLevelToCheck do
        if character:has_skill("wwl_skill_wizard_level_0"..tostring(i)) then
            characterWizardLevel = i;
        else
            break;
        end
    end
    return characterWizardLevel;
end

function WWLController:SetSpellsForCharacter(character, forceGeneration)
    -- We don't regenerate spells more than once per turn
    -- and there is no point to generating spells for loremasters
    -- since they have them
    if character:has_effect_bundle("wwl_character_last_generated_turn")
    and forceGeneration ~= true then
        self.Logger:Log("Character has already generated spells this turn. Not generating spells.");
        return;
    elseif forceGeneration == true then
        self.Logger:Log("Forcing generation for character");
    end
    local characterCqi = character:command_queue_index();
    local characterSubtype = character:character_subtype_key();
    --self.Logger:Log("Character subtype: ".. characterSubtype.." character cqi: "..characterCqi);
    local characterSubculture = character:faction():subculture();
    local defaultWizardData = self:GetDefaultWizardDataForCharacterSubtype(characterSubtype, characterSubculture);
    if self:HasSpecialSpellGenerationRules(defaultWizardData) then
        local specialCallbackTimeout = 0.3;
        --[[if characterSubtype == "wh2_main_hef_loremaster_of_hoeth" then
            specialCallbackTimeout = 0.6;
        end--]]
        cm:callback(function()
            local specialCharacter = cm:get_character_by_cqi(characterCqi);
            --local specialCharacterCqi = character:command_queue_index();
            --local specialCharacterSubtype = character:character_subtype_key();
            --self.Logger:Log("Character subtype: ".. specialCharacterSubtype.." character cqi: "..specialCharacterCqi);
            if specialCharacter
            and not specialCharacter:is_null_interface()
            and not specialCharacter:is_wounded() then
                self:PerformSpecialSpellGeneration(defaultWizardData, specialCharacter);
                -- Any applied effect bundles will expire next turn, which is when we need to regenerate
                local lastGeneratedTurn = cm:create_new_custom_effect_bundle("wwl_character_last_generated_turn");
                lastGeneratedTurn:set_duration(1);
                if not character:is_null_interface() then
                    cm:apply_custom_effect_bundle_to_character(lastGeneratedTurn, specialCharacter);
                end
            end
        end,
        specialCallbackTimeout);
    else
        if defaultWizardData.IsLoremaster == true
        and character:has_skill(defaultWizardData.LoremasterCharacterSkillKey) then
            self.Logger:Log("Character has loremaster skill. Not generating spells.");
            return;
        end
        -- Remove all disable spell skills
        local unlockedSpells = self:GetSpellsForCharacter(character, defaultWizardData.Lore);
        local wizardLevel = self:GetWizardLevel(character);
        local numberOfSpells = wizardLevel;
        -- Then we disable spells required for our wizard level
        -- The remaining spells will equal our wizard level
        local customEffectBundle = cm:create_new_custom_effect_bundle("wwl_character_spells_effect_bundle");
        customEffectBundle:set_duration(1);
        for i = 1, #unlockedSpells - numberOfSpells do
            local spellKey = GetAndRemoveRandomObjectFromList(unlockedSpells);
            local effectKey = spellKey.."_disabled";
            self.Logger:Log("Disabling spell: "..spellKey.." with effect: "..effectKey);
            customEffectBundle:add_effect(effectKey, "character_to_character_own", 1);
        end
        --cm:apply_custom_effect_bundle_to_character(customEffectBundle, character);
        -- Any applied effect bundles will expire next turn, which is when we need to regenerate
        local lastGeneratedTurn = cm:create_new_custom_effect_bundle("wwl_character_last_generated_turn");
        lastGeneratedTurn:set_duration(1);
        local defaultCallbackTime = 0.2;
        if character:faction():is_human() == true then
            defaultCallbackTime = 0.3;
        end
        --cm:apply_custom_effect_bundle_to_character(lastGeneratedTurn, character);
        if not character:is_null_interface() then
            cm:callback(function()
                local grabbedCharacter = cm:get_character_by_cqi(characterCqi);
                if grabbedCharacter
                and not grabbedCharacter:is_null_interface()
                and not grabbedCharacter:is_wounded() then
                    cm:apply_custom_effect_bundle_to_character(customEffectBundle, grabbedCharacter);
                    cm:apply_custom_effect_bundle_to_character(lastGeneratedTurn, grabbedCharacter);
                end
            end,
            defaultCallbackTime);
        end
    end
end

function WWLController:PerformSpecialSpellGeneration(defaultWizardData, character)
    if defaultWizardData.Lore == "wh2_main_lore_loremaster" then
        local customEffectBundleLoremaster = cm:create_new_custom_effect_bundle("wwl_character_spells_effect_bundle");
        customEffectBundleLoremaster:set_duration(1);
        local loremasterLoreData = self:GetMagicLoreData(defaultWizardData.Lore);
        local numberOfSpellsToDisable = 4;
        if character:has_skill("wwl_skill_wizard_level_03") then
            numberOfSpellsToDisable = 1;
        end
        local signatureSpells = {};
        for index, signatureSpellKey in pairs(loremasterLoreData.SignatureSpell) do
            signatureSpells[#signatureSpells + 1] = signatureSpellKey;
        end
        for i = 0, numberOfSpellsToDisable do
            local signatureSpell = GetAndRemoveRandomObjectFromList(signatureSpells);
            self.Logger:Log("Disabling Loremaster level signature spell: "..signatureSpell);
            customEffectBundleLoremaster:add_effect(signatureSpell.."_disabled", "character_to_character_own", 1);
        end
        cm:apply_custom_effect_bundle_to_character(customEffectBundleLoremaster, character);
    -- Last case is multi lore characters
    else
        self.Logger:Log("Found multi lore character: "..character:character_subtype_key());
        -- Grab the magic lore data for each lore and deep copy them
        local magicLoresData = {};
        for index, loreKey in pairs(defaultWizardData.Lore) do
            local remappedMagicLore = {};
            local magicLoreData = self:GetMagicLoreData(loreKey);
            local innateSkills = {};
            for index, innateSpellKey in pairs(magicLoreData.InnateSkill) do
                innateSkills[#innateSkills + 1] = innateSpellKey;
            end
            local signatureSpells = {};
            for index, signatureSpellKey in pairs(magicLoreData.SignatureSpell) do
                signatureSpells[#signatureSpells + 1] = signatureSpellKey;
            end
            local level1Spells = {};
            for index, level1SpellsKey in pairs(magicLoreData.Level1DefaultSpells) do
                level1Spells[#level1Spells + 1] = level1SpellsKey;
            end
            local level3Spells = {};
            for index, level3SpellsKey in pairs(magicLoreData.Level3DefaultSpells) do
                level3Spells[#level3Spells + 1] = level3SpellsKey;
            end
            magicLoresData[#magicLoresData + 1] = {
                InnateSkill = innateSkills,
                SignatureSpell = signatureSpells,
                Level1DefaultSpells = level1Spells,
                Level3DefaultSpells = level3Spells,
            };
        end
        local customEffectBundle = cm:create_new_custom_effect_bundle("wwl_character_spells_effect_bundle");
        customEffectBundle:set_duration(1);
        local selectedSpells = {};
        -- Grab the innate skill
        --[[local innateSkillLoreData = GetRandomObjectFromList(magicLoresData);
        local selectedInnateSkill = GetRandomObjectFromList(innateSkillLoreData.InnateSkill);
        self.Logger:Log("Enabling skill: "..selectedInnateSkill);
        selectedSpells[#selectedSpells + 1] = selectedInnateSkill;
        for index, magicLore in pairs(magicLoresData) do
            for index, innateSkill in pairs(magicLore.InnateSkill) do
                if innateSkill ~= selectedInnateSkill then
                    self.Logger:Log("Disabling spell: "..innateSkill);
                    customEffectBundle:add_effect(innateSkill.."_disabled", "character_to_character_own_factionwide_unseen", 1);
                end
            end
        end--]]
        -- Grab the signature spell
        local signatureSpellLoreData = GetRandomObjectFromList(magicLoresData);
        local selectedSignatureSpell = GetRandomObjectFromList(signatureSpellLoreData.SignatureSpell);
        self.Logger:Log("Enabling spell: "..selectedSignatureSpell);
        selectedSpells[#selectedSpells + 1] = selectedSignatureSpell;
        -- Now disable the other signature spells (except for mannfred)
        if character:character_subtype_key() ~= "vmp_mannfred_von_carstein" then
            for index, magicLore in pairs(magicLoresData) do
                for index, signatureSpell in pairs(magicLore.SignatureSpell) do
                    if signatureSpell ~= selectedSignatureSpell then
                        self.Logger:Log("Disabling spell: "..signatureSpell);
                        customEffectBundle:add_effect(signatureSpell.."_disabled", "character_to_character_own", 1);
                    end
                end
            end
        end
        -- Check how many of each spell we need
        local numberOfLevel1Spells = 1;
        local numberOfLevel3Spells = 0;
        local numberOfSpells = defaultWizardData.DefaultWizardLevel;
        if character:has_skill("wwl_skill_wizard_level_0"..tostring(defaultWizardData.DefaultWizardLevel + 1)) then
            numberOfSpells = defaultWizardData.DefaultWizardLevel + 1;
        end
        if defaultWizardData.IsLoremaster == true
        and character:has_skill(defaultWizardData.LoremasterCharacterSkillKey) then
            numberOfLevel1Spells = 2;
            numberOfLevel3Spells = 1;
        elseif character:character_subtype_key() == "wh2_main_hef_teclis" then
            numberOfLevel1Spells = 2;
            numberOfLevel3Spells = 1;
        elseif defaultWizardData.DefaultWizardLevel == 5 then
            numberOfLevel3Spells = numberOfLevel3Spells + 2;
        elseif defaultWizardData.DefaultWizardLevel > 3
        or numberOfSpells > 3 then
            if Roll100(50) then
                numberOfLevel1Spells = numberOfLevel1Spells + 1;
            else
                numberOfLevel3Spells = numberOfLevel3Spells + 1;
            end
        end
        -- Get the level 1 spells
        local selectedLevel1Spells = {};
        for i = 0, numberOfLevel1Spells do
            local level1SpellLoreData = GetRandomObjectFromList(magicLoresData);
            local activeLevel1Spell = GetAndRemoveRandomObjectFromList(level1SpellLoreData.Level1DefaultSpells);
            selectedLevel1Spells[#selectedLevel1Spells + 1] = activeLevel1Spell;
            self.Logger:Log("Giving character level 1 spell: "..activeLevel1Spell);
            selectedSpells[#selectedSpells + 1] = activeLevel1Spell;
        end
        -- Now disable the other level 1 spells
        for index, magicLore in pairs(magicLoresData) do
            for index, level1Spell in pairs(magicLore.Level1DefaultSpells) do
                if Contains(selectedLevel1Spells, level1Spell) == false then
                    self.Logger:Log("Disabling spell: "..level1Spell);
                    customEffectBundle:add_effect(level1Spell.."_disabled", "character_to_character_own", 1);
                end
            end
        end
        -- Get the level 3 spells
        local selectedLevel3Spells = {};
        for i = 0, numberOfLevel3Spells do
            local level3SpellLoreData = GetRandomObjectFromList(magicLoresData);
            local activeLevel3Spell = GetAndRemoveRandomObjectFromList(level3SpellLoreData.Level3DefaultSpells);
            selectedLevel3Spells[#selectedLevel3Spells + 1] = activeLevel3Spell;
            self.Logger:Log("Giving character level 3 spell: "..activeLevel3Spell);
            selectedSpells[#selectedSpells + 1] = activeLevel3Spell;
        end
        -- Now disable the other level 3 spells
        for index, magicLore in pairs(magicLoresData) do
            for index, level3Spell in pairs(magicLore.Level3DefaultSpells) do
                if Contains(selectedLevel3Spells, level3Spell) == false then
                    self.Logger:Log("Disabling spell: "..level3Spell);
                    customEffectBundle:add_effect(level3Spell.."_disabled", "character_to_character_own", 1);
                end
            end
        end
        if not character:is_null_interface()
        and not character:is_wounded() then
            local characterCqi = character:command_queue_index();
            local characterSubtype = character:character_subtype_key();
            self.Logger:Log("Character subtype: ".. characterSubtype.." character cqi: "..characterCqi);
            cm:apply_custom_effect_bundle_to_character(customEffectBundle, character);
        end
    end
    self.Logger:Log_Finished();
end

function WWLController:HasSpecialSpellGenerationRules(wizardData)
    if type(wizardData.Lore) == "table" then
        return true;
    elseif wizardData.Lore == "wh2_main_lore_loremaster" then
        return true;
    end
    return false;
end

function WWLController:IsValidCharacterSkillKey(skillKey)
    --self.Logger:Log("Allocated: "..skillKey);
    if
    -- This first case is used for some of the Tomb Kings casters
    (string.match(skillKey,  "_lore_") and not string.match(skillKey, "_loremaster_"))
    -- Second case is standard magic for everyone else with some blacklisted skills
    or (string.match(skillKey,  "_magic_")
        and skillKey ~= "wh2_main_skill_skv_generic_magic_ward"
        and skillKey ~= "wh_dlc06_skill_grn_wurrzag_grants_magic_attacks"
        and skillKey ~= "wh_main_skill_grn_wizard_unique_night_goblin_shaman_magic_mushrooms"
    )
    -- Third case is the wizard level skills we are listening for
    or string.match(skillKey,  "wwl_skill_wizard_level_0")
    -- Fourth case is the loremaster skills
    or (skillKey == "wwl_skill_mannfred_dual_loremaster"
    or skillKey == "wh_main_skill_vmp_lord_unique_loremaster_lore_of_vampires"
    or skillKey == "wh_dlc07_skill_brt_lord_unique_fay_enchantress_loremaster_lore_of_life"
    or skillKey == "wh2_main_def_morathi_loremaster_lore_of_dark_magic"
    or skillKey == "wh_main_skill_emp_lord_unique_balthasar_loremaster_lore_of_metal"
    or skillKey == "wh2_dlc10_hef_alarielle_loremaster_lore_of_light_magic"
    or skillKey == "AK_hobo_loremaster_lichemaster")
    then
        return true;
    end
    return false;
end

function WWLController:GetCharacterWizardLevelWithName(nameText, faction, checkForLLNameKeys)
    self.Logger:Log("Checking for existing wizards");
    -- First we check if we can find the character alive in the faction
    local character_list = faction:character_list();
    for i = 0, character_list:num_items() - 1 do
        local character = character_list:item_at(i);
        if character:is_null_interface() == false
        and not character:character_type("colonel") then
            if character:military_force():is_null_interface() or character:military_force():is_armed_citizenry() == false then
                local forename = effect.get_localised_string(character:get_forename());
                local surname = effect.get_localised_string(character:get_surname());
                self.Logger:Log("Checking: "..forename.." "..surname.." subtype: "..character:character_subtype_key());
                if (forename ~= "" or surname ~= "")
                and string.match(nameText, forename.." "..surname) then
                    self.Logger:Log("Found match!");
                    local wizardLevel = self:GetWizardLevel(character);
                    return wizardLevel;
                end
            end
        end
    end
    if checkForLLNameKeys == true then
        -- If we can't find it alive then we try and identify the character by the name keys
        local subcultureKey = faction:subculture();
        local llNameKeys = self:GetLegendaryLordNameKeysForSubculture(subcultureKey);
        for llForeNameKey, llNameKeyData in pairs(llNameKeys) do
            local forename = effect.get_localised_string(llForeNameKey);
            if string.match(nameText, forename) then
                self.Logger:Log("Found matching LL by forename key!");
                local surname = effect.get_localised_string(llNameKeyData.Surname);
                if llNameKeyData.Surname == "" or string.match(nameText, surname) then
                    self.Logger:Log("Found matching LL by name key(s)! Subtype is: "..llNameKeyData.Subtype);
                    local defaultWizardData = self:GetDefaultWizardDataForCharacterSubtype(llNameKeyData.Subtype, subcultureKey);
                    return defaultWizardData.DefaultWizardLevel;
                end
            end
        end
    end
    -- If we still can't find them, then they aren't supported or aren't recruited
    return nil;
end