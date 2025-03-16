require 'script/_lib/pooldata/MixuShadowdancerPoolData'

-- Load the name resources
-- This is separate so I can use this in other mods
if _G.WWLResources then
    out("WWL: Loading Mixu Shadowdancer Data");
    _G.WWLResources:AddAdditionalDataResources("WizardData", GetMixuShadowdancerPoolData());
end