require 'script/_lib/pooldata/CataphWizardsPoolData'

-- Load the name resources
-- This is separate so I can use this in other mods
if _G.WWLResources then
    out("WWL: Loading Cataph Data");
    _G.WWLResources:AddAdditionalDataResources("WizardData", GetCataphWizardsPoolData());
end