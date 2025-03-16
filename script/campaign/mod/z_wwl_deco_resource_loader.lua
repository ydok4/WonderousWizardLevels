--[[require 'script/_lib/pooldata/DecoWizardsPoolData'

-- LEGACY
-- Load the name resources
-- This is separate so I can use this in other mods
if _G.WWLResources then
    _G.WWLResources:AddAdditionalDataResources("WizardData", GetDecoWizardsPoolData());
end--]]