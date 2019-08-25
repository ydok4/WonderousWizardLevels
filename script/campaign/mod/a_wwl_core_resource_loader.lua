require 'script/_lib/pooldata/MagicLoresPoolData'
require 'script/_lib/pooldata/VanillaWizardsPoolData'

_G.WWLResources = {
        WizardData = GetVanillaWizardsPoolDataResources(),
        MagicLores = GetMagicLorePoolDataResources(),
        AddAdditionalWizardDataResources = function(resources)
    end,
};