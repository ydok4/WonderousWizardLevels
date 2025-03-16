require 'script/_lib/pooldata/XoudadWizardsPoolData'

if _G.WWLResources then
    out("WWL: Loading Xoudad Dragon Mage");
    _G.WWLResources:AddAdditionalDataResources("WizardData", GetXoudadDragonMagePoolData());
end