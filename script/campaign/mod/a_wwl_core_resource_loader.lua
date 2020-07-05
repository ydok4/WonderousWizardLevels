require 'script/_lib/pooldata/MagicLoresPoolData'
require 'script/_lib/pooldata/VanillaWizardsPoolData'
require 'script/_lib/pooldata/VanillaLegendaryLordNameKeys'

_G.WWLResources = {
    WizardData = GetVanillaWizardsPoolDataResources(),
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