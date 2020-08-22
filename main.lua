--require 'IDEInit'
require 'SkillTreeGenerator/lib/FileIO'
require 'SkillTreeGenerator/lib/Transformer'
-- Mighty campaigns
_G.IdTracker = 2765600000;
-- CRP
--_G.IdTracker = 2865500000;

VanillaDBs = {};
-- Load required vanilla db resources and db loc
DatabaseData = LoadVanillaDBs();
local dbPrefix = "@wwl_";

require 'script/campaign/mod/a_wwl_core_resource_loader'
require 'script/campaign/mod/z_wwl_cataph_resource_loader'
require 'script/campaign/mod/z_wwl_kislev_resource_loader'
require 'script/campaign/mod/z_wwl_mixu_resource_loader'
require 'script/campaign/mod/z_wwl_wez_speshul_resource_loader'

-- Generate the output db
local newDBData = CreateDBData(DatabaseData);

-- Output our new vanilla dbs/loc
OutputToFile(newDBData, dbPrefix, nil, false);

print("\n\nFinished!");