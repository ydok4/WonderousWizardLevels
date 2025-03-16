require 'script/_lib/pooldata/WezSpeshulWizardsPoolData'

-- Load the name resources
-- This is separate so I can use this in other mods
if _G.WWLResources then
    --out("WWL: Loading Wez Speshul Data");
    _G.WWLResources:AddAdditionalDataResources("WizardData", GetWezSpeshulWizardsPoolData());
end