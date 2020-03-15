if core:is_mod_loaded("liche_init") then
    out("WWL: Found lichemaster");
    require 'script/_lib/pooldata/CataphLichemasterPoolData'
    _G.WWLResources:AddAdditionalDataResources("WizardData", GetCataphLichemasterPoolData());
end