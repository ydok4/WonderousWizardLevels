require 'script/_lib/pooldata/MixuWizardsPoolData'
require 'script/_lib/pooldata/MixuLegendaryLordNameKeys'

--out("WWL: Loading Mixu Data");
-- Load the name resources
-- This is separate so I can use this in other mods
if _G.WWLResources then
    _G.WWLResources:AddAdditionalDataResources("WizardData", GetMixuWizardsPoolData());
end