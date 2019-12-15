WWLController = {
    CampaignName = "",
    HumanFaction = {},
    BattleLores = {"Beasts", "Death", "Fire", "Heavens", "Life", "Light", "Metal", "Shadows", },
    --BattleLores = {"Death", },
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

function WWLController:Initialise(random_army_manager, enableLogging)
    self.CampaignName = cm:get_campaign_name();
    self.HumanFaction = self:GetHumanFaction();
    self.Logger = Logger:new({});
    self.Logger:Initialise("WonderousWizardLevels.txt", enableLogging);
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
    elseif subculture == "wh_main_sc_grn_greenskins" then
        equivalentSubculture = "wh_main_sc_grn_savage_orcs";
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
    elseif wizardData.IsLord == true then
        return Contains(magicLore.Level1DefaultSpellsLord, skillKey);
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
    if wizardData.IsLord == true then
        for index, spellKey in pairs(magicLore.Level1DefaultSpellsLord) do
            defaultSpells[#defaultSpells + 1] = tostring(spellKey);
        end
        if wizardData.DefaultWizardLevel >= 3 then
            for index, spellKey in pairs(magicLore.Level3DefaultSpellsLord) do
                defaultSpells[#defaultSpells + 1] = tostring(spellKey);
            end
        end
    else
        for index, spellKey in pairs(magicLore.Level1DefaultSpells) do
            defaultSpells[#defaultSpells + 1] = tostring(spellKey);
        end
        if wizardData.DefaultWizardLevel >= 3 then
            for index, spellKey in pairs(magicLore.Level3DefaultSpells) do
                defaultSpells[#defaultSpells + 1] = tostring(spellKey);
            end
        end
    end
    return defaultSpells;
end

function WWLController:SetSpellsForCharacter(character)
    local characterCqi = character:command_queue_index();
    local characterLookupString = "character_cqi:"..characterCqi;
    local wizard = {};
    -- Check if we have any existing character data
    -- Set them up if required
    if self.WizardData[characterLookupString] == nil then
        self.Logger:Log("New character found!");
        wizard = self:SetupNewWizard(character);
    else
        self.Logger:Log("Using existing data");
        wizard = self:GetWizardData(character);
    end
    local turnNumber = cm:model():turn_number();
    -- We don't regenerate spells more than once per turn
    -- and there is no point to generating spells for loremasters
    -- since they have them
    if wizard.LastGeneratedSpellTurn == turnNumber then
        self.Logger:Log("Character has already generated spells this turn. Not generating spells.");
        return;
    end
    local characterSubtype = character:character_subtype_key();
    local characterSubculture = character:faction():subculture();
    local defaultWizardData = self:GetDefaultWizardDataForCharacterSubtype(characterSubtype, characterSubculture);
    if self:HasSpecialSpellGenerationRules(defaultWizardData) then
        self:PerformSpecialSpellGeneration(defaultWizardData, wizard, character);
    else
        if wizard.IsLoremaster == true and character:has_skill(wizard.LoremasterCharacterSkillKey) then
            self.Logger:Log("Character has loremaster skill. Not generating spells.");
            return;
        end
        -- Remap the characters unlocked spells for easier manipulation
        local remappedWizardData = self:GetWizardDataCopy(wizard);
        -- Remove all disable spell skills
        for index, spellKey in pairs(remappedWizardData.UnlockedSpells) do
            cm:remove_effect_bundle_from_character(spellKey.."_disable", character);
        end

        local numberOfUnlockedSpells = #remappedWizardData.UnlockedSpells;
        --self.Logger:Log("numberOfUnlockedSpells: "..numberOfUnlockedSpells);
        -- Then we disable spells required for our wizard level
        -- The remaining spells will equal our wizard level
        for i = 1, numberOfUnlockedSpells - remappedWizardData.NumberOfSpells do
            local spellKey = GetAndRemoveRandomObjectFromList(remappedWizardData.UnlockedSpells);
            self.Logger:Log("Disabling spell: "..spellKey);
            cm:apply_effect_bundle_to_character(spellKey.."_disable", character, -1);
        end
    end
    --self.Logger:Log("Last turn number "..turnNumber);
    wizard.LastGeneratedSpellTurn = turnNumber;
end

function WWLController:PerformSpecialSpellGeneration(defaultWizardData, wizard, character)
    local characterCqi = character:command_queue_index();
    if defaultWizardData.Lore == "Slann" then
        local validLores = {"High", };
        for index, battleLoreKey in pairs(self.BattleLores) do
            validLores[#validLores + 1] = battleLoreKey;
        end
        local selectedLore = GetRandomObjectFromList(validLores);
        local tempWizardData = {
            DefaultWizardLevel = 5,
            IsLord = false,
            Lore = selectedLore;
        }
        self.Logger:Log("Selected Slann lore: "..selectedLore);
        local spellsForLore = self:GetDefaultSpellsForWizard(tempWizardData);
        local magicLore = self:GetMagicLoreData(selectedLore);
        spellsForLore[#spellsForLore + 1] = GetRandomObjectFromList(magicLore.SignatureSpell);
        spellsForLore[#spellsForLore + 1] = GetRandomObjectFromList(magicLore.InnateSkill);
        -- Remap the characters unlocked spells for easier manipulation
        local remappedWizardData = self:GetWizardDataCopy(wizard);
        -- Remove all enabled spell abilities
        for index, spellKey in pairs(remappedWizardData.UnlockedSpells) do
            cm:remove_effect_bundle_from_character(spellKey.."_enable", character);
        end
        wizard.UnlockedSpells = spellsForLore;
        for index, spellKey in pairs(wizard.UnlockedSpells) do
            cm:apply_effect_bundle_to_character(spellKey.."_enable", character, -1);
        end
    elseif defaultWizardData.Lore == "Teclis" then
        local selectedLore = "Mixed";
        if Roll100(50) then
            self.Logger:Log("Teclis will have the lore of High Magic");
            selectedLore = "High";
            local tempWizardData = {
                DefaultWizardLevel = 4,
                IsLord = true,
                Lore = selectedLore;
            }
            -- Remap the characters unlocked spells for easier manipulation
            local spellsForLore = self:GetDefaultSpellsForWizard(selectedLore);
            -- Remove all current enabled spell abilities
            for index, spellKey in pairs(wizard.UnlockedSpells) do
                cm:remove_effect_bundle_from_character(spellKey.."_enable", character);
            end
            wizard.UnlockedSpells = spellsForLore;
            for index, spellKey in pairs(wizard.UnlockedSpells) do
                cm:apply_effect_bundle_to_character(spellKey.."_enable", character, -1);
            end
        else
            self.Logger:Log("Teclis will have the Mixed Lores of Magic");
            -- Remove all currently enabled spell abilities
            for index, spellKey in pairs(wizard.UnlockedSpells) do
                cm:remove_effect_bundle_from_character(spellKey.."_enable", character);
            end
            local battleLoresCopy = {};
            for index, battleLore in pairs(self.BattleLores) do
                battleLoresCopy[#battleLoresCopy + 1] = battleLore;
            end
            local selectedSpells = {};
            -- Now we generate a spell from each lore.
            -- First we do the innate skill
            local innateSkillLoreKey = GetAndRemoveRandomObjectFromList(battleLoresCopy);
            local innateSkillLoreData = self:GetMagicLoreData(innateSkillLoreKey);
            local innateSkill = GetRandomObjectFromList(innateSkillLoreData.InnateSkill);
            selectedSpells[#selectedSpells + 1] = innateSkill;
            cm:apply_effect_bundle_to_character(innateSkill.."_enable", character, -1);
            -- Next is the signature spell
            local signatureSpellLoreKey = GetAndRemoveRandomObjectFromList(battleLoresCopy);
            local signatureSpellLoreData = self:GetMagicLoreData(signatureSpellLoreKey);
            local signatureSpell = GetRandomObjectFromList(signatureSpellLoreData.SignatureSpell);
            selectedSpells[#selectedSpells + 1] = signatureSpell;
            cm:apply_effect_bundle_to_character(signatureSpell.."_enable", character, -1);
            -- Now we do level 1 spells
            for i = 0, 2 do
                local level1SpellLoreKey = GetAndRemoveRandomObjectFromList(battleLoresCopy);
                local level1SpellLoreData = self:GetMagicLoreData(level1SpellLoreKey);
                local level1Spell = "";
                if #level1SpellLoreData.Level1DefaultSpellsLord > 0 then
                    level1Spell = GetRandomObjectFromList(level1SpellLoreData.Level1DefaultSpellsLord);
                else
                    level1Spell = GetRandomObjectFromList(level1SpellLoreData.Level1DefaultSpells);
                end
                selectedSpells[#selectedSpells + 1] = level1Spell;
                cm:apply_effect_bundle_to_character(level1Spell.."_enable", character, -1);
            end
            -- and finally, level 3 spells
            for i = 0, 1 do
                local level3SpellLoreKey = GetAndRemoveRandomObjectFromList(battleLoresCopy);
                local level3SpellLoreData = self:GetMagicLoreData(level3SpellLoreKey);
                local level3Spell = GetRandomObjectFromList(level3SpellLoreData.Level3DefaultSpellsLord);
                if #level3SpellLoreData.Level3DefaultSpellsLord > 0 then
                    level3Spell = GetRandomObjectFromList(level3SpellLoreData.Level3DefaultSpellsLord);
                else
                    level3Spell = GetRandomObjectFromList(level3SpellLoreData.Level3DefaultSpells);
                end
                selectedSpells[#selectedSpells + 1] = level3Spell;
                cm:apply_effect_bundle_to_character(level3Spell.."_enable", character, -1);
            end
            -- Now we add our selected spells to our unlocked spells list
            wizard.UnlockedSpells = selectedSpells;
        end
    elseif defaultWizardData.Lore == "LoremasterOfHoeth" then
        local characterLookupString = "character_cqi:"..characterCqi;
        -- Remove all current spell skills
        for index, spellKey in pairs(wizard.UnlockedSpells) do
            cm:force_remove_trait(characterLookupString, spellKey.."_disable");
        end
        local loremasterLoreData = self:GetMagicLoreData("LoremasterOfHoeth");
        -- Remap the characters signature spells for easier manipulation
        local remappedSignatureSpells = {};
        for index, spellKey in pairs(loremasterLoreData.SignatureSpell) do
            remappedSignatureSpells[#remappedSignatureSpells + 1] = spellKey;
        end
        local disabledSpells = {};
        for i = 0, 1 do
            local signatureSpell = GetAndRemoveRandomObjectFromList(remappedSignatureSpells);
            self.Logger:Log("Disabling Loremaster level signature spell: "..signatureSpell);
            disabledSpells[#disabledSpells + 1] = signatureSpell;
            cm:force_add_trait(characterLookupString, signatureSpell.."_disable");
        end
        -- Update the unlocked spell list
        wizard.UnlockedSpells = disabledSpells;
    elseif defaultWizardData.Lore == "Azhag" then
        -- Azhag only gets spells generated when he as the Crown of Sorcery
        if character:has_ancillary("wh_main_anc_enchanted_item_the_crown_of_sorcery") then
            -- Remove all currently enabled spell abilities
            for index, spellKey in pairs(wizard.UnlockedSpells) do
                cm:remove_effect_bundle_from_character(spellKey.."_enable", character);
            end
            local selectedSpells = {};
            local deathLoreData = self:GetMagicLoreData("Death");
            -- Grab the innate skill
            local deathInnateSkill = GetRandomObjectFromList(deathLoreData.InnateSkill);
            selectedSpells[#selectedSpells + 1] = deathInnateSkill;
            cm:apply_effect_bundle_to_character(deathInnateSkill.."_enable", character, -1);
            -- Check how many of each spell we need
            local numberOfLevel1Spells = 1;
            local numberOfLevel3Spells = 0;
            if wizard.NumberOfSpells == 4 then
                if Roll100(50) then
                    numberOfLevel1Spells = numberOfLevel1Spells + 1;
                else
                    numberOfLevel3Spells = numberOfLevel3Spells + 1;
                end
            end
            -- Get the level 1 spells
            local remappedLordLevel1DeathSpells = {};
            for index, spellKey in pairs(deathLoreData.Level1DefaultSpellsLord) do
                remappedLordLevel1DeathSpells[#remappedLordLevel1DeathSpells + 1] = spellKey;
            end
            for i = 0, numberOfLevel1Spells do
                local level1Spell = GetAndRemoveRandomObjectFromList(remappedLordLevel1DeathSpells);
                self.Logger:Log("Giving Azhag level 1 spell: "..level1Spell);
                selectedSpells[#selectedSpells + 1] = level1Spell;
                cm:apply_effect_bundle_to_character(level1Spell.."_enable", character, -1);
            end
            -- Get the level 3 spells
            local remappedLordLevel3DeathSpells = {};
            for index, spellKey in pairs(deathLoreData.Level3DefaultSpellsLord) do
                remappedLordLevel3DeathSpells[#remappedLordLevel3DeathSpells + 1] = spellKey;
            end
            for i = 0, numberOfLevel3Spells do
                local level3Spell = GetAndRemoveRandomObjectFromList(remappedLordLevel3DeathSpells);
                self.Logger:Log("Giving Azhag level 3 spell: "..level3Spell);
                selectedSpells[#selectedSpells + 1] = level3Spell;
                cm:apply_effect_bundle_to_character(level3Spell.."_enable", character, -1);
            end
            -- Update the unlocked spell list
            wizard.UnlockedSpells = selectedSpells;
        end
    elseif defaultWizardData.Lore == "Mannfred" then
        local selectedSpells = {};
        -- First we do the Lore of Vampires
        local vampiresLoreData = self:GetMagicLoreData("Vampires");
        -- Grab the innate skill
        local vampiresInnateSkill = GetRandomObjectFromList(vampiresLoreData.InnateSkill);
        selectedSpells[#selectedSpells + 1] = vampiresInnateSkill;
        cm:apply_effect_bundle_to_character(vampiresInnateSkill.."_enable", character, -1);
        -- Grab the signature spell
        local vampiresSignatureSpell = GetRandomObjectFromList(vampiresLoreData.SignatureSpell);
        selectedSpells[#selectedSpells + 1] = vampiresSignatureSpell;
        cm:apply_effect_bundle_to_character(vampiresSignatureSpell.."_enable", character, -1);
        -- Check how many of each spell we need
        local numberOfLevel1Spells = 1;
        local numberOfLevel3Spells = 0;
        if defaultWizardData.IsLoremaster == true and character:has_skill(defaultWizardData.LoremasterCharacterSkillKey) then
            numberOfLevel1Spells = 2;
            numberOfLevel3Spells = 1;
        else
            if Roll100(50) then
                numberOfLevel1Spells = numberOfLevel1Spells + 1;
            else
                numberOfLevel3Spells = numberOfLevel3Spells + 1;
            end
        end
        -- Get the level 1 spells
        local remappedLordLevel1VampiresSpells = {};
        for index, spellKey in pairs(vampiresLoreData.Level1DefaultSpellsLord) do
            remappedLordLevel1VampiresSpells[#remappedLordLevel1VampiresSpells + 1] = spellKey;
        end
        for i = 0, numberOfLevel1Spells do
            local level1Spell = GetAndRemoveRandomObjectFromList(remappedLordLevel1VampiresSpells);
            self.Logger:Log("Giving Mannfred level 1 spell: "..level1Spell);
            selectedSpells[#selectedSpells + 1] = level1Spell;
            cm:apply_effect_bundle_to_character(level1Spell.."_enable", character, -1);
        end
        -- Get the level 3 spells
        local remappedLordLevel3VampiresSpells = {};
        for index, spellKey in pairs(vampiresLoreData.Level3DefaultSpellsLord) do
            remappedLordLevel3VampiresSpells[#remappedLordLevel3VampiresSpells + 1] = spellKey;
        end
        for i = 0, numberOfLevel3Spells do
            local level3Spell = GetAndRemoveRandomObjectFromList(remappedLordLevel3VampiresSpells);
            self.Logger:Log("Giving Mannfred level 3 spell: "..level3Spell);
            selectedSpells[#selectedSpells + 1] = level3Spell;
            cm:apply_effect_bundle_to_character(level3Spell.."_enable", character, -1);
        end
        -- Then we do the Lore of Death
        local deathLoreData = self:GetMagicLoreData("Death");
        -- Grab the innate skill
        local deathInnateSkill = GetRandomObjectFromList(deathLoreData.InnateSkill);
        selectedSpells[#selectedSpells + 1] = deathInnateSkill;
        cm:apply_effect_bundle_to_character(deathInnateSkill.."_enable", character, -1);
        -- Grab the signature spell
        local deathSignatureSpell = GetRandomObjectFromList(deathLoreData.SignatureSpell);
        selectedSpells[#selectedSpells + 1] = deathSignatureSpell;
        cm:apply_effect_bundle_to_character(deathSignatureSpell.."_enable", character, -1);
        -- Get the level 1 spells
        local remappedLordLevel1DeathSpells = {};
        for index, spellKey in pairs(deathLoreData.Level1DefaultSpellsLord) do
            remappedLordLevel1DeathSpells[#remappedLordLevel1DeathSpells + 1] = spellKey;
        end
        for i = 0, numberOfLevel1Spells do
            local level1Spell = GetAndRemoveRandomObjectFromList(remappedLordLevel1DeathSpells);
            self.Logger:Log("Giving Mannfred level 1 spell: "..level1Spell);
            selectedSpells[#selectedSpells + 1] = level1Spell;
            cm:apply_effect_bundle_to_character(level1Spell.."_enable", character, -1);
        end
        -- Get the level 3 spells
        local remappedLordLevel3DeathSpells = {};
        for index, spellKey in pairs(deathLoreData.Level3DefaultSpellsLord) do
            remappedLordLevel3DeathSpells[#remappedLordLevel3DeathSpells + 1] = spellKey;
        end
        for i = 0, numberOfLevel3Spells do
            local level3Spell = GetAndRemoveRandomObjectFromList(remappedLordLevel3DeathSpells);
            self.Logger:Log("Giving Mannfred level 3 spell: "..level3Spell);
            selectedSpells[#selectedSpells + 1] = level3Spell;
            cm:apply_effect_bundle_to_character(level3Spell.."_enable", character, -1);
        end
        -- Update the unlocked spell list
        wizard.UnlockedSpells = selectedSpells;
    -- Last case is multi lore characters
    else
        self.Logger:Log("Found multi lore character");
        -- Remove all current spell skills
        for index, spellKey in pairs(wizard.UnlockedSpells) do
            self.Logger:Log("Remove spell: "..spellKey.." from character.");
            cm:remove_effect_bundle_from_character(spellKey.."_enable", character);
        end
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
        local selectedSpells = {};
        -- Grab the innate skill
        local innateSkillLoreData = GetRandomObjectFromList(magicLoresData);
        local innateSkill = GetRandomObjectFromList(innateSkillLoreData.InnateSkill);
        selectedSpells[#selectedSpells + 1] = innateSkill;
        cm:apply_effect_bundle_to_character(innateSkill.."_enable", character, -1);
        -- Grab the signature spell
        local signatureSpellLoreData = GetRandomObjectFromList(magicLoresData);
        local selectedSignatureSpell = GetRandomObjectFromList(signatureSpellLoreData.SignatureSpell);
        selectedSpells[#selectedSpells + 1] = selectedSignatureSpell;
        -- Now disable the other signature spells
        for index, magicLore in pairs(magicLoresData) do
            for index, signatureSpell in pairs(magicLore.SignatureSpell) do
                if signatureSpell ~= selectedSignatureSpell then
                    self.Logger:Log("Disabling spell: "..signatureSpell);
                    cm:apply_effect_bundle_to_character(signatureSpell.."_disable", character, -1);
                else
                    cm:remove_effect_bundle_from_character(signatureSpell.."_disable", character);
                end
            end
        end
        -- Check how many of each spell we need
        local numberOfLevel1Spells = 1;
        local numberOfLevel3Spells = 0;
        if defaultWizardData.IsLoremaster == true and character:has_skill(defaultWizardData.LoremasterCharacterSkillKey) then
            numberOfLevel1Spells = 2;
            numberOfLevel3Spells = 1;
        elseif defaultWizardData.DefaultWizardLevel == 4
        or wizard.NumberOfSpells == 4 then
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
                    cm:apply_effect_bundle_to_character(level1Spell.."_disable", character, -1);
                else
                    cm:remove_effect_bundle_from_character(level1Spell.."_disable", character);
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
                    cm:apply_effect_bundle_to_character(level3Spell.."_disable", character, -1);
                else
                    cm:remove_effect_bundle_from_character(level3Spell.."_disable", character);
                end
            end
        end
        -- Update the unlocked spell list
        wizard.UnlockedSpells = selectedSpells;
    end
end

function WWLController:HasSpecialSpellGenerationRules(wizardData)
    if type(wizardData.Lore) == "table" then
        return true;
    elseif wizardData.Lore == "Slann"
    or wizardData.Lore == "Teclis"
    or wizardData.Lore == "Azhag"
    or wizardData.Lore == "Mannfred"
    or wizardData.Lore == "LoremasterOfHoeth" then
        return true;
    end
    return false;
end

function WWLController:GetWizardData(character)
    local characterCqi = character:command_queue_index();
    local characterLookupString = "character_cqi:"..characterCqi;
    local wizardData = self.WizardData[characterLookupString];
    return wizardData;
end

function WWLController:GetWizardDataCopy(wizardData)
    local characterSpells = {};
    for index, spellKey in pairs(wizardData.UnlockedSpells) do
        characterSpells[#characterSpells + 1] = spellKey;
    end
    -- Figure out how many spells we need to generate
    local numberOfSpellsToGenerate = 0;
    if #characterSpells < wizardData.NumberOfSpells then
        numberOfSpellsToGenerate = #characterSpells;
    else
        numberOfSpellsToGenerate = wizardData.NumberOfSpells;
    end
    local remappedData = {
        NumberOfSpells = numberOfSpellsToGenerate,
        UnlockedSpells = characterSpells,
        LastGeneratedSpellTurn = wizardData.LastGeneratedSpellTurn,
    };
    return remappedData;
end

function WWLController:IsValidCharacterSkillKey(skillKey)
    if
    -- This first case is used be some of the Tomb Kings casters
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
    or (skillKey == "" or skillKey == "")
    then
        return true;
    end
    return false;
end

function WWLController:GetCharacterWizardDataWithName(nameText, faction, checkForLLNameKeys)
    self.Logger:Log("Checking for existing wizards");
    -- First we check if we can find the character alive in the faction
    local character_list = faction:character_list();
    for i = 0, character_list:num_items() - 1 do
        local character = character_list:item_at(i);
        if character:is_null_interface() == false then
            if character:military_force():is_null_interface() or character:military_force():is_armed_citizenry() == false then
                local forename = effect.get_localised_string(character:get_forename());
                local surname = effect.get_localised_string(character:get_surname());
                self.Logger:Log("Checking: "..forename.." "..surname);
                if string.match(nameText, forename.." "..surname) then
                    self.Logger:Log("Found match!");
                    return self:GetWizardData(character);
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
                    return defaultWizardData;
                end
            end
        end
    end
    -- If we still can't find them, then they aren't supported
    return nil;
end