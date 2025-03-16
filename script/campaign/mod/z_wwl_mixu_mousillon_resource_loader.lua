require 'script/_lib/pooldata/MixuMousillonWizardsPoolData'

-- Load the name resources
-- This is separate so I can use this in other mods
if _G.WWLResources then
    out("WWL: Loading Mixu Moussilon Data");
    _G.WWLResources:AddAdditionalDataResources("WizardData", GetMixuMousillonWizardsPoolData());
end