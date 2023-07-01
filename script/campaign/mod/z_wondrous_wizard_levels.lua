WWL = {};
_G.WWL = WWL;

-- Helpers
require 'script/_lib/core/helpers/WWL_DataHelpers';
-- Models
require 'script/_lib/core/model/WWLController';
require 'script/_lib/core/model/Logger';
-- Listeners
require 'script/_lib/core/listeners/WWLListeners';

function z_wondrous_wizard_levels()
    out("WWL: Main mod function");
    WWL = WWLController:new({
        WizardData = WWL.WizardData,
    });
    local enableLogging = true;
    --[[if __write_output_to_logfile then
        enableLogging = true;
    end--]]
    WWL:Initialise(enableLogging, effect);
    WWL.Logger:Log("Initialised");
    WWL_SetupPostUIListeners(WWL, core, find_uicomponent, UIComponent);
    WWL.Logger:Log_Finished();
    out("WWL: Finished setup");
end