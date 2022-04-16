require 'script/_lib/pooldata/WezSpeshulWizardsPoolData'

--out("WWL: Loading Wez Spesul Data");
-- Load the name resources
-- This is separate so I can use this in other mods
if _G.WWLResources
and (_G.IsIDE or core:is_mod_loaded("ws_start")) then
    _G.WWLResources:AddAdditionalDataResources("WizardData", GetWezSpeshulWizardsPoolData());
end