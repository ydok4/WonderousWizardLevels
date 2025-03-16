require 'script/_lib/pooldata/MixuLegendaryLordsPoolData'

-- Load the name resources
-- This is separate so I can use this in other mods
if _G.WWLResources then
    out("WWL: Loading Mixu Legendary Lord Data");
    _G.WWLResources:AddAdditionalDataResources("WizardData", GetMixuLegendaryLordsPoolData());
end