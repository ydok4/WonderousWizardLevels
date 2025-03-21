require '/SkillTreeGenerator/lib/Table';

local VanillaDBs = {};
function LoadVanillaDBs()
    print("\n\nLoading supported db files");
    -- Load the core vanilla files
    LoadFile("SkillTreeGenerator/DB/Core/WH3/db/character_skill_level_to_effects_junctions_tables/data__.tsv", "character_skill_level_to_effects_junctions_tables");

    LoadFile("SkillTreeGenerator/DB/Core/WH3/db/character_skill_node_links_tables/data__.tsv", "character_skill_node_links_tables");
    LoadFile("SkillTreeGenerator/DB/Core/WH3/db/character_skill_node_sets_tables/data__.tsv", "character_skill_node_sets_tables");
    LoadFile("SkillTreeGenerator/DB/Core/WH3/db/character_skill_node_set_items_tables/data__.tsv", "character_skill_node_set_items_tables");
    LoadFile("SkillTreeGenerator/DB/Core/WH3/db/character_skill_nodes_tables/data__.tsv", "character_skill_nodes_tables");
    LoadFile("SkillTreeGenerator/DB/Core/WH3/db/character_skills_tables/data__.tsv", "character_skills_tables");
    LoadFile("SkillTreeGenerator/DB/Core/WH3/db/effects_tables/data__.tsv", "effects_tables");
    LoadFile("SkillTreeGenerator/DB/Core/WH3/db/effect_bonus_value_unit_ability_junctions_tables/data__.tsv", "effect_bonus_value_unit_ability_junctions_tables");
    --LoadFile("SkillTreeGenerator/DB/Core/WH2/special_ability_group_parents_tables_data__.tsv", "special_ability_group_parents_tables");
    LoadFile("SkillTreeGenerator/DB/Core/WH3/db/special_ability_groups_tables/data__.tsv", "special_ability_groups_tables");
    LoadFile("SkillTreeGenerator/DB/Core/WH3/db/special_ability_groups_to_unit_abilities_junctions_tables/data__.tsv", "special_ability_groups_to_unit_abilities_junctions_tables");
    LoadFile("SkillTreeGenerator/DB/Core/WH3/db/unit_abilities_tables/data__.tsv", "unit_abilities_tables");
    LoadFile("SkillTreeGenerator/DB/Core/WH3/db/unit_special_abilities_tables/data__.tsv", "unit_special_abilities_tables");

    LoadFile("SkillTreeGenerator/DB/Core/WH3/text/db/effects__.loc.tsv", "effects_loc");
    LoadFile("SkillTreeGenerator/DB/Core/WH3/text/db/character_skills__.loc.tsv", "character_skills_loc");

    -- Kislev - Bonus Lores
    --[[LoadFile("SkillTreeGenerator/DB/Core/Kislev/character_skill_level_to_effects_junctions_tables_mixu_ice_magic.tsv", "character_skill_level_to_effects_junctions_tables");
    LoadFile("SkillTreeGenerator/DB/Core/Kislev/character_skill_level_to_effects_junctions_tables_KisD_icewitch.tsv", "character_skill_level_to_effects_junctions_tables");

    LoadFile("SkillTreeGenerator/DB/Core/Kislev/effects_tables_KisD_icewitch.tsv", "effects_tables");
    LoadFile("SkillTreeGenerator/DB/Core/Kislev/effects_tables_mixu_katarin.tsv", "effects_tables");

    LoadFile("SkillTreeGenerator/DB/Core/Kislev/effect_bonus_value_unit_ability_junctions_tables_KisD_icewitch.tsv", "effect_bonus_value_unit_ability_junctions_tables");
    LoadFile("SkillTreeGenerator/DB/Core/Kislev/effect_bonus_value_unit_ability_junctions_tables_mixu_ice_magic.tsv", "effect_bonus_value_unit_ability_junctions_tables");--]]

    --LoadFile("SkillTreeGenerator/DB/Core/Kislev/character_skill_node_sets_tables_KisD_characters.tsv", "character_skill_node_sets_tables");
    --LoadFile("SkillTreeGenerator/DB/Core/Kislev/character_skill_node_sets_tables_mixu_katarin.tsv", "character_skill_node_sets_tables");

    --[[LoadFile("SkillTreeGenerator/DB/Core/Kislev/character_skill_nodes_tables_KisD_witches.tsv", "character_skill_nodes_tables");
    LoadFile("SkillTreeGenerator/DB/Core/Kislev/character_skill_nodes_tables_mixu_katarin.tsv", "character_skill_nodes_tables");

    LoadFile("SkillTreeGenerator/DB/Core/Kislev/character_skills_tables_KisD_icewitch.tsv", "character_skills_tables");
    LoadFile("SkillTreeGenerator/DB/Core/Kislev/character_skills_tables_mixu_katarin.tsv", "character_skills_tables");
    LoadFile("SkillTreeGenerator/DB/Core/Kislev/KisD_character_skills.loc.tsv", "character_skills_loc");
    LoadFile("SkillTreeGenerator/DB/Core/Kislev/KisD_character_skills_magic.loc.tsv", "character_skills_loc");
    LoadFile("SkillTreeGenerator/DB/Core/Kislev/mixu_ice_magic.loc.tsv", "character_skills_loc");

    LoadFile("SkillTreeGenerator/DB/Core/Kislev/special_ability_groups_tables_KisD_icewitch.tsv", "special_ability_groups_tables");
    LoadFile("SkillTreeGenerator/DB/Core/Kislev/special_ability_groups_tables_mixu_katarin.tsv", "special_ability_groups_tables");
    LoadFile("SkillTreeGenerator/DB/Core/Kislev/special_ability_groups_to_unit_abilities_junctions_tables_KisD_icewitch.tsv", "special_ability_groups_to_unit_abilities_junctions_tables");
    LoadFile("SkillTreeGenerator/DB/Core/Kislev/special_ability_groups_to_unit_abilities_junctions_tables_mixu_katarin.tsv", "special_ability_groups_to_unit_abilities_junctions_tables");
    LoadFile("SkillTreeGenerator/DB/Core/Kislev/unit_abilities_tables_KisD_icewitch.tsv", "unit_abilities_tables");
    LoadFile("SkillTreeGenerator/DB/Core/Kislev/unit_abilities_tables_mixu_katarin.tsv", "unit_abilities_tables");--]]

    -- Wez Speshul - Bonus Lores
    if _G.IsIdeWezSpeshulLoaded == true then
        LoadFile("SkillTreeGenerator/DB/Core/WH3/WezSpeshul/db/character_skill_level_to_effects_junctions_tables/ws_.tsv", "character_skill_level_to_effects_junctions_tables");

        LoadFile("SkillTreeGenerator/DB/Core/WH3/WezSpeshul/db/effects_tables/ws_.tsv", "effects_tables");
        LoadFile("SkillTreeGenerator/DB/Core/WH3/WezSpeshul/text/db/ws_effects__.loc.tsv", "effects_loc");

        LoadFile("SkillTreeGenerator/DB/Core/WH3/WezSpeshul/db/effect_bonus_value_unit_ability_junctions_tables/ws_.tsv", "effect_bonus_value_unit_ability_junctions_tables");

        LoadFile("SkillTreeGenerator/DB/Core/WH3/WezSpeshul/db/character_skills_tables/ws_.tsv", "character_skills_tables");
        LoadFile("SkillTreeGenerator/DB/Core/WH3/WezSpeshul/text/db/ws_character_skills__.loc.tsv", "character_skills_loc");

        LoadFile("SkillTreeGenerator/DB/Core/WH3/WezSpeshul/db/special_ability_groups_tables/ws_.tsv", "special_ability_groups_tables");

        LoadFile("SkillTreeGenerator/DB/Core/WH3/WezSpeshul/db/special_ability_groups_to_unit_abilities_junctions_tables/ws_.tsv", "special_ability_groups_to_unit_abilities_junctions_tables");

        LoadFile("SkillTreeGenerator/DB/Core/WH3/WezSpeshul/db/special_ability_groups_to_units_junctions_tables/ws_.tsv", "special_ability_groups_to_units_junctions_tables");

        LoadFile("SkillTreeGenerator/DB/Core/WH3/WezSpeshul/db/unit_abilities_tables/ws_.tsv", "unit_abilities_tables");
    end

    -- Load the additional supported mod files
    --LoadFile("SkillTreeGenerator/DB/Core/character_skill_node_sets_tables_aa_mixu_ll_I_redux.tsv", "character_skill_node_sets_tables");
    --LoadFile("SkillTreeGenerator/DB/Core/character_skill_node_sets_tables_ab_kouran_darkhand.tsv", "character_skill_node_sets_tables");
    --LoadFile("SkillTreeGenerator/DB/Core/character_skill_node_sets_tables_mixu_ttl.tsv", "character_skill_node_sets_tables");
    --LoadFile("SkillTreeGenerator/DB/Core/character_skill_node_sets_tables_AK_teb.tsv", "character_skill_node_sets_tables");
    --LoadFile("SkillTreeGenerator/DB/Core/character_skill_node_sets_tables_AK_mages.tsv", "character_skill_node_sets_tables");
    --LoadFile("SkillTreeGenerator/DB/Core/WezSpeshul/character_skill_node_sets_tables_ws_.tsv", "character_skill_node_sets_tables");
    --LoadFile("SkillTreeGenerator/DB/Core/Mousillon/character_skill_node_sets_tables_mixu_mousillon.tsv", "character_skill_node_sets_tables");
    --LoadFile("SkillTreeGenerator/DB/Core/Deco/character_skill_node_sets_tables_data__deco_beastmen_shaman.tsv", "character_skill_node_sets_tables");
    --LoadFile("SkillTreeGenerator/DB/Core/Lichemaster/character_skill_node_sets_tables_AK_hobo.tsv", "character_skill_node_sets_tables");
    --LoadFile("SkillTreeGenerator/DB/Core/All Slann Lores/character_skill_node_sets_tables_obsidian_new_slann.tsv", "character_skill_node_sets_tables");
    --LoadFile("SkillTreeGenerator/DB/Core/Xoudad - Dragon Mage/character_skill_node_sets_tables_xou_hef_dragon_mage.tsv", "character_skill_node_sets_tables");
    --LoadFile("SkillTreeGenerator/DB/Core/Shadewraith/character_skill_node_sets_tables_ab_mixu_shadewraith.tsv", "character_skill_node_sets_tables");
    --LoadFile("SkillTreeGenerator/DB/Core/WH3/Ogres/character_skill_node_set_items_tables_adv_ogre_lores.tsv", "character_skill_node_set_items_tables");
    LoadFile("SkillTreeGenerator/DB/Core/WH3/MixuLL/db/character_skill_node_set_items_tables/ab_mixu_legendary_lords.tsv", "character_skill_node_set_items_tables");
    LoadFile("SkillTreeGenerator/DB/Core/WH3/MixuMoussilon/character_skill_node_set_items_tables_ab_mixu_mousillon.tsv", "character_skill_node_set_items_tables");
    LoadFile("SkillTreeGenerator/DB/Core/WH3/MixuShadowdancer/character_skill_node_set_items_tables_ab_mixu_shadowdancer.tsv", "character_skill_node_set_items_tables");
    LoadFile("SkillTreeGenerator/DB/Core/WH3/MixuGnoblars/db/character_skill_node_set_items_tables/ab_unwashed_masses.tsv", "character_skill_node_set_items_tables");
    LoadFile("SkillTreeGenerator/DB/Core/WH3/TEB/character_skill_node_set_items_tables_ak_teb_LL_gashnag.tsv", "character_skill_node_set_items_tables");
    LoadFile("SkillTreeGenerator/DB/Core/WH3/TEB/character_skill_node_set_items_tables_ak_teb_LL_lucrezzia.tsv", "character_skill_node_set_items_tables");
    LoadFile("SkillTreeGenerator/DB/Core/WH3/WezSpeshul/db/character_skill_node_set_items_tables/ws_.tsv", "character_skill_node_set_items_tables");
    LoadFile("SkillTreeGenerator/DB/Core/WH3/WezSpeshul/db/character_skill_node_set_items_tables/ws_bp.tsv", "character_skill_node_set_items_tables");
    LoadFile("SkillTreeGenerator/DB/Core/WH3/Xoudad/character_skill_node_set_items_tables_dead_xou_gold.tsv", "character_skill_node_set_items_tables");
    LoadFile("SkillTreeGenerator/DB/Core/WH3/XoudadDragonMage/db/character_skill_node_set_items_tables/@xou_high_elves.tsv", "character_skill_node_set_items_tables");
    LoadFile("SkillTreeGenerator/DB/Core/WH3/XoudadUglies/db/character_skill_node_set_items_tables/@xou_nur_tamurkhan.tsv", "character_skill_node_set_items_tables");
    LoadFile("SkillTreeGenerator/DB/Core/WH3/XoudadUglies/db/character_skill_node_set_items_tables/@xou_nur_tamurkhan_vanilla.tsv", "character_skill_node_set_items_tables");

    --LoadFile("SkillTreeGenerator/DB/Core/WH3/Ogres/character_skill_node_sets_tables_adv_ogre_lore_data__.tsv", "character_skill_node_sets_tables");
    LoadFile("SkillTreeGenerator/DB/Core/WH3/MixuLL/db/character_skill_node_sets_tables/mixu_legendary_lords.tsv", "character_skill_node_sets_tables");
    LoadFile("SkillTreeGenerator/DB/Core/WH3/MixuGnoblars/db/character_skill_node_sets_tables/gnob.tsv", "character_skill_node_sets_tables");
    LoadFile("SkillTreeGenerator/DB/Core/WH3/MixuShadowdancer/character_skill_node_sets_tables_ab_mixu_shadowdancer.tsv", "character_skill_node_sets_tables");
    LoadFile("SkillTreeGenerator/DB/Core/WH3/MixuMoussilon/character_skill_node_sets_tables_ab_mixu_mousillon_new.tsv", "character_skill_node_sets_tables");
    LoadFile("SkillTreeGenerator/DB/Core/WH3/TEB/character_skill_node_sets_tables_AK_teb.tsv", "character_skill_node_sets_tables");
    LoadFile("SkillTreeGenerator/DB/Core/WH3/WezSpeshul/db/character_skill_node_sets_tables/ws_.tsv", "character_skill_node_sets_tables");
    LoadFile("SkillTreeGenerator/DB/Core/WH3/WezSpeshul/db/character_skill_node_sets_tables/ws_bp.tsv", "character_skill_node_sets_tables");
    LoadFile("SkillTreeGenerator/DB/Core/WH3/Xoudad/character_skill_node_sets_tables_dead_xou_gold.tsv", "character_skill_node_sets_tables");
    LoadFile("SkillTreeGenerator/DB/Core/WH3/XoudadDragonMage/db/character_skill_node_sets_tables/@xou_high_elves.tsv", "character_skill_node_sets_tables");

    
    --[[LoadFile("SkillTreeGenerator/DB/Core/character_skill_nodes_tables_!_ab_mixu_le_override.tsv", "character_skill_nodes_tables");
    LoadFile("SkillTreeGenerator/DB/Core/character_skill_nodes_tables_ab_hef_belannaer.tsv", "character_skill_nodes_tables");
    LoadFile("SkillTreeGenerator/DB/Core/character_skill_nodes_tables_mixu_bst_slugtongue.tsv", "character_skill_nodes_tables");
    LoadFile("SkillTreeGenerator/DB/Core/character_skill_nodes_tables_ab_lzd_lord_huinitenuchli.tsv", "character_skill_nodes_tables");
    LoadFile("SkillTreeGenerator/DB/Core/character_skill_nodes_tables_mixu_lzd_tetto_eko.tsv", "character_skill_nodes_tables");
    LoadFile("SkillTreeGenerator/DB/Core/character_skill_nodes_tables_mixu_chs_egrimm_van_horstmann.tsv", "character_skill_nodes_tables");
    LoadFile("SkillTreeGenerator/DB/Core/character_skill_nodes_tables_mixu_skv_feskit.tsv", "character_skill_nodes_tables");
    LoadFile("SkillTreeGenerator/DB/Core/character_skill_nodes_tables_mixu_le_huss.tsv", "character_skill_nodes_tables");
    LoadFile("SkillTreeGenerator/DB/Core/character_skill_nodes_tables_mixu_wef_naeith.tsv", "character_skill_nodes_tables");
    LoadFile("SkillTreeGenerator/DB/Core/character_skill_nodes_tables_mixu_ttl_empire.tsv", "character_skill_nodes_tables");
    LoadFile("SkillTreeGenerator/DB/Core/character_skill_nodes_tables_mixu_ttl_greenskins.tsv", "character_skill_nodes_tables");
    LoadFile("SkillTreeGenerator/DB/Core/character_skill_nodes_tables_mixu_ttl_norsca.tsv", "character_skill_nodes_tables");
    LoadFile("SkillTreeGenerator/DB/Core/character_skill_nodes_tables_mixu_ttl_tomb_kings.tsv", "character_skill_nodes_tables");
    LoadFile("SkillTreeGenerator/DB/Core/character_skill_nodes_tables_mixu_ttl_wood_elves.tsv", "character_skill_nodes_tables");
    LoadFile("SkillTreeGenerator/DB/Core/character_skill_nodes_tables_AK_teb_LL_gashnag.tsv", "character_skill_nodes_tables");
    LoadFile("SkillTreeGenerator/DB/Core/character_skill_nodes_tables_AK_teb_LL_lucrezzia.tsv", "character_skill_nodes_tables");
    LoadFile("SkillTreeGenerator/DB/Core/character_skill_nodes_tables_AK_mages.tsv", "character_skill_nodes_tables");
    LoadFile("SkillTreeGenerator/DB/Core/Mousillon/character_skill_nodes_tables_!!!!!aa_mixu_red_duke.tsv", "character_skill_nodes_tables");
    LoadFile("SkillTreeGenerator/DB/Core/Mousillon/character_skill_nodes_tables_mixu_mousillon_bloodlines.tsv", "character_skill_nodes_tables");
    LoadFile("SkillTreeGenerator/DB/Core/Mousillon/character_skill_nodes_tables_mixu_mousillon_characters.tsv", "character_skill_nodes_tables");
    LoadFile("SkillTreeGenerator/DB/Core/Mousillon/character_skill_nodes_tables_mixu_mousillon_knights_of_mallobaude.tsv", "character_skill_nodes_tables");
    LoadFile("SkillTreeGenerator/DB/Core/Deco/character_skill_nodes_tables_data__deco_beastmen_shaman.tsv", "character_skill_nodes_tables");
    LoadFile("SkillTreeGenerator/DB/Core/Lichemaster/character_skill_nodes_tables_AAK_hobo_heroes.tsv", "character_skill_nodes_tables");--]]
    --LoadFile("SkillTreeGenerator/DB/Core/WezSpeshul/character_skill_nodes_tables_ws_heroes.tsv", "character_skill_nodes_tables");
    --LoadFile("SkillTreeGenerator/DB/Core/WezSpeshul/character_skill_nodes_tables_ws_lords.tsv", "character_skill_nodes_tables");
    --LoadFile("SkillTreeGenerator/DB/Core/All Slann Lores/character_skill_nodes_tables_obsidian_new_slann.tsv", "character_skill_nodes_tables");
    --LoadFile("SkillTreeGenerator/DB/Core/Xoudad - Dragon Mage/character_skill_nodes_tables_!xou_hef_dragon_mage.tsv", "character_skill_nodes_tables");
    --LoadFile("SkillTreeGenerator/DB/Core/Shadewraith/character_skill_nodes_tables_mixu_khoskog.tsv", "character_skill_nodes_tables");
    --LoadFile("SkillTreeGenerator/DB/Core/Shadewraith/character_skill_nodes_tables_mixu_tia_drowna.tsv", "character_skill_nodes_tables");
    LoadFile("SkillTreeGenerator/DB/Core/WH3/MixuLL/db/character_skill_nodes_tables/mixu_ll_beastmen.tsv", "character_skill_nodes_tables");
    LoadFile("SkillTreeGenerator/DB/Core/WH3/MixuLL/db/character_skill_nodes_tables/mixu_ll_bretonnia.tsv", "character_skill_nodes_tables");
    LoadFile("SkillTreeGenerator/DB/Core/WH3/MixuLL/db/character_skill_nodes_tables/mixu_ll_cabal_nonsense.tsv", "character_skill_nodes_tables");
    LoadFile("SkillTreeGenerator/DB/Core/WH3/MixuLL/db/character_skill_nodes_tables/mixu_ll_chaos.tsv", "character_skill_nodes_tables");
    LoadFile("SkillTreeGenerator/DB/Core/WH3/MixuLL/db/character_skill_nodes_tables/mixu_ll_dark_elves.tsv", "character_skill_nodes_tables");
    LoadFile("SkillTreeGenerator/DB/Core/WH3/MixuLL/db/character_skill_nodes_tables/mixu_ll_dwarfs.tsv", "character_skill_nodes_tables");
    LoadFile("SkillTreeGenerator/DB/Core/WH3/MixuLL/db/character_skill_nodes_tables/mixu_ll_empire.tsv", "character_skill_nodes_tables");
    LoadFile("SkillTreeGenerator/DB/Core/WH3/MixuLL/db/character_skill_nodes_tables/mixu_ll_greenskins.tsv", "character_skill_nodes_tables");
    LoadFile("SkillTreeGenerator/DB/Core/WH3/MixuLL/db/character_skill_nodes_tables/mixu_ll_high_elves.tsv", "character_skill_nodes_tables");
    LoadFile("SkillTreeGenerator/DB/Core/WH3/MixuLL/db/character_skill_nodes_tables/mixu_ll_lizardmen.tsv", "character_skill_nodes_tables");
    LoadFile("SkillTreeGenerator/DB/Core/WH3/MixuLL/db/character_skill_nodes_tables/mixu_ll_norsca.tsv", "character_skill_nodes_tables");
    LoadFile("SkillTreeGenerator/DB/Core/WH3/MixuLL/db/character_skill_nodes_tables/mixu_ll_skaven.tsv", "character_skill_nodes_tables");
    LoadFile("SkillTreeGenerator/DB/Core/WH3/MixuLL/db/character_skill_nodes_tables/mixu_ll_tomb_kings.tsv", "character_skill_nodes_tables");
    LoadFile("SkillTreeGenerator/DB/Core/WH3/MixuLL/db/character_skill_nodes_tables/mixu_ll_vampire_coast.tsv", "character_skill_nodes_tables");
    LoadFile("SkillTreeGenerator/DB/Core/WH3/MixuLL/db/character_skill_nodes_tables/mixu_ll_wood_elves.tsv", "character_skill_nodes_tables");
    LoadFile("SkillTreeGenerator/DB/Core/WH3/MixuLL/db/character_skill_nodes_tables/mixu_ll_ze_test_chamber.tsv", "character_skill_nodes_tables");
    LoadFile("SkillTreeGenerator/DB/Core/WH3/MixuMoussilon/character_skill_nodes_tables_ab_mixus_mousillon_vanilla.tsv", "character_skill_nodes_tables");
    LoadFile("SkillTreeGenerator/DB/Core/WH3/MixuMoussilon/character_skill_nodes_tables_mixu_mousillon.tsv", "character_skill_nodes_tables");
    LoadFile("SkillTreeGenerator/DB/Core/WH3/MixuShadowdancer/character_skill_nodes_tables_ab_mixu_shadowdancer.tsv", "character_skill_nodes_tables");
    LoadFile("SkillTreeGenerator/DB/Core/WH3/WezSpeshul/db/character_skill_nodes_tables/ws_.tsv", "character_skill_nodes_tables");
    LoadFile("SkillTreeGenerator/DB/Core/WH3/WezSpeshul/db/character_skill_nodes_tables/ws_bp.tsv", "character_skill_nodes_tables");

    --LoadFile("SkillTreeGenerator/DB/Core/WH3/Ogres/character_skill_nodes_tables_adv_ogre_lore_new_data__ .tsv", "character_skill_nodes_tables");
    --LoadFile("SkillTreeGenerator/DB/Core/WH3/Ogres/character_skill_nodes_tables_adv_ogre_lore_data__.tsv", "character_skill_nodes_tables");
    LoadFile("SkillTreeGenerator/DB/Core/WH3/MixuGnoblars/db/character_skill_nodes_tables/gnob_generic.tsv", "character_skill_nodes_tables");
    LoadFile("SkillTreeGenerator/DB/Core/WH3/MixuGnoblars/db/character_skill_nodes_tables/ab_unwashed_masses_dev.tsv", "character_skill_nodes_tables");
    LoadFile("SkillTreeGenerator/DB/Core/WH3/TEB/character_skill_nodes_tables_AK_teb_LL_gashnag.tsv", "character_skill_nodes_tables");
    LoadFile("SkillTreeGenerator/DB/Core/WH3/TEB/character_skill_nodes_tables_AK_teb_LL_lucrezzia.tsv", "character_skill_nodes_tables");
    LoadFile("SkillTreeGenerator/DB/Core/WH3/Xoudad/character_skill_nodes_tables_dead_xou_gold.tsv", "character_skill_nodes_tables");
    LoadFile("SkillTreeGenerator/DB/Core/WH3/MixuShadowdancer/character_skill_nodes_tables_ab_mixu_shadowdancer.tsv", "character_skill_nodes_tables");
    LoadFile("SkillTreeGenerator/DB/Core/WH3/XoudadUglies/db/character_skill_nodes_tables/@xou_nur_tamurkhan.tsv", "character_skill_nodes_tables");
    LoadFile("SkillTreeGenerator/DB/Core/WH3/XoudadDragonMage/db/character_skill_nodes_tables/@xou_high_elves.tsv", "character_skill_nodes_tables");
    return VanillaDBs;
