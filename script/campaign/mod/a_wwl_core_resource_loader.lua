require 'script/_lib/pooldata/MagicLoresPoolData'
require 'script/_lib/pooldata/SpellFragmentsForLoresPoolData'
require 'script/_lib/pooldata/VanillaWizardsPoolData'
require 'script/_lib/pooldata/VanillaUnitWizardsPoolData'

_G.WWLResources = {
    -- When loading resources this allows us to cleanly
    -- setup reference between subcultures, eg: The daemon prince faction
    SubculturesToRemap = {
        wh3_main_sc_nur_nurgle = {
            "wh3_main_sc_dae_daemons",
        },
        wh3_main_sc_sla_slaanesh = {
            "wh3_main_sc_dae_daemons",
        },
        wh3_main_sc_tze_tzeentch = {
            "wh3_main_sc_dae_daemons",
        },
    };
    -- Wizard data is now blank by default so I can load it with AddAdditionalDataResources
    -- and use the function to remap the data without changing the structure.
    -- This allows all wizards to be used for all subcultures without too much additional work.
    WizardData = {},
    -- For UI purposes we still need to know the standard wizards for each subculture
    WizardsToSubculture = {};
    AncillaryData = GetSpellFragmentsForLores(),
    -- At this stage, unused but if I can get it working, will be used by an addon
    UnitData = GetVanillaUnitWizardPoolDataResources(),
    MagicLores = GetMagicLorePoolDataResources(),
    -- Legacy features, CCOs took care of the need for this
    LegendaryLordNameKeys = {},
    AddAdditionalDataResources = function(self, destination, resources)
        for subcultureKey, dataList in pairs(resources) do
            for dataKey, data in pairs(dataList) do
                self[destination][dataKey] = data;
                -- We remap the WizardData so we have an arrangement that is also organised by subculture.
                -- This is useful for some of the UI checks we're doing.
                if destination == "WizardData" then
                    if self.WizardsToSubculture[subcultureKey] == nil then
                        self.WizardsToSubculture[subcultureKey] = {};
                    end
                    self.WizardsToSubculture[subcultureKey][dataKey] = self[destination][dataKey];
                    if self.SubculturesToRemap[subcultureKey] ~= nil then
                        for index, mapToSubcultureKey in pairs(self.SubculturesToRemap[subcultureKey]) do
                            if self.WizardsToSubculture[mapToSubcultureKey] == nil then
                                self.WizardsToSubculture[mapToSubcultureKey] = {};
                            end
                            self.WizardsToSubculture[mapToSubcultureKey][dataKey] = self[destination][dataKey];
                        end
                    end
                end
            end
        end
    end,
};

function CopySubcultureIntoOtherSubculture(dataSource, fromSubculture, toSubculture)
    if dataSource[toSubculture] == nil then
        dataSource[toSubculture] = {};
    end
    for agent_subtype, agent_subtype_data in pairs(dataSource[fromSubculture]) do
        dataSource[toSubculture][agent_subtype] = {
            DefaultWizardLevel = agent_subtype_data.DefaultWizardLevel,
            Lore = agent_subtype_data.Lore,
        };
    end
end

-- We need to ability to look up any agent in case a mod enables hero/agent conversion, so
-- now we pump the data through the loader function because it will remap everything nicely for us
_G.WWLResources:AddAdditionalDataResources("WizardData", GetVanillaWizardsPoolDataResources());
