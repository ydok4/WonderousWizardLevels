local MAX_NUM_SAVE_TABLE_KEYS = 400;

local cm = nil;
local context = nil;

function WWL_InitialiseLoadHelpers(cmObject, contextObject)
    out("WWL: Initialising load helpers");
    cm = cmObject;
    context = contextObject;
end

function WWL_LoadExistingWizardData(wwl)
    local wwl_existing_wizards_header = cm:load_named_value("wwl_existing_wizards_header", {}, context);
    if wwl_existing_wizards_header == nil or wwl_existing_wizards_header["TotalCharacters"] == nil then
        out("WWL: No wizard characters to load");
        return;
    else
        out("WWL: Loading "..wwl_existing_wizards_header["TotalCharacters"].." other characters");
    end

    local serialised_save_table_wizards = {};
    wwl.wizardData = {};
    local tableCount = math.ceil(wwl_existing_wizards_header["TotalCharacters"] / MAX_NUM_SAVE_TABLE_KEYS);
    for n = 1, tableCount do
        out("WWL: Loading table "..tostring(n));
        local nthTable = cm:load_named_value("wwl_existing_wizards_"..tostring(n), {}, context);
        ConcatTableWithKeys(serialised_save_table_wizards, nthTable);
    end
    out("WWL: Concatted serialised save data");

    for cqi, wizardData in pairs(serialised_save_table_wizards) do
        out("WWL: Loading wizard cqi: "..cqi);
        if wwl.wizardData[cqi] == nil then
            wwl.wizardData[cqi] = {};
        end
        wwl.wizardData[cqi] = {
            NumberOfSpells = wizardData[1],
            LastGeneratedSpellTurn = wizardData[2],
        };
    end

    out("WWL: Finished loading existing wizards");
end

function WWL_LoadExistingWizardSpells(wwl)
    local wwl_existing_wizard_spells_header = cm:load_named_value("wwl_existing_wizard_spells_header", {}, context);
    if wwl_existing_wizard_spells_header == nil or wwl_existing_wizard_spells_header["TotalSpells"] == nil then
        out("WWL: No wizard spells to load");
        return;
    else
        out("WWL: Loading "..wwl_existing_wizard_spells_header["TotalSpells"].." other characters");
    end

    local serialised_save_table_wizards = {};
    wwl.wizardData = {};
    local tableCount = math.ceil(wwl_existing_wizard_spells_header["TotalSpells"] / MAX_NUM_SAVE_TABLE_KEYS);
    for n = 1, tableCount do
        out("WWL: Loading table "..tostring(n));
        local nthTable = cm:load_named_value("wwl_existing_wizards_"..tostring(n), {}, context);
        ConcatTableWithKeys(serialised_save_table_wizards, nthTable);
    end
    out("WWL: Concatted serialised save data");

    for cqi, wizardSpells in pairs(serialised_save_table_wizards) do
        out("WWL: Loading wizard cqi: "..cqi);
        if wwl.wizardData[cqi] == nil then
            wwl.wizardData[cqi] = {};
        end
        wwl.wizardData[cqi].CharacterSpells = wizardSpells;
    end

    out("WWL: Finished loading wizard spells");
end