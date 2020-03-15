local MAX_NUM_SAVE_TABLE_KEYS = 200;

local cm = nil;
local context = nil;

function WWL_InitialiseSaveHelpers(cmObject, contextObject)
    out("WWL: Initialising save helpers");
    cm = cmObject;
    context = contextObject;
end

function WWL_SaveExistingWizardData(wwl)
    if cm == nil then
        out("WWL: Can't access CM");
        return;
    end

    out("WWL: Saving existing wizards");
    local wwl_existing_wizards_header = {};

    local numberOfCurrentWizards = 0;
    local tableCount = 1;
    local nthTable = {};

    for characterLookupString, wizardData in pairs(wwl.WizardData) do
        nthTable[characterLookupString] = { wizardData.NumberOfSpells, wizardData.LastGeneratedSpellTurn };
        numberOfCurrentWizards = numberOfCurrentWizards + 1;
        if numberOfCurrentWizards % MAX_NUM_SAVE_TABLE_KEYS == 0 then
            out("WWL: Saving table number "..(tableCount + 1));
            cm:save_named_value("wwl_existing_wizards_"..tableCount, nthTable, context);
            tableCount = tableCount + 1;
            nthTable = {};
        end
    end
    -- Saving the remaining units
    cm:save_named_value("wwl_existing_wizards_"..tableCount, nthTable, context);
    out("WWL: Saving "..numberOfCurrentWizards.." existing wizards.");

    wwl_existing_wizards_header["TotalCharacters"] = numberOfCurrentWizards;
    cm:save_named_value("wwl_existing_wizards_header", wwl_existing_wizards_header, context);
end

function WWL_SaveExistingWizardSpells(wwl)
    if cm == nil then
        out("WWL: Can't access CM");
        return;
    end

    out("WWL: Saving existing wizard spells");
    local wwl_existing_wizard_spells_header = {};

    local numberOfCurrentWizardSpells = 0;
    local tableCount = 1;
    local nthTable = {};

    for characterLookupString, wizardData in pairs(wwl.WizardData) do
        nthTable[characterLookupString] = wizardData.UnlockedSpells;
        numberOfCurrentWizardSpells = numberOfCurrentWizardSpells + 1;
        if numberOfCurrentWizardSpells % MAX_NUM_SAVE_TABLE_KEYS == 0 then
            out("WWL: Saving table number "..(tableCount + 1));
            cm:save_named_value("wwl_existing_wizard_spells_"..tableCount, nthTable, context);
            tableCount = tableCount + 1;
            nthTable = {};
        end
    end
    -- Saving the remaining units
    cm:save_named_value("wwl_existing_wizard_spells_"..tableCount, nthTable, context);
    out("WWL: Saving "..numberOfCurrentWizardSpells.." existing wizard spells.");

    wwl_existing_wizard_spells_header["TotalSpells"] = numberOfCurrentWizardSpells;
    cm:save_named_value("wwl_existing_wizard_spells_header", wwl_existing_wizard_spells_header, context);
end