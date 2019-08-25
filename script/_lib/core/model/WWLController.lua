WWLController = {
    CampaignName = "",
    HumanFaction = {},
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
    self.Logger:Initialise("WonderousWizardLevels.txt", true);
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

function WWLController:IsSupportedCharacterSubType(characterSubtype)
    return _G.WWLResources.WizardData[characterSubtype] ~= nil;
end

function WWLController:SetupNewWizard(character)
    local characterCqi = character:command_queue_index();
    local characterLookupString = "character_cqi:"..characterCqi;
    local characterSubtype = character:character_subtype_key();
    local defaultWizardData = self:GetDefaultWizardDataForCharacterSubtype(characterSubtype);
    local defaultSpells = self:GetDefaultSpellsForWizard(defaultWizardData);
    self.WizardData[characterLookupString] = {
        NumberOfSpells = defaultWizardData.DefaultWizardLevel,
        UnlockedSpells = defaultSpells,
        LastGeneratedSpellTurn = 0,
    };
    return self.WizardData[characterLookupString];
end

function WWLController:GetDefaultWizardDataForCharacterSubtype(characterSubtype)
    return _G.WWLResources.WizardData[characterSubtype];
end

function WWLController:GetDefaultSpellsForWizard(wizardData)
    local magicLore = _G.WWLResources.MagicLores[wizardData.Lore];
    if wizardData.IsLord == true then
        local defaultSpells = magicLore.Level1DefaultSpellsLord;
        if wizardData.DefaultWizardLevel >= 3 then
            ConcatTable(defaultSpells, magicLore.Level3DefaultSpellsLord);
        end
        return defaultSpells;
    else
        local defaultSpells = magicLore.Level1DefaultSpells;
        if wizardData.DefaultWizardLevel >= 3 then
            ConcatTable(defaultSpells, magicLore.Level3DefaultSpells);
        end
        return defaultSpells;
    end
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
    elseif wizard.IsLoremaster == true and character:has_skill(wizard.LoremasterCharacterSkillKey) then
        self.Logger:Log("Character has loremaster skill. Not generating spells.");
        return;
    end
    local characterSubtype = character:character_subtype_key();
    local defaultWizardData = self:GetDefaultWizardDataForCharacterSubtype(characterSubtype);
    -- Remap the characters unlocked spells for easier manipulation
    local remappedWizardData = self:GetWizardDataCopy(wizard);
    -- Remove all disable spell skills
    for index, spellKey in pairs(remappedWizardData.UnlockedSpells) do
        if defaultWizardData.IsLord == true then
            cm:remove_effect_bundle_from_characters_force(spellKey.."_disable", characterCqi);
        else
            cm:force_remove_trait(characterLookupString, spellKey.."_disable");
        end
    end

    -- Then we disable spells required for our wizard level
    -- The remaining spells will equal our wizard level
    for i = 1, #remappedWizardData.UnlockedSpells - remappedWizardData.NumberOfSpells do
        local spellKey = GetAndRemoveRandomObjectFromList(remappedWizardData.UnlockedSpells);
        self.Logger:Log("Disabling spell: "..spellKey);
        if defaultWizardData.IsLord == true then
            cm:apply_effect_bundle_to_characters_force(spellKey.."_disable", characterCqi, -1, false);
        else
            cm:force_add_trait(characterLookupString, spellKey.."_disable");
        end
    end
    self.Logger:Log("Last turn number "..turnNumber);
    wizard.LastGeneratedSpellTurn = turnNumber;
end

function WWLController:GetWizardData(character)
    local characterCqi = character:command_queue_index();
    local characterLookupString = "character_cqi:"..characterCqi;
    local wizardData =  self.WizardData[characterLookupString];
    if wizardData == nil then
        wizardData = self:SetupNewWizard(character);
    end
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