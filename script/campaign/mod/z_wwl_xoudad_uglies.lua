require 'script/_lib/pooldata/XoudadWizardsPoolData'

if _G.WWLResources then
    if _G.IsIDE == true or core:is_mod_loaded("@xou_nur_tamurkhan_ie") or core:is_mod_loaded("@xou_nur_tamurkhan_roc") then
        out("WWL: Loading Xoudad Uglies");
        _G.WWLResources:AddAdditionalDataResources("WizardData", GetXoudadUgliesWizardsPoolData());
    end
end