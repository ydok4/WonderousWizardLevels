WWL = {};
_G.WWL = WWL;

-- Helpers
require 'script/_lib/core/helpers/WWL_DataHelpers';
require 'script/_lib/core/helpers/WWL_LoadHelpers';
require 'script/_lib/core/helpers/WWL_SaveHelpers';
-- Models
require 'script/_lib/core/model/WWLController';
require 'script/_lib/core/model/Logger';
-- Listeners
require 'script/_lib/core/listeners/WWLListeners';


function z_wonderous_wizard_levels()
    out("WWL: Main mod function");
    WWL = WWLController:new({
        WizardData = WWL.WizardData,
    });
    WWL:Initialise(random_army_manager, false);
    WWL.Logger:Log("Initialised");
    WWL_SetupPostUIListeners(WWL);
    WWL.Logger:Log_Finished();
    out("WWL: Finished setup");
end

-- Saving/Loading Callbacks
cm:add_saving_game_callback(
    function(context)
        out("WWL: Saving callback");
        WWL_InitialiseSaveHelpers(cm, context);
        out("WWL: Finished saving");
    end
);

cm:add_loading_game_callback(
    function(context)
        out("WWL: Loading callback");
        WWL_InitialiseLoadHelpers(cm, context);
        out("WWL: Finished loading");
	end
);