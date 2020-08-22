require 'script/_lib/pooldata/KislevWizardsPoolData'

-- Load the name resources
-- This is separate so I can use this in other mods
if _G.WWLResources then
    _G.WWLResources:AddAdditionalDataResources("WizardData", GetKislevWizardsPoolData());
end