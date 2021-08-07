--[[require 'script/_lib/pooldata/DecoWizardsPoolData'

--out("WWL: Loading Wez Spesul Data");
-- Load the name resources
-- This is separate so I can use this in other mods
if _G.WWLResources then
    _G.WWLResources:AddAdditionalDataResources("WizardData", GetDecoWizardsPoolData());
end--]]