--require 'IDEInit'
require 'SkillTreeGenerator/lib/FileIO'
require 'SkillTreeGenerator/lib/Transformer'
-- Mighty campaigns
_G.IsIDE = true;
_G.IdTracker = 2765600000;
_G.IgnoreVanillaWizards = false;
--_G.IdTracker = 2865500000;

VanillaDBs = {};
-- Load required vanilla db resources and db loc
DatabaseData = LoadVanillaDBs();
local dbPrefix = "@wwl_skills_";

out = function(text)
    print(text);
end

require 'script/campaign/mod/a_wwl_core_resource_loader'
--require 'script/campaign/main_warhammer/mod/z_wwl_cataph_patch_lichemaster'
--require 'script/campaign/mod/z_wwl_slann_lores'
--require 'script/campaign/mod/z_wwl_cataph_resource_loader'
--require 'script/campaign/mod/z_wwl_deco_resource_loader'
--require 'script/campaign/mod/z_wwl_kislev_resource_loader'
--require 'script/campaign/mod/z_wwl_mixu_legendary_lords_resource_loader'
-- "@wwl_mixu_ll"
--require 'script/campaign/mod/z_wwl_mixu_mousillon_resource_loader'
--require 'script/campaign/mod/z_wwl_mixu_gnoblars_resource_loader'
--require 'script/campaign/mod/z_wwl_mixu_shadowdancer_resource_loader'
--require 'script/campaign/mod/z_wwl_mixu_shadewraith_resource_loader'
--require 'script/campaign/mod/z_wwl_ogre_lores_resource_loader'
--require 'script/campaign/mod/z_wwl_xoudad_uglies'
--require 'script/campaign/mod/z_wwl_xoudad_dragon_mage'

-- Generate the output db
local newDBData = CreateDBData(DatabaseData);

-- Output our new vanilla dbs/loc
OutputToFile(newDBData, dbPrefix, "@z_wwl_import", false);

print("\n\nFinished!");