require 'script/_lib/pooldata/MagicLoresPoolData'
require 'script/_lib/pooldata/VanillaWizardsPoolData'
require 'script/_lib/pooldata/VanillaUnitWizardsPoolData'
require 'script/_lib/pooldata/VanillaLegendaryLordNameKeys'

_G.WWLResources = {
    WizardData = GetVanillaWizardsPoolDataResources(),
    UnitData = GetVanillaUnitWizardPoolDataResources(),
    MagicLores = GetMagicLorePoolDataResources(),
    LegendaryLordNameKeys = GetVanillaLegendaryLordNameKeys(),
    AddAdditionalDataResources = function(self, destination, resources)
        for subcultureKey, dataList in pairs(resources) do
            for dataKey, data in pairs(dataList) do
                if self[destination][subcultureKey] == nil then
                    self[destination][subcultureKey] = {};
                end
                self[destination][subcultureKey][dataKey] = data;
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

-- Copy Daemon Data to Daemons of Chaos
CopySubcultureIntoOtherSubculture(_G.WWLResources.WizardData, "wh3_main_sc_tze_tzeentch", "wh3_main_sc_dae_daemons");
CopySubcultureIntoOtherSubculture(_G.WWLResources.WizardData, "wh3_main_sc_sla_slaanesh", "wh3_main_sc_dae_daemons");
CopySubcultureIntoOtherSubculture(_G.WWLResources.WizardData, "wh3_main_sc_nur_nurgle", "wh3_main_sc_dae_daemons");

CopySubcultureIntoOtherSubculture(_G.WWLResources.UnitData, "wh3_main_sc_tze_tzeentch", "wh3_main_sc_dae_daemons");
CopySubcultureIntoOtherSubculture(_G.WWLResources.UnitData, "wh3_main_sc_sla_slaanesh", "wh3_main_sc_dae_daemons");
CopySubcultureIntoOtherSubculture(_G.WWLResources.UnitData, "wh3_main_sc_nur_nurgle", "wh3_main_sc_dae_daemons");