require 'script/_lib/pooldata/MixuShadowdancerPoolData'

--out("WWL: Loading Mixu Legendary Lord Data");
-- Load the name resources
-- This is separate so I can use this in other mods
if _G.WWLResources then
    _G.WWLResources:AddAdditionalDataResources("WizardData", GetMixuShadowdancerPoolData());
end