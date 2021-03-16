if _G.IsIDE == true
or core:is_mod_loaded("liche_init") then
    require 'script/_lib/pooldata/CataphLichemasterPoolData'
    _G.WWLResources:AddAdditionalDataResources("WizardData", GetCataphLichemasterPoolData());
end