end

function LoadFile(fileName, addToFileName)
    print("Loading: "..fileName);
    local lineNumber = 1;
    local file = assert(io.open(fileName, "r"));

    local fileKey = fileName;
    if addToFileName ~= nil then
        fileKey = addToFileName;
    end
    -- We track the first line to ensure compatibility
    -- with both the old and new RPFM formats
    local firstLine = "";
    local newTable = false;
    for line in file:lines() do
        local fields = Split(line, "\t");
        if lineNumber == 1
        and VanillaDBs[fileKey] == nil then
            VanillaDBs[fileKey] = Table:new({
                Header = {},
                Columns = {},
                Data = {},
            });
            VanillaDBs[fileKey]:AddToHeader(fields);
            firstLine = line;
            newTable = true;
        elseif lineNumber == 1 then
            firstLine = line; 
            newTable = false;
        elseif lineNumber == 2 then
            -- If the table didn't split and the first record has a #
            -- This indicates it using the newer RPFM format
            if newTable == true then
                if string.match(fields[1], "#") then
                    -- Split the line into via semicolons and then
                    -- split the last chunk by /
                    fields = Split(firstLine, "\t");
                    VanillaDBs[fileKey]:SetMetadata(line);
                end
                local columnHeadingIndexes = {};
                for index, columnKey in pairs(fields) do
                    columnHeadingIndexes[columnKey] = index;
                end
                VanillaDBs[fileKey]:AddColumns(columnHeadingIndexes);
            end
        elseif lineNumber > 2 then
            VanillaDBs[fileKey]:AddRows(fields);
        end
        lineNumber = lineNumber + 1;
    end
    file:close();
end

function Split(s, delimiter)
    local result = {};
    for match in (s..delimiter):gmatch("(.-)"..delimiter) do
      result[#result + 1] = match;
    end
    return result;
end