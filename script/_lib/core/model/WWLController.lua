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
    local characterSubtype = character:character_subtype_key();
    local defaultWizardData = self:GetDefaultWizardDataForCharacterSubtype(characterSubtype);
    local defaultSpells = self:GetDefaultSpellsForWizard(defaultWizardData.Lore, defaultWizardData.DefaultWizardLevel);
    self.WizardData[characterCqi] = {
        WizardLevel = defaultWizardData.DefaultWizardLevel,
        UnlockedSpells = defaultSpells,
        LastGeneratedSpellTurn = 0,
    };
    return self.WizardData[characterCqi];
end

function WWLController:GetDefaultWizardDataForCharacterSubtype(characterSubtype)
    return _G.WWLResources.WizardData[characterSubtype];
end

function WWLController:GetDefaultSpellsForWizard(lore, wizardLevel)
    local magicLore = _G.WWLResources.MagicLores[lore];
    local defaultSpells = magicLore.Level1DefaultSpells;
    if wizardLevel >= 3 then
        ConcatTable(defaultSpells, magicLore.Level3DefaultSpells);
    end
    return defaultSpells;
end

function WWLController:SetSpellsForCharacter(character)
    local characterCqi = character:command_queue_index();
    local characterLookupString = "character_cqi:"..characterCqi;
    local wizard = {};
    -- Check if we have any existing character data
    -- Set them up if required
    if self.WizardData[characterCqi] == nil then
        wizard = self:SetupNewWizard(character);
    else
        wizard = self.WizardData[characterCqi];
    end
    local turnNumber = cm:model():turn_number();
    -- We don't regenerate spells more than once per turn
    -- and there is no point to generating spells for loremasters
    -- since they have them
    if wizard.LastGeneratedSpellTurn == turnNumber
    or wizard.IsLoremaster == true then
        return;
    end
    local characterSubtype = character:character_subtype_key();
    local defaultWizardData = self:GetDefaultWizardDataForCharacterSubtype(characterSubtype);
    -- Remap the characters unlocked spells for easier manipulation
    local remappedWizardData = self:GetWizardDataCopy(wizard);
    cm:disable_event_feed_events(true, "wh_event_category_agent", "", "");
    -- Remove all spell skills
    for index, spellKey in pairs(remappedWizardData.CharacterSpells) do
        if defaultWizardData.IsLord == false then
            cm:force_remove_trait(characterLookupString, spellKey.."_enable");
            cm:force_add_trait(characterLookupString, spellKey.."_disable");
        else
            cm:remove_effect_bundle_from_characters_force(spellKey.."_enable", characterCqi);
            cm:apply_effect_bundle_to_characters_force(spellKey.."_disable", characterCqi, -1, false);
        end
    end

    -- Then add the spells we've generated
    for i = 1, remappedWizardData.NumberOfSpells do
        local spellKey = GetAndRemoveRandomObjectFromList(remappedWizardData.CharacterSpells);
        self.Logger:Log("Adding spell: "..spellKey);
        if defaultWizardData.IsLord == false then
            cm:force_add_trait(characterLookupString, spellKey.."_enable");
            cm:force_remove_trait(characterLookupString, spellKey.."_disable");
        else
            cm:apply_effect_bundle_to_characters_force(spellKey.."_enable", characterCqi, -1, false);
            cm:remove_effect_bundle_from_characters_force(spellKey.."_disable", characterCqi);
        end
    end
    cm:callback(function() cm:disable_event_feed_events(false, "wh_event_category_agent","",""); end, 1);
    wizard.LastGeneratedSpellTurn = turnNumber;
end

function WWLController:GetWizardDataCopy(wizardData)
    local characterSpells = {};
    for index, spellKey in pairs(wizardData.UnlockedSpells) do
        characterSpells[#characterSpells + 1] = spellKey;
    end
    -- Figure out how many spells we need to generate
    local numberOfSpellsToGenerate = 0;
    if #characterSpells < wizardData.WizardLevel then
        numberOfSpellsToGenerate = #characterSpells;
    else
        numberOfSpellsToGenerate = wizardData.WizardLevel;
    end
    local remappedData = {
        NumberOfSpells = numberOfSpellsToGenerate,
        CharacterSpells = characterSpells,
        LastGeneratedSpellTurn = wizardData.LastGeneratedSpellTurn,
    };
    return remappedData;
end