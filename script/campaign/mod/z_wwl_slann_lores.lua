require 'script/_lib/pooldata/AllSlannLoresPoolData'

--out("WWL: Loading All Slann Lores Data");
-- Load the name resources
-- This is separate so I can use this in other mods
if _G.WWLResources then
    _G.WWLResources:AddAdditionalDataResources("WizardData", GetAllSlannLoresPoolData());
end