require 'script/_lib/pooldata/MixuGnoblarsWizardsPoolData'

-- Load the name resources
-- This is separate so I can use this in other mods
if _G.WWLResources then
    out("WWL: Loading Mixu Gnoblar Data");
    _G.WWLResources:AddAdditionalDataResources("WizardData", GetMixuGnoblarsWizardsPoolData());
end