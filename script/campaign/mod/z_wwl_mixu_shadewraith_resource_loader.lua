require 'script/_lib/pooldata/MixuShadewraithPoolData'
require 'script/_lib/pooldata/MixuShadewraithNameKeys'

--out("WWL: Loading Mixu's Shadewraith data");
-- Load the name resources
-- This is separate so I can use this in other mods
if _G.WWLResources then
    _G.WWLResources:AddAdditionalDataResources("WizardData", GetMixuShadewraithPoolData());
    _G.WWLResources:AddAdditionalDataResources("LegendaryLordNameKeys", GetMixuShadewraithNameKeys());
